#!/usr/bin/env bash

# PostgreSQL Recovery Helper Script
# This script provides a user-friendly interface to recover PostgreSQL databases

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_header() {
    echo -e "${BLUE}============================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}============================================${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

confirm() {
    local prompt="$1"
    local default="${2:-n}"

    if [ "$default" = "y" ]; then
        prompt="$prompt [Y/n]: "
    else
        prompt="$prompt [y/N]: "
    fi

    read -p "$prompt" -n 1 -r
    echo

    if [ "$default" = "y" ]; then
        [[ $REPLY =~ ^[Nn]$ ]] && return 1 || return 0
    else
        [[ $REPLY =~ ^[Yy]$ ]] && return 0 || return 1
    fi
}

list_backups() {
    local release="$1"
    local namespace="${2:-default}"

    print_info "Available backups:"
    echo ""

    kubectl exec -n "$namespace" \
        "$(kubectl get pod -n "$namespace" -l app.kubernetes.io/instance=$release -o jsonpath='{.items[0].metadata.name}')" \
        -- sh -c 'ls -lht /backups/backup-*.sql.gz 2>/dev/null | head -10' || {
        print_error "Could not list backups"
        return 1
    }
    echo ""
}

check_prerequisites() {
    local release="$1"
    local namespace="${2:-default}"

    print_header "Checking Prerequisites"

    # Check kubectl
    if ! command -v kubectl &> /dev/null; then
        print_error "kubectl not found. Please install kubectl."
        exit 1
    fi
    print_success "kubectl is installed"

    # Check helm
    if ! command -v helm &> /dev/null; then
        print_error "helm not found. Please install Helm."
        exit 1
    fi
    print_success "helm is installed"

    # Check if release exists
    if ! helm list -n "$namespace" | grep -q "$release"; then
        print_error "Release '$release' not found in namespace '$namespace'"
        exit 1
    fi
    print_success "Release '$release' found"

    # Check if backup PVC exists
    if ! kubectl get pvc -n "$namespace" | grep -q "$release-postgresql-backup"; then
        print_error "Backup PVC not found. Backup must be enabled."
        exit 1
    fi
    print_success "Backup PVC exists"

    echo ""
}

recover_full() {
    local release="$1"
    local namespace="${2:-default}"
    local backup_file="$3"

    print_header "Full Backup Recovery"

    print_info "This will:"
    print_info "  1. Stop the PostgreSQL instance"
    print_info "  2. Restore from backup"
    print_info "  3. Restart PostgreSQL"
    echo ""
    print_warning "ALL CURRENT DATA WILL BE REPLACED!"
    echo ""

    if ! confirm "Continue with recovery?" "n"; then
        print_info "Recovery cancelled"
        exit 0
    fi

    # Create recovery values
    cat > /tmp/recovery-values.yaml <<EOF
recovery:
  enabled: true
  mode: "full"
  source: "backup"
  backupFile: "$backup_file"
  tempStorageSize: "50Gi"
EOF

    print_info "Upgrading release with recovery mode..."
    helm upgrade "$release" . -n "$namespace" -f /tmp/recovery-values.yaml

    print_success "Recovery job started!"
    print_info "Monitor progress with: kubectl logs -n $namespace job/$release-postgresql-recovery -f"

    rm /tmp/recovery-values.yaml
}

recover_pitr() {
    local release="$1"
    local namespace="${2:-default}"
    local target_time="$3"
    local backup_file="$4"

    print_header "Point-in-Time Recovery (PITR)"

    print_info "Recovery target time: $target_time"
    if [ -n "$backup_file" ]; then
        print_info "Using backup: $backup_file"
    else
        print_info "Using latest backup"
    fi
    echo ""

    print_info "This will:"
    print_info "  1. Stop the PostgreSQL instance"
    print_info "  2. Restore from full backup"
    print_info "  3. Replay WAL archives up to target time"
    print_info "  4. Restart PostgreSQL"
    echo ""
    print_warning "ALL CURRENT DATA WILL BE REPLACED!"
    echo ""

    if ! confirm "Continue with PITR?" "n"; then
        print_info "Recovery cancelled"
        exit 0
    fi

    # Create recovery values
    cat > /tmp/recovery-values.yaml <<EOF
recovery:
  enabled: true
  mode: "pitr"
  source: "backup"
  targetTime: "$target_time"
  backupFile: "$backup_file"
  tempStorageSize: "50Gi"

backup:
  wal:
    enabled: true
EOF

    print_info "Upgrading release with PITR mode..."
    helm upgrade "$release" . -n "$namespace" -f /tmp/recovery-values.yaml

    print_success "PITR job started!"
    print_info "Monitor progress with: kubectl logs -n $namespace job/$release-postgresql-recovery -f"

    rm /tmp/recovery-values.yaml
}

show_usage() {
    cat << EOF
PostgreSQL Recovery Helper

Usage: $0 <command> [options]

Commands:
    list <release> [namespace]
        List available backups

    recover <release> [namespace]
        Interactive recovery wizard

    recover-full <release> [namespace] [backup-file]
        Restore from full backup

    recover-pitr <release> <target-time> [namespace] [backup-file]
        Point-in-Time Recovery
        Target time format: 'YYYY-MM-DD HH:MM:SS' (UTC)

    status <release> [namespace]
        Check recovery job status

    logs <release> [namespace]
        Follow recovery job logs

Examples:
    # List backups
    $0 list my-postgres

    # Interactive recovery
    $0 recover my-postgres

    # Recover from specific backup
    $0 recover-full my-postgres default backup-2024-11-12-02-00-00.sql.gz

    # Point-in-Time Recovery
    $0 recover-pitr my-postgres "2024-11-12 14:30:00"

    # Check recovery status
    $0 status my-postgres

EOF
}

interactive_recovery() {
    local release="$1"
    local namespace="${2:-default}"

    print_header "PostgreSQL Recovery Wizard"

    # Check prerequisites
    check_prerequisites "$release" "$namespace"

    # List backups
    list_backups "$release" "$namespace"

    # Ask recovery type
    echo "Select recovery type:"
    echo "  1) Full backup recovery (restore entire backup)"
    echo "  2) Point-in-Time Recovery (PITR - restore to specific time)"
    echo ""
    read -p "Choice [1-2]: " recovery_type

    case $recovery_type in
        1)
            read -p "Backup file name (or press Enter for latest): " backup_file
            recover_full "$release" "$namespace" "$backup_file"
            ;;
        2)
            read -p "Target time (YYYY-MM-DD HH:MM:SS UTC): " target_time
            read -p "Backup file name (or press Enter for latest): " backup_file

            # Validate time format
            if ! date -d "$target_time" &>/dev/null 2>&1 && ! date -j -f "%Y-%m-%d %H:%M:%S" "$target_time" &>/dev/null 2>&1; then
                print_error "Invalid time format. Use: YYYY-MM-DD HH:MM:SS"
                exit 1
            fi

            recover_pitr "$release" "$namespace" "$target_time" "$backup_file"
            ;;
        *)
            print_error "Invalid choice"
            exit 1
            ;;
    esac
}

check_status() {
    local release="$1"
    local namespace="${2:-default}"

    print_header "Recovery Status"

    if kubectl get job -n "$namespace" "$release-postgresql-recovery" &>/dev/null; then
        kubectl get job -n "$namespace" "$release-postgresql-recovery"
        echo ""
        print_info "Recovery job exists"

        # Check if completed
        if kubectl get job -n "$namespace" "$release-postgresql-recovery" -o jsonpath='{.status.succeeded}' | grep -q "1"; then
            print_success "Recovery completed successfully!"
        elif kubectl get job -n "$namespace" "$release-postgresql-recovery" -o jsonpath='{.status.failed}' | grep -q "1"; then
            print_error "Recovery failed!"
        else
            print_info "Recovery in progress..."
        fi
    else
        print_info "No recovery job found"
    fi
}

show_logs() {
    local release="$1"
    local namespace="${2:-default}"

    print_info "Following recovery logs..."
    echo ""

    kubectl logs -n "$namespace" "job/$release-postgresql-recovery" -f || {
        print_error "Could not get logs. Job may not exist yet."
        exit 1
    }
}

# Main
case "${1:-}" in
    list)
        [ -z "$2" ] && { show_usage; exit 1; }
        list_backups "$2" "${3:-default}"
        ;;
    recover)
        [ -z "$2" ] && { show_usage; exit 1; }
        interactive_recovery "$2" "${3:-default}"
        ;;
    recover-full)
        [ -z "$2" ] && { show_usage; exit 1; }
        recover_full "$2" "${3:-default}" "$4"
        ;;
    recover-pitr)
        [ -z "$2" ] || [ -z "$3" ] && { show_usage; exit 1; }
        recover_pitr "$2" "$4" "$3" "$5"
        ;;
    status)
        [ -z "$2" ] && { show_usage; exit 1; }
        check_status "$2" "${3:-default}"
        ;;
    logs)
        [ -z "$2" ] && { show_usage; exit 1; }
        show_logs "$2" "${3:-default}"
        ;;
    help|--help|-h|"")
        show_usage
        ;;
    *)
        print_error "Unknown command: $1"
        echo ""
        show_usage
        exit 1
        ;;
esac
