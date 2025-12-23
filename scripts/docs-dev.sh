#!/usr/bin/env bash
#
# Development script for Helm Charts documentation
# Provides a user-friendly way to preview and develop documentation locally
# Uses uv for fast Python package management
#
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
DOCS_PORT="${DOCS_PORT:-8000}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color
BOLD='\033[1m'

print_header() {
    echo -e "\n${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${BLUE}  $1${NC}"
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════════════════${NC}\n"
}

print_info() {
    echo -e "${CYAN}ℹ️  $1${NC}"
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

check_uv() {
    if ! command -v uv &> /dev/null; then
        print_error "uv is required but not installed."
        echo -e "Install it with: ${BOLD}curl -LsSf https://astral.sh/uv/install.sh | sh${NC}"
        echo -e "Or see: ${CYAN}https://docs.astral.sh/uv/${NC}"
        exit 1
    fi
}

install_deps() {
    # Use uv sync to install dependencies from pyproject.toml
    print_info "Syncing dependencies..."
    uv sync --quiet
    print_success "Dependencies synced"
}

generate_docs() {
    print_info "Generating documentation from chart values..."
    uv run python "$REPO_ROOT/scripts/generate-docs.py"
    print_success "Documentation generated"
}

serve_docs() {
    print_header "📚 Helm Charts Documentation Server"
    
    echo -e "${BOLD}Server Information:${NC}"
    echo -e "  ${GREEN}►${NC} URL:         ${BOLD}http://localhost:$DOCS_PORT${NC}"
    echo -e "  ${GREEN}►${NC} Live Reload: ${GREEN}Enabled${NC}"
    echo -e "  ${GREEN}►${NC} Auto-open:   Edit files and browser refreshes automatically"
    echo ""
    echo -e "${BOLD}Keyboard Shortcuts (in browser):${NC}"
    echo -e "  ${CYAN}Ctrl+K / Cmd+K${NC}  - Open search"
    echo -e "  ${CYAN}S or F${NC}          - Focus search"
    echo -e "  ${CYAN}Escape${NC}          - Close search"
    echo ""
    echo -e "${YELLOW}Press Ctrl+C to stop the server${NC}"
    echo ""
    
    uv run mkdocs serve -a "localhost:$DOCS_PORT" --open
}

build_docs() {
    print_info "Building documentation site..."
    uv run mkdocs build -d "$REPO_ROOT/site-docs"
    print_success "Documentation built to site-docs/"
    echo ""
    echo -e "To view locally: ${BOLD}open site-docs/index.html${NC}"
}

show_help() {
    print_header "🔧 Helm Charts Documentation Development"
    
    echo -e "${BOLD}Usage:${NC}"
    echo -e "  $0 ${CYAN}<command>${NC}"
    echo ""
    echo -e "${BOLD}Commands:${NC}"
    echo -e "  ${CYAN}serve${NC}      Start local development server with live reload (default)"
    echo -e "  ${CYAN}build${NC}      Build static documentation site"
    echo -e "  ${CYAN}generate${NC}   Regenerate docs from chart values only"
    echo -e "  ${CYAN}sync${NC}       Sync charts with docs (add new, remove deleted)"
    echo -e "  ${CYAN}check${NC}      Check if charts and docs are in sync"
    echo -e "  ${CYAN}open${NC}       Open built documentation in browser"
    echo -e "  ${CYAN}clean${NC}      Remove generated documentation files"
    echo -e "  ${CYAN}help${NC}       Show this help message"
    echo ""
    echo -e "${BOLD}Environment Variables:${NC}"
    echo -e "  ${CYAN}DOCS_PORT${NC}  Port for development server (default: 8000)"
    echo ""
    echo -e "${BOLD}Examples:${NC}"
    echo -e "  $0 serve              # Start dev server on port 8000"
    echo -e "  DOCS_PORT=3000 $0 serve  # Start dev server on port 3000"
    echo -e "  $0 build              # Build for production"
    echo -e "  $0 sync               # Sync after adding/removing charts"
    echo ""
    echo -e "${BOLD}Requirements:${NC}"
    echo -e "  ${CYAN}uv${NC} - Fast Python package manager (https://docs.astral.sh/uv/)"
    echo ""
}

clean_docs() {
    print_info "Cleaning documentation artifacts..."
    rm -rf "$REPO_ROOT/site-docs"
    rm -rf "$REPO_ROOT/docs/charts"/*.md 2>/dev/null || true
    rm -f "$REPO_ROOT/docs/reference/search.md" "$REPO_ROOT/docs/reference/values-index.md" 2>/dev/null || true
    rm -f "$REPO_ROOT/docs/assets/javascripts/values-index.json" 2>/dev/null || true
    print_success "Documentation artifacts cleaned"
}

open_docs() {
    if [ -f "$REPO_ROOT/site-docs/index.html" ]; then
        print_info "Opening documentation in browser..."
        if command -v open &> /dev/null; then
            open "$REPO_ROOT/site-docs/index.html"
        elif command -v xdg-open &> /dev/null; then
            xdg-open "$REPO_ROOT/site-docs/index.html"
        else
            print_warning "Could not detect browser opener. Please open manually:"
            echo "  $REPO_ROOT/site-docs/index.html"
        fi
    else
        print_warning "Documentation not built yet."
        echo -e "Run ${BOLD}$0 build${NC} first."
    fi
}

sync_docs() {
    print_info "Syncing charts with documentation..."
    uv run python "$REPO_ROOT/scripts/sync-chart-docs.py"
}

check_sync() {
    print_info "Checking if charts and docs are in sync..."
    uv run python "$REPO_ROOT/scripts/sync-chart-docs.py" --check
}

# Main entry point
main() {
    cd "$REPO_ROOT"
    check_uv
    
    case "${1:-serve}" in
        serve|s|dev|start)
            install_deps
            generate_docs
            serve_docs
            ;;
        build|b)
            install_deps
            generate_docs
            build_docs
            ;;
        generate|gen|g)
            install_deps
            generate_docs
            ;;
        sync)
            install_deps
            sync_docs
            ;;
        check)
            install_deps
            check_sync
            ;;
        open|o)
            open_docs
            ;;
        clean|c)
            clean_docs
            ;;
        help|h|--help|-h)
            show_help
            ;;
        *)
            print_error "Unknown command: $1"
            show_help
            exit 1
            ;;
    esac
}

main "$@"
