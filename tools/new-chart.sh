#!/usr/bin/env bash
# new-chart.sh — Create a new Helm chart from the Copier template.
#
# Usage:
#   ./tools/new-chart.sh                          # Interactive (prompts for destination)
#   ./tools/new-chart.sh charts/apps/my-app       # Direct destination
#   ./tools/new-chart.sh --help                    # Show help
#
# Requires: copier >= 9.0.0 (install via: uv tool install copier)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE_DIR="$REPO_ROOT/templates/chart-copier"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

usage() {
    echo -e "${BLUE}⎈ Helm Chart Generator${NC}"
    echo ""
    echo "Creates a new Helm chart from the Copier template."
    echo ""
    echo -e "${YELLOW}Usage:${NC}"
    echo "  $0 [DESTINATION]"
    echo ""
    echo -e "${YELLOW}Arguments:${NC}"
    echo "  DESTINATION   Path where the chart will be created (e.g. charts/apps/my-app)"
    echo "                If omitted, you will be prompted."
    echo ""
    echo -e "${YELLOW}Options:${NC}"
    echo "  --help, -h    Show this help message"
    echo "  --update, -u  Update an existing chart from the template"
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo "  $0 charts/apps/my-api"
    echo "  $0 --update charts/apps/my-api"
}

check_copier() {
    if ! command -v copier &>/dev/null; then
        echo -e "${RED}❌ copier not found.${NC}"
        echo ""
        echo "Install it with one of:"
        echo "  uv tool install copier"
        echo "  pipx install copier"
        echo "  pip install copier"
        exit 1
    fi

    local version
    version=$(copier --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1)
    local major
    major=$(echo "$version" | cut -d. -f1)
    if [[ -n "$major" ]] && [[ "$major" -lt 9 ]]; then
        echo -e "${YELLOW}⚠️  Copier version $version detected. Version 9.0.0+ is recommended.${NC}"
    fi
}

main() {
    if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
        usage
        exit 0
    fi

    check_copier

    if [[ "${1:-}" == "--update" || "${1:-}" == "-u" ]]; then
        local target="${2:-}"
        if [[ -z "$target" ]]; then
            echo -e "${RED}❌ Please specify the chart to update.${NC}"
            echo "Usage: $0 --update charts/apps/my-app"
            exit 1
        fi
        echo -e "${BLUE}⎈ Updating chart from template...${NC}"
        copier update --trust "$target"
        echo -e "${GREEN}✅ Chart updated.${NC}"
        exit 0
    fi

    local dest="${1:-}"
    if [[ -z "$dest" ]]; then
        echo -e "${BLUE}⎈ Helm Chart Generator${NC}"
        echo ""
        read -rp "Destination path (e.g. charts/apps/my-app): " dest
        if [[ -z "$dest" ]]; then
            echo -e "${RED}❌ No destination specified.${NC}"
            exit 1
        fi
    fi

    echo -e "${BLUE}⎈ Creating new chart at ${dest}...${NC}"
    copier copy --trust "$TEMPLATE_DIR" "$dest"

    echo ""
    echo -e "${GREEN}✅ Chart created at ${dest}${NC}"
    echo ""
    echo -e "${YELLOW}Next steps:${NC}"
    echo "  1. Review the generated files"
    echo "  2. Run: helm lint ${dest}"
    echo "  3. Run: helm template test ${dest}"
}

main "$@"