#!/usr/bin/env bash
# update-charts.sh — Discover and update all Copier-managed Helm charts.
#
# Usage:
#   ./tools/update-charts.sh                    # Update all managed charts (interactive)
#   ./tools/update-charts.sh --defaults         # Update all, using saved answers (no prompts)
#   ./tools/update-charts.sh --pretend          # Dry-run: show changes without applying
#   ./tools/update-charts.sh --list             # List all managed charts
#   ./tools/update-charts.sh charts/apps/my-app # Update a specific chart
#   ./tools/update-charts.sh --help             # Show this help
#
# Requires: copier >= 9.0.0
#   Install: uv tool install copier

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$REPO_ROOT/templates/chart-copier"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# Counters
UPDATED=0
FAILED=0
SKIPPED=0

usage() {
    echo -e "${BOLD}${BLUE}⎈  Helm Chart Update Manager${NC}"
    echo ""
    echo "Discovers and updates all Copier-managed Helm charts in this repository."
    echo ""
    echo -e "${YELLOW}Usage:${NC}"
    echo "  $0 [OPTIONS] [CHART_DIR]"
    echo ""
    echo -e "${YELLOW}Options:${NC}"
    echo "  -l, --list       List all managed charts without updating"
    echo "  -p, --pretend    Dry-run: show what would change, apply nothing"
    echo "  -d, --defaults   Skip prompts, use saved answers from .copier-answers.yml"
    echo "  -h, --help       Show this help message"
    echo ""
    echo -e "${YELLOW}Arguments:${NC}"
    echo "  CHART_DIR        Path to a specific chart to update (e.g. charts/apps/my-app)"
    echo "                   If omitted, all managed charts are updated."
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo "  $0 --list"
    echo "  $0 --pretend"
    echo "  $0 --defaults"
    echo "  $0 charts/apps/my-api"
    echo "  $0 --defaults charts/apps/my-api"
}

check_copier() {
    if ! command -v copier &>/dev/null; then
        echo -e "${RED}❌ copier not found.${NC}"
        echo ""
        echo "Install with: uv tool install copier"
        exit 1
    fi
}

check_template() {
    if [[ ! -f "$TEMPLATE_DIR/copier.yml" ]]; then
        echo -e "${RED}❌ Template not found at: $TEMPLATE_DIR${NC}"
        echo "Expected file: $TEMPLATE_DIR/copier.yml"
        exit 1
    fi
}

# Find all copier-managed charts: directories containing .copier-answers.yml
find_managed_charts() {
    find "$REPO_ROOT/charts" -name ".copier-answers.yml" -not -path "*/node_modules/*" \
        | sort \
        | while read -r answers_file; do
            dirname "$answers_file"
        done
}

# Get chart name from Chart.yaml (fallback to dirname)
get_chart_name() {
    local chart_dir="$1"
    local chart_yaml="$chart_dir/Chart.yaml"
    if [[ -f "$chart_yaml" ]]; then
        grep -m1 '^name:' "$chart_yaml" | awk '{print $2}' 2>/dev/null || basename "$chart_dir"
    else
        basename "$chart_dir"
    fi
}

# Check if chart has the copier-managed annotation
get_chart_version() {
    local chart_dir="$1"
    local chart_yaml="$chart_dir/Chart.yaml"
    if [[ -f "$chart_yaml" ]]; then
        grep -m1 '^version:' "$chart_yaml" | awk '{print $2}' 2>/dev/null || "unknown"
    else
        echo "unknown"
    fi
}

list_charts() {
    echo -e "${BOLD}${BLUE}⎈  Copier-Managed Helm Charts${NC}"
    echo ""

    local charts
    charts=$(find_managed_charts)

    if [[ -z "$charts" ]]; then
        echo -e "${YELLOW}  No copier-managed charts found in charts/${NC}"
        echo ""
        echo "  Charts are managed when they contain a .copier-answers.yml file."
        echo "  Create a new chart with: ./tools/new-chart.sh charts/apps/my-app"
        return
    fi

    local count=0
    echo -e "  ${CYAN}PATH${NC}                              ${CYAN}NAME${NC}                    ${CYAN}VERSION${NC}"
    echo "  ─────────────────────────────────────────────────────────────────"
    while IFS= read -r chart_dir; do
        local rel_path
        rel_path="${chart_dir#$REPO_ROOT/}"
        local name
        name=$(get_chart_name "$chart_dir")
        local version
        version=$(get_chart_version "$chart_dir")
        printf "  %-34s %-24s %s\n" "$rel_path" "$name" "$version"
        count=$((count + 1))
    done <<< "$charts"
    echo ""
    echo -e "  ${GREEN}${count} managed chart(s) found.${NC}"
    echo ""
    echo -e "  Update all:    ${YELLOW}./tools/update-charts.sh --defaults${NC}"
    echo -e "  Update one:    ${YELLOW}./tools/update-charts.sh charts/apps/<name>${NC}"
    echo -e "  Preview:       ${YELLOW}./tools/update-charts.sh --pretend${NC}"
}

update_chart() {
    local chart_dir="$1"
    local pretend="${2:-false}"
    local use_defaults="${3:-false}"

    local name
    name=$(get_chart_name "$chart_dir")
    local rel_path="${chart_dir#$REPO_ROOT/}"

    echo -e "${BLUE}⎈  Updating:${NC} ${BOLD}$name${NC} (${rel_path})"

    if [[ ! -f "$chart_dir/.copier-answers.yml" ]]; then
        echo -e "   ${YELLOW}⚠️  Skipping — no .copier-answers.yml found${NC}"
        SKIPPED=$((SKIPPED + 1))
        return 0
    fi

    # Patch _src_path in .copier-answers.yml to ensure portability across machines/checkouts.
    # copier recopy reads the source path from this file; there is no --src-path flag.
    local tmp
    tmp=$(mktemp)
    sed "s|^_src_path:.*|_src_path: $TEMPLATE_DIR|" "$chart_dir/.copier-answers.yml" > "$tmp"
    mv "$tmp" "$chart_dir/.copier-answers.yml"

    # Use `copier recopy` (not `copier update`) for local, non-VCS-tagged templates.
    # recopy regenerates files from the template using saved answers, merging changes
    # with conflict markers. It does NOT require a clean git working tree.
    local copier_args=(
        recopy
        --trust
        --overwrite
    )

    if [[ "$pretend" == "true" ]]; then
        copier_args+=(--pretend)
    fi

    if [[ "$use_defaults" == "true" ]]; then
        copier_args+=(--defaults)
    fi

    copier_args+=("$chart_dir")

    if copier "${copier_args[@]}"; then
        echo -e "   ${GREEN}✅ Updated successfully${NC}"
        UPDATED=$((UPDATED + 1))
    else
        echo -e "   ${RED}❌ Update failed${NC}"
        FAILED=$((FAILED + 1))
    fi
    echo ""
}

main() {
    local mode="update"
    local pretend="false"
    local use_defaults="false"
    local specific_chart=""

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -h|--help)
                usage
                exit 0
                ;;
            -l|--list)
                mode="list"
                shift
                ;;
            -p|--pretend)
                pretend="true"
                shift
                ;;
            -d|--defaults)
                use_defaults="true"
                shift
                ;;
            -*)
                echo -e "${RED}❌ Unknown option: $1${NC}"
                echo "Run '$0 --help' for usage."
                exit 1
                ;;
            *)
                specific_chart="$1"
                shift
                ;;
        esac
    done

    if [[ "$mode" == "list" ]]; then
        list_charts
        exit 0
    fi

    check_copier
    check_template

    if [[ -n "$specific_chart" ]]; then
        # Resolve to absolute path
        local chart_abs
        if [[ "$specific_chart" = /* ]]; then
            chart_abs="$specific_chart"
        else
            chart_abs="$REPO_ROOT/$specific_chart"
        fi

        if [[ ! -d "$chart_abs" ]]; then
            echo -e "${RED}❌ Chart directory not found: $specific_chart${NC}"
            exit 1
        fi

        echo -e "${BOLD}${BLUE}⎈  Chart Update Manager${NC}"
        echo ""
        update_chart "$chart_abs" "$pretend" "$use_defaults"
    else
        local charts
        charts=$(find_managed_charts) || true

        if [[ -z "$charts" ]]; then
            echo -e "${YELLOW}⚠️  No copier-managed charts found in charts/${NC}"
            echo "   Create a chart with: ./tools/new-chart.sh charts/apps/my-app"
            exit 0
        fi

        echo -e "${BOLD}${BLUE}⎈  Updating all managed charts${NC}"
        if [[ "$pretend" == "true" ]]; then
            echo -e "   ${YELLOW}(dry-run mode — no changes will be applied)${NC}"
        fi
        echo ""

        while IFS= read -r chart_dir; do
            update_chart "$chart_dir" "$pretend" "$use_defaults"
        done <<< "$charts"
    fi

    # Summary
    echo -e "${BOLD}────────────────────────────────${NC}"
    echo -e "  ${GREEN}✅ Updated:${NC} $UPDATED"
    if [[ $FAILED -gt 0 ]]; then
        echo -e "  ${RED}❌ Failed:${NC}  $FAILED"
    fi
    if [[ $SKIPPED -gt 0 ]]; then
        echo -e "  ${YELLOW}⚠️  Skipped:${NC} $SKIPPED"
    fi
    echo ""

    if [[ $FAILED -gt 0 ]]; then
        exit 1
    fi
}

main "$@"
