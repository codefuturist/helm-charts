#!/usr/bin/env bash
# copier-recopy.sh — Pre-commit hook to regenerate Copier-managed Helm charts.
#
# When the Copier template source (templates/chart-copier/) changes, this hook
# runs `copier recopy` on every chart that has a .copier-answers.yml file,
# ensuring all managed charts stay in sync with the template.
#
# Usage (standalone):
#   ./scripts/hooks/copier-recopy.sh
#
# Usage (pre-commit):
#   Triggered automatically when files under templates/chart-copier/ are staged.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TEMPLATE_DIR="$REPO_ROOT/templates/chart-copier"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counters
UPDATED=0
FAILED=0
SKIPPED=0
HAS_CONFLICTS=0

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

check_copier() {
  if ! command -v copier &>/dev/null; then
    echo -e "${YELLOW}⚠️  copier not found — skipping chart recopy.${NC}"
    echo "   Install with: uv tool install copier"
    exit 0
  fi
}

check_template() {
  if [[ ! -f "$TEMPLATE_DIR/copier.yml" ]]; then
    echo -e "${YELLOW}⚠️  Copier template not found at $TEMPLATE_DIR — skipping.${NC}"
    exit 0
  fi
}

find_managed_charts() {
  find "$REPO_ROOT/charts" -name ".copier-answers.yml" -not -path "*/node_modules/*" \
    | sort \
    | while read -r answers_file; do
      dirname "$answers_file"
    done
}

recopy_chart() {
  local chart_dir="$1"
  local rel_path="${chart_dir#"$REPO_ROOT"/}"

  echo -e "${BLUE}⎈  Recopy:${NC} $rel_path"

  # Patch _src_path to ensure portability
  local tmp
  tmp=$(mktemp)
  sed "s|^_src_path:.*|_src_path: $TEMPLATE_DIR|" "$chart_dir/.copier-answers.yml" >"$tmp"
  mv "$tmp" "$chart_dir/.copier-answers.yml"

  if copier recopy --trust --overwrite --defaults "$chart_dir" 2>&1; then
    # Check for conflict markers in generated files
    if grep -rq '<<<<<<< ' "$chart_dir" 2>/dev/null; then
      echo -e "   ${YELLOW}⚠️  Conflict markers detected — manual resolution needed${NC}"
      HAS_CONFLICTS=1
    else
      echo -e "   ${GREEN}✅ Updated${NC}"
    fi
    UPDATED=$((UPDATED + 1))
  else
    echo -e "   ${RED}❌ Failed${NC}"
    FAILED=$((FAILED + 1))
  fi
}

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

main() {
  check_copier
  check_template

  local charts
  charts=$(find_managed_charts) || true

  if [[ -z "$charts" ]]; then
    echo -e "${YELLOW}⚠️  No copier-managed charts found (no .copier-answers.yml files).${NC}"
    exit 0
  fi

  echo -e "${BLUE}⎈  Copier Recopy — regenerating managed charts from template${NC}"
  echo ""

  while IFS= read -r chart_dir; do
    recopy_chart "$chart_dir"
  done <<<"$charts"

  # Stage all changes made by copier
  while IFS= read -r chart_dir; do
    git add "$chart_dir" 2>/dev/null || true
  done <<<"$charts"

  # Summary
  echo ""
  echo -e "${GREEN}✅ Recopy complete:${NC} $UPDATED updated, $FAILED failed, $SKIPPED skipped"

  if [[ $HAS_CONFLICTS -gt 0 ]]; then
    echo -e "${YELLOW}⚠️  Some charts have conflict markers. Please resolve before committing.${NC}"
    exit 1
  fi

  if [[ $FAILED -gt 0 ]]; then
    exit 1
  fi

  exit 0
}

main "$@"
