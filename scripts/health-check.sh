#!/usr/bin/env bash
#
# Repository Health Check Script
# ==============================
# A comprehensive, reusable health check script for Helm chart repositories.
# Performs checks on repository structure, charts, documentation, CI/CD,
# GitHub configuration, and more.
#
# Usage:
#   ./scripts/health-check.sh [options]
#
# Options:
#   -v, --verbose    Enable verbose output
#   -q, --quiet      Only show errors and summary
#   -s, --strict     Fail on warnings (exit code 1)
#   --no-color       Disable colored output
#   --json           Output results as JSON
#   -h, --help       Show this help message
#
# Exit Codes:
#   0 - All checks passed
#   1 - One or more checks failed
#   2 - Script error (missing dependencies, etc.)
#
# Configuration:
#   The script auto-detects repository structure. To customize for your repo,
#   modify the REPO_CONFIG section below.
#

set -uo pipefail

# =============================================================================
# Repository Configuration (customize for your repository)
# =============================================================================

# Auto-detect paths - override these if your repo structure differs
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Chart directories - set to empty string "" to disable chart checks
# Supports multiple chart roots (space-separated within quotes)
CHARTS_DIR="${REPO_ROOT}/charts"
CHART_SUBDIRS="apps libs vendors"  # Subdirectories under CHARTS_DIR containing charts

# Documentation
DOCS_DIR="${REPO_ROOT}/docs"
SITE_DIR="${REPO_ROOT}/site"
SITE_DOCS_DIR="${REPO_ROOT}/site-docs"

# Test directories
TEST_DIR="${REPO_ROOT}/test"
TEST_SUBDIRS="fixtures e2e integration unit"

# Templates
TEMPLATES_DIR="${REPO_ROOT}/templates"

# Scripts
SCRIPTS_DIR="${REPO_ROOT}/scripts"

# GitHub workflows
REQUIRED_WORKFLOWS="lint-test.yaml release.yaml docs.yaml"

# Required tools (space-separated)
REQUIRED_TOOLS="helm git yq python3"
OPTIONAL_TOOLS="uv helm-docs ct pre-commit yamllint"

# Helm plugins to check
HELM_PLUGINS="unittest"

# Enable/disable check categories (set to "true" or "false")
CHECK_DEPENDENCIES="${CHECK_DEPENDENCIES:-true}"
CHECK_STRUCTURE="${CHECK_STRUCTURE:-true}"
CHECK_CHARTS="${CHECK_CHARTS:-true}"
CHECK_DOCUMENTATION="${CHECK_DOCUMENTATION:-true}"
CHECK_GIT="${CHECK_GIT:-true}"
CHECK_CICD="${CHECK_CICD:-true}"
CHECK_GITHUB_PAGES="${CHECK_GITHUB_PAGES:-true}"
CHECK_GITHUB_HEALTH="${CHECK_GITHUB_HEALTH:-true}"
CHECK_PYTHON="${CHECK_PYTHON:-true}"
CHECK_SECURITY="${CHECK_SECURITY:-true}"

# =============================================================================
# Runtime Options (do not modify)
# =============================================================================

# Default options
VERBOSE=false
QUIET=false
STRICT=false
NO_COLOR=false
JSON_OUTPUT=false

# Counters
CHECKS_PASSED=0
CHECKS_FAILED=0
CHECKS_WARNED=0
CHECKS_SKIPPED=0

# Results for JSON output
declare -a JSON_RESULTS=()

# =============================================================================
# Color Definitions
# =============================================================================

setup_colors() {
    if [[ "${NO_COLOR}" == "true" ]] || [[ ! -t 1 ]]; then
        RED=""
        GREEN=""
        YELLOW=""
        BLUE=""
        CYAN=""
        MAGENTA=""
        BOLD=""
        DIM=""
        RESET=""
    else
        RED='\033[0;31m'
        GREEN='\033[0;32m'
        YELLOW='\033[0;33m'
        BLUE='\033[0;34m'
        CYAN='\033[0;36m'
        MAGENTA='\033[0;35m'
        BOLD='\033[1m'
        DIM='\033[2m'
        RESET='\033[0m'
    fi
}

# =============================================================================
# Logging Functions
# =============================================================================

log_info() {
    [[ "${QUIET}" == "true" ]] && return
    echo -e "${BLUE}ℹ${RESET} $*"
}

log_verbose() {
    [[ "${VERBOSE}" != "true" ]] && return
    echo -e "${DIM}  → $*${RESET}"
}

log_success() {
    [[ "${QUIET}" == "true" ]] && return
    echo -e "${GREEN}✓${RESET} $*"
}

log_warning() {
    [[ "${JSON_OUTPUT}" == "true" ]] && return
    echo -e "${YELLOW}⚠${RESET} $*"
}

log_error() {
    [[ "${JSON_OUTPUT}" == "true" ]] && return
    echo -e "${RED}✗${RESET} $*"
}

log_section() {
    [[ "${QUIET}" == "true" ]] && return
    echo ""
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${RESET}"
    echo -e "${BOLD}${CYAN}  $*${RESET}"
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════════${RESET}"
}

log_subsection() {
    [[ "${QUIET}" == "true" ]] && return
    echo ""
    echo -e "${BOLD}  $*${RESET}"
    echo -e "  ${DIM}─────────────────────────────────────────────────────────────${RESET}"
}

# =============================================================================
# Result Recording
# =============================================================================

record_result() {
    local status="$1"
    local category="$2"
    local check="$3"
    local message="${4:-}"
    local details="${5:-}"
    
    case "${status}" in
        pass)
            ((CHECKS_PASSED++))
            log_success "${check}: ${message}"
            ;;
        fail)
            ((CHECKS_FAILED++))
            log_error "${check}: ${message}"
            [[ -n "${details}" ]] && log_verbose "${details}"
            ;;
        warn)
            ((CHECKS_WARNED++))
            log_warning "${check}: ${message}"
            [[ -n "${details}" ]] && log_verbose "${details}"
            ;;
        skip)
            ((CHECKS_SKIPPED++))
            log_info "${check}: ${message} (skipped)"
            ;;
    esac
    
    if [[ "${JSON_OUTPUT}" == "true" ]]; then
        JSON_RESULTS+=("{\"status\":\"${status}\",\"category\":\"${category}\",\"check\":\"${check}\",\"message\":\"${message}\"}")
    fi
}

# =============================================================================
# Dependency Checks
# =============================================================================

check_dependencies() {
    [[ "${CHECK_DEPENDENCIES}" != "true" ]] && return
    
    log_section "Checking Required Dependencies"
    
    # Convert space-separated strings to arrays
    read -ra required_tools <<< "${REQUIRED_TOOLS}"
    read -ra optional_tools <<< "${OPTIONAL_TOOLS}"
    
    log_subsection "Required Tools"
    for tool in "${required_tools[@]}"; do
        if command -v "${tool}" &>/dev/null; then
            local version=""
            case "${tool}" in
                helm)     version=$(helm version --short 2>/dev/null | head -1 || echo "unknown") ;;
                git)      version=$(git --version 2>/dev/null | awk '{print $3}' || echo "unknown") ;;
                yq)       version=$(yq --version 2>/dev/null | head -1 | awk '{print $NF}' || echo "unknown") ;;
                python3)  version=$(python3 --version 2>/dev/null | awk '{print $2}' || echo "unknown") ;;
                node)     version=$(node --version 2>/dev/null || echo "unknown") ;;
                go)       version=$(go version 2>/dev/null | awk '{print $3}' || echo "unknown") ;;
                docker)   version=$(docker --version 2>/dev/null | awk '{print $3}' | tr -d ',' || echo "unknown") ;;
                kubectl)  version=$(kubectl version --client --short 2>/dev/null | awk '{print $3}' || echo "unknown") ;;
                *)        version=$(${tool} --version 2>/dev/null | head -1 || echo "installed") ;;
            esac
            record_result "pass" "dependencies" "${tool}" "Found (${version:-unknown})"
        else
            record_result "fail" "dependencies" "${tool}" "Not found - required for repository operations"
        fi
    done
    
    if [[ ${#optional_tools[@]} -gt 0 && -n "${optional_tools[0]}" ]]; then
        log_subsection "Optional Tools"
        for tool in "${optional_tools[@]}"; do
            [[ -z "${tool}" ]] && continue
            if command -v "${tool}" &>/dev/null; then
                local version=""
                case "${tool}" in
                    uv)         version=$(uv --version 2>/dev/null | awk '{print $2}' || echo "unknown") ;;
                    helm-docs)  version=$(helm-docs --version 2>/dev/null | head -1 || echo "unknown") ;;
                    ct)         version=$(ct version 2>/dev/null | head -1 || echo "unknown") ;;
                    pre-commit) version=$(pre-commit --version 2>/dev/null | awk '{print $2}' || echo "unknown") ;;
                    yamllint)   version=$(yamllint --version 2>/dev/null | awk '{print $2}' || echo "unknown") ;;
                    *)          version=$(${tool} --version 2>/dev/null | head -1 || echo "installed") ;;
                esac
                record_result "pass" "dependencies" "${tool}" "Found (${version:-unknown})"
            else
                record_result "warn" "dependencies" "${tool}" "Not found - some features may be unavailable"
            fi
        done
    fi
    
    # Check helm plugins
    if [[ -n "${HELM_PLUGINS}" ]] && command -v helm &>/dev/null; then
        log_subsection "Helm Plugins"
        read -ra helm_plugins <<< "${HELM_PLUGINS}"
        for plugin in "${helm_plugins[@]}"; do
            [[ -z "${plugin}" ]] && continue
            if helm plugin list 2>/dev/null | grep -q "^${plugin}"; then
                local version=""
                version=$(helm plugin list 2>/dev/null | grep "^${plugin}" | awk '{print $2}' || echo "unknown")
                record_result "pass" "dependencies" "helm-${plugin}" "Plugin installed (${version:-unknown})"
            else
                record_result "warn" "dependencies" "helm-${plugin}" "Plugin not installed"
            fi
        done
    fi
}

# =============================================================================
# Repository Structure Checks
# =============================================================================

check_repository_structure() {
    [[ "${CHECK_STRUCTURE}" != "true" ]] && return
    
    log_section "Checking Repository Structure"
    
    log_subsection "Root Configuration Files"
    
    # Check all important root files with details
    
    # Makefile
    if [[ -f "${REPO_ROOT}/Makefile" ]]; then
        local target_count
        target_count=$(grep -c "^[a-zA-Z_-]*:" "${REPO_ROOT}/Makefile" 2>/dev/null || echo "0")
        record_result "pass" "structure" "Makefile" "Build automation (${target_count} targets)"
    else
        record_result "fail" "structure" "Makefile" "Missing Makefile"
    fi
    
    # README.md
    if [[ -f "${REPO_ROOT}/README.md" ]]; then
        local readme_lines
        readme_lines=$(wc -l < "${REPO_ROOT}/README.md" | tr -d ' ')
        local readme_size
        readme_size=$(du -h "${REPO_ROOT}/README.md" 2>/dev/null | awk '{print $1}')
        record_result "pass" "structure" "README.md" "Project documentation (${readme_lines} lines, ${readme_size})"
    else
        record_result "fail" "structure" "README.md" "Missing README.md"
    fi
    
    # LICENSE
    if [[ -f "${REPO_ROOT}/LICENSE" ]]; then
        local license_size
        license_size=$(wc -c < "${REPO_ROOT}/LICENSE" | tr -d ' ')
        if [[ "${license_size}" -gt 0 ]]; then
            local license_type=""
            if grep -qi "MIT" "${REPO_ROOT}/LICENSE" 2>/dev/null; then
                license_type="MIT"
            elif grep -qi "Apache" "${REPO_ROOT}/LICENSE" 2>/dev/null; then
                license_type="Apache"
            elif grep -qi "GPL" "${REPO_ROOT}/LICENSE" 2>/dev/null; then
                license_type="GPL"
            elif grep -qi "BSD" "${REPO_ROOT}/LICENSE" 2>/dev/null; then
                license_type="BSD"
            else
                license_type="Custom"
            fi
            record_result "pass" "structure" "LICENSE" "License file (${license_type})"
        else
            record_result "warn" "structure" "LICENSE" "LICENSE file is empty"
        fi
    else
        record_result "warn" "structure" "LICENSE" "No LICENSE file found"
    fi
    
    # pyproject.toml
    if [[ -f "${REPO_ROOT}/pyproject.toml" ]]; then
        local has_project
        has_project=$(grep -c "^\[project\]" "${REPO_ROOT}/pyproject.toml" 2>/dev/null || echo "0")
        local has_deps
        has_deps=$(grep -c "dependencies" "${REPO_ROOT}/pyproject.toml" 2>/dev/null || echo "0")
        record_result "pass" "structure" "pyproject.toml" "Python project config (deps: ${has_deps} sections)"
    else
        record_result "warn" "structure" "pyproject.toml" "No pyproject.toml"
    fi
    
    # uv.lock
    if [[ -f "${REPO_ROOT}/uv.lock" ]]; then
        local lock_size
        lock_size=$(du -h "${REPO_ROOT}/uv.lock" 2>/dev/null | awk '{print $1}')
        record_result "pass" "structure" "uv.lock" "UV lock file (${lock_size})"
    else
        record_result "warn" "structure" "uv.lock" "No uv.lock (run 'uv sync' to generate)"
    fi
    
    # mkdocs.yml
    if [[ -f "${REPO_ROOT}/mkdocs.yml" ]]; then
        local site_name
        site_name=$(yq '.site_name' "${REPO_ROOT}/mkdocs.yml" 2>/dev/null | grep -v '^null$' || echo "")
        if [[ -n "${site_name}" ]]; then
            record_result "pass" "structure" "mkdocs.yml" "MkDocs config (site: ${site_name})"
        else
            record_result "pass" "structure" "mkdocs.yml" "MkDocs config exists"
        fi
    else
        record_result "warn" "structure" "mkdocs.yml" "No MkDocs configuration"
    fi
    
    # ct.yaml (chart-testing)
    if [[ -f "${REPO_ROOT}/ct.yaml" ]]; then
        local chart_dirs
        chart_dirs=$(yq '.chart-dirs | length' "${REPO_ROOT}/ct.yaml" 2>/dev/null || echo "0")
        record_result "pass" "structure" "ct.yaml" "Chart-testing config (${chart_dirs} chart dirs)"
    else
        record_result "warn" "structure" "ct.yaml" "No chart-testing configuration"
    fi
    
    # Tiltfile
    if [[ -f "${REPO_ROOT}/Tiltfile" ]]; then
        local tilt_lines
        tilt_lines=$(wc -l < "${REPO_ROOT}/Tiltfile" | tr -d ' ')
        record_result "pass" "structure" "Tiltfile" "Tilt config for local K8s dev (${tilt_lines} lines)"
    else
        record_result "warn" "structure" "Tiltfile" "No Tiltfile for local development"
    fi
    
    # renovate.json
    if [[ -f "${REPO_ROOT}/renovate.json" ]]; then
        record_result "pass" "structure" "renovate.json" "Renovate dependency management configured"
    elif [[ -f "${REPO_ROOT}/renovate.json5" ]] || [[ -f "${REPO_ROOT}/.renovaterc" ]]; then
        record_result "pass" "structure" "renovate" "Renovate configured (alternative format)"
    else
        record_result "warn" "structure" "renovate.json" "No Renovate configuration"
    fi
    
    log_subsection "Git & Version Control"
    
    # .gitignore
    if [[ -f "${REPO_ROOT}/.gitignore" ]]; then
        local ignore_rules
        ignore_rules=$(grep -v '^#' "${REPO_ROOT}/.gitignore" 2>/dev/null | grep -v '^$' | wc -l | tr -d ' ')
        record_result "pass" "structure" ".gitignore" "Git ignore rules (${ignore_rules} patterns)"
    else
        record_result "fail" "structure" ".gitignore" "Missing .gitignore"
    fi
    
    # .gitattributes
    if [[ -f "${REPO_ROOT}/.gitattributes" ]]; then
        local attr_rules
        attr_rules=$(grep -v '^#' "${REPO_ROOT}/.gitattributes" 2>/dev/null | grep -v '^$' | wc -l | tr -d ' ')
        local attr_size
        attr_size=$(du -h "${REPO_ROOT}/.gitattributes" 2>/dev/null | awk '{print $1}')
        record_result "pass" "structure" ".gitattributes" "Git attributes (${attr_rules} rules, ${attr_size})"
    else
        record_result "warn" "structure" ".gitattributes" "No .gitattributes file"
    fi
    
    log_subsection "Code Quality & Linting"
    
    # .pre-commit-config.yaml
    if [[ -f "${REPO_ROOT}/.pre-commit-config.yaml" ]]; then
        local hook_count
        hook_count=$(grep -c "id:" "${REPO_ROOT}/.pre-commit-config.yaml" 2>/dev/null || echo "0")
        record_result "pass" "structure" ".pre-commit-config.yaml" "Pre-commit hooks (${hook_count} hooks)"
    else
        record_result "warn" "structure" ".pre-commit-config.yaml" "No pre-commit configuration"
    fi
    
    # .yamllint
    if [[ -f "${REPO_ROOT}/.yamllint" ]]; then
        record_result "pass" "structure" ".yamllint" "YAML linting configured"
    elif [[ -f "${REPO_ROOT}/.yamllint.yaml" ]] || [[ -f "${REPO_ROOT}/.yamllint.yml" ]]; then
        record_result "pass" "structure" ".yamllint" "YAML linting configured"
    else
        record_result "warn" "structure" ".yamllint" "No YAML lint configuration"
    fi
    
    # .editorconfig
    if [[ -f "${REPO_ROOT}/.editorconfig" ]]; then
        local editor_rules
        editor_rules=$(grep -c "^\[" "${REPO_ROOT}/.editorconfig" 2>/dev/null || echo "0")
        record_result "pass" "structure" ".editorconfig" "EditorConfig (${editor_rules} sections)"
    else
        record_result "warn" "structure" ".editorconfig" "No .editorconfig for consistent formatting"
    fi
    
    log_subsection "Commit & Changelog"
    
    # .cz.toml (commitizen)
    if [[ -f "${REPO_ROOT}/.cz.toml" ]]; then
        local cz_type
        cz_type=$(grep "name" "${REPO_ROOT}/.cz.toml" 2>/dev/null | head -1 | cut -d'"' -f2 || echo "default")
        record_result "pass" "structure" ".cz.toml" "Commitizen config (${cz_type})"
    elif grep -q "\[tool.commitizen\]" "${REPO_ROOT}/pyproject.toml" 2>/dev/null; then
        record_result "pass" "structure" "commitizen" "Commitizen in pyproject.toml"
    else
        record_result "warn" "structure" ".cz.toml" "No Commitizen configuration"
    fi
    
    log_subsection "Security & Secrets"
    
    # .sops.yaml
    if [[ -f "${REPO_ROOT}/.sops.yaml" ]]; then
        local sops_rules
        sops_rules=$(grep -c "path_regex" "${REPO_ROOT}/.sops.yaml" 2>/dev/null || echo "0")
        record_result "pass" "structure" ".sops.yaml" "SOPS encryption config (${sops_rules} rules)"
    else
        record_result "warn" "structure" ".sops.yaml" "No SOPS configuration for secrets"
    fi
    
    log_subsection "Community & Documentation Files"
    
    # Check for CODEOWNERS
    local codeowners_found=false
    for path in ".github/CODEOWNERS" "CODEOWNERS" "docs/CODEOWNERS"; do
        if [[ -f "${REPO_ROOT}/${path}" ]]; then
            local owner_rules
            owner_rules=$(grep -v '^#' "${REPO_ROOT}/${path}" 2>/dev/null | grep -v '^$' | wc -l | tr -d ' ')
            record_result "pass" "structure" "CODEOWNERS" "Code owners defined (${owner_rules} rules in ${path})"
            codeowners_found=true
            break
        fi
    done
    if [[ "${codeowners_found}" == "false" ]]; then
        record_result "warn" "structure" "CODEOWNERS" "No CODEOWNERS file"
    fi
    
    # Check for CONTRIBUTING guide
    local contributing_found=false
    for path in "CONTRIBUTING.md" ".github/CONTRIBUTING.md" "docs/CONTRIBUTING.md"; do
        if [[ -f "${REPO_ROOT}/${path}" ]]; then
            local contrib_lines
            contrib_lines=$(wc -l < "${REPO_ROOT}/${path}" | tr -d ' ')
            record_result "pass" "structure" "CONTRIBUTING.md" "Contributing guide (${contrib_lines} lines in ${path})"
            contributing_found=true
            break
        fi
    done
    if [[ "${contributing_found}" == "false" ]]; then
        record_result "warn" "structure" "CONTRIBUTING.md" "No CONTRIBUTING.md"
    fi
    
    # Check for SECURITY policy
    local security_found=false
    for path in "SECURITY.md" ".github/SECURITY.md" "docs/SECURITY.md"; do
        if [[ -f "${REPO_ROOT}/${path}" ]]; then
            record_result "pass" "structure" "SECURITY.md" "Security policy (${path})"
            security_found=true
            break
        fi
    done
    if [[ "${security_found}" == "false" ]]; then
        record_result "warn" "structure" "SECURITY.md" "No SECURITY.md"
    fi
    
    # Check for CHANGELOG
    local changelog_found=false
    for path in "CHANGELOG.md" "CHANGELOG" "docs/CHANGELOG.md" "HISTORY.md"; do
        if [[ -f "${REPO_ROOT}/${path}" ]]; then
            local changelog_lines
            changelog_lines=$(wc -l < "${REPO_ROOT}/${path}" | tr -d ' ')
            record_result "pass" "structure" "CHANGELOG" "Changelog (${changelog_lines} lines in ${path})"
            changelog_found=true
            break
        fi
    done
    if [[ "${changelog_found}" == "false" ]]; then
        record_result "warn" "structure" "CHANGELOG" "No CHANGELOG.md"
    fi
    
    log_subsection "Directory Structure"
    
    # Build essential directories list dynamically
    local essential_dirs=("scripts" "docs" ".github/workflows")
    
    # Add chart directories if configured
    if [[ -n "${CHARTS_DIR}" ]]; then
        essential_dirs+=("$(basename "${CHARTS_DIR}")")
        for subdir in ${CHART_SUBDIRS}; do
            essential_dirs+=("$(basename "${CHARTS_DIR}")/${subdir}")
        done
    fi
    
    for dir in "${essential_dirs[@]}"; do
        if [[ -d "${REPO_ROOT}/${dir}" ]]; then
            local count
            count=$(find "${REPO_ROOT}/${dir}" -maxdepth 1 -type f -o -type d 2>/dev/null | wc -l | tr -d ' ')
            record_result "pass" "structure" "${dir}" "Directory exists (${count} items)"
        else
            record_result "warn" "structure" "${dir}" "Directory not found"
        fi
    done
    
    log_subsection "Test Infrastructure"
    
    # Check test directory structure
    if [[ -n "${TEST_DIR}" && -d "${TEST_DIR}" ]]; then
        record_result "pass" "structure" "test/" "Test directory exists"
        
        # Check for test subdirectories
        read -ra test_subdirs <<< "${TEST_SUBDIRS}"
        for subdir in "${test_subdirs[@]}"; do
            [[ -z "${subdir}" ]] && continue
            if [[ -d "${TEST_DIR}/${subdir}" ]]; then
                local file_count
                file_count=$(find "${TEST_DIR}/${subdir}" -type f 2>/dev/null | wc -l | tr -d ' ')
                if [[ "${file_count}" -gt 0 ]]; then
                    record_result "pass" "structure" "test/${subdir}" "Test ${subdir} directory (${file_count} files)"
                else
                    record_result "warn" "structure" "test/${subdir}" "Test ${subdir} directory exists but is empty"
                fi
            fi
        done
        
        # Check for test fixtures specifically
        local fixtures_dir="${TEST_DIR}/fixtures"
        if [[ -d "${fixtures_dir}" ]]; then
            # Check for chart test fixtures
            local chart_fixtures
            chart_fixtures=$(find "${fixtures_dir}" -name "*.yaml" -o -name "*.yml" 2>/dev/null | wc -l | tr -d ' ')
            if [[ "${chart_fixtures}" -gt 0 ]]; then
                record_result "pass" "structure" "test/fixtures/yaml" "Test fixtures include ${chart_fixtures} YAML files"
            fi
            
            # Check for values fixtures
            local values_fixtures
            values_fixtures=$(find "${fixtures_dir}" -name "values*.yaml" -o -name "values*.yml" 2>/dev/null | wc -l | tr -d ' ')
            if [[ "${values_fixtures}" -gt 0 ]]; then
                record_result "pass" "structure" "test/fixtures/values" "Test fixtures include ${values_fixtures} values files"
            fi
        fi
    else
        record_result "warn" "structure" "test/" "No test directory found"
    fi
    
    # Check for chart unit tests (helm unittest)
    if [[ -n "${CHARTS_DIR}" && -d "${CHARTS_DIR}" ]]; then
        local charts_with_tests=0
        local charts_total=0
        
        for subdir in ${CHART_SUBDIRS}; do
            local chart_dir="${CHARTS_DIR}/${subdir}"
            [[ ! -d "${chart_dir}" ]] && continue
            
            while IFS= read -r chart_yaml; do
                [[ -z "${chart_yaml}" ]] && continue
                local chart_path
                chart_path=$(dirname "${chart_yaml}")
                
                # Skip subcharts
                local relative_path="${chart_path#${chart_dir}/}"
                if [[ "${relative_path}" == *"/charts/"* ]]; then
                    continue
                fi
                
                ((charts_total++))
                
                # Check for tests directory in chart
                if [[ -d "${chart_path}/tests" ]]; then
                    local test_files
                    test_files=$(find "${chart_path}/tests" -name "*_test.yaml" -o -name "*_test.yml" 2>/dev/null | wc -l | tr -d ' ')
                    if [[ "${test_files}" -gt 0 ]]; then
                        ((charts_with_tests++))
                    fi
                fi
            done < <(find "${chart_dir}" -maxdepth 2 -name "Chart.yaml" -type f 2>/dev/null)
        done
        
        if [[ "${charts_total}" -gt 0 ]]; then
            local test_coverage=$((charts_with_tests * 100 / charts_total))
            if [[ "${test_coverage}" -ge 50 ]]; then
                record_result "pass" "structure" "chart-tests" "Chart unit test coverage: ${test_coverage}% (${charts_with_tests}/${charts_total} charts)"
            elif [[ "${test_coverage}" -gt 0 ]]; then
                record_result "warn" "structure" "chart-tests" "Low chart unit test coverage: ${test_coverage}% (${charts_with_tests}/${charts_total} charts)"
            else
                record_result "warn" "structure" "chart-tests" "No chart unit tests found (0/${charts_total} charts)"
            fi
        fi
    fi
    
    log_subsection "Site & Static Assets"
    
    # Check site directory (GitHub Pages source)
    if [[ -n "${SITE_DIR}" && -d "${SITE_DIR}" ]]; then
        local site_file_count
        site_file_count=$(find "${SITE_DIR}" -type f 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "structure" "site/" "Site directory exists (${site_file_count} files)"
        
        # Check for index.html
        if [[ -f "${SITE_DIR}/index.html" ]]; then
            record_result "pass" "structure" "site/index.html" "Site index page exists"
        else
            record_result "warn" "structure" "site/index.html" "No index.html in site directory"
        fi
        
        # Check for index.yaml (Helm repo index)
        if [[ -f "${SITE_DIR}/index.yaml" ]]; then
            local chart_count
            chart_count=$(grep -c "^  [a-zA-Z]" "${SITE_DIR}/index.yaml" 2>/dev/null || echo "0")
            record_result "pass" "structure" "site/index.yaml" "Helm repository index exists (${chart_count} entries)"
        fi
        
        # Check for CNAME (custom domain)
        if [[ -f "${SITE_DIR}/CNAME" ]]; then
            local custom_domain
            custom_domain=$(cat "${SITE_DIR}/CNAME" 2>/dev/null | head -1)
            record_result "pass" "structure" "site/CNAME" "Custom domain configured: ${custom_domain}"
        fi
        
        # Check for .nojekyll (disable Jekyll processing)
        if [[ -f "${SITE_DIR}/.nojekyll" ]]; then
            record_result "pass" "structure" "site/.nojekyll" "Jekyll processing disabled"
        fi
        
        # Check for artifacthub-repo.yaml
        if [[ -f "${SITE_DIR}/artifacthub-repo.yaml" ]]; then
            record_result "pass" "structure" "site/artifacthub" "ArtifactHub repository metadata exists"
        fi
    fi
    
    log_subsection "Templates & Scaffolding"
    
    # Check templates directory
    if [[ -n "${TEMPLATES_DIR}" && -d "${TEMPLATES_DIR}" ]]; then
        local template_count
        template_count=$(find "${TEMPLATES_DIR}" -type f 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "structure" "templates/" "Templates directory exists (${template_count} files)"
        
        # Check for helm-docs templates
        if [[ -f "${TEMPLATES_DIR}/README.md.gotmpl" ]]; then
            record_result "pass" "structure" "templates/README.md.gotmpl" "Helm-docs README template exists"
        fi
        
        # Check for helpers template
        if [[ -f "${TEMPLATES_DIR}/_helpers.gotmpl" ]]; then
            record_result "pass" "structure" "templates/_helpers.gotmpl" "Helm-docs helpers template exists"
        fi
        
        # Check for chart template/scaffold
        if [[ -d "${TEMPLATES_DIR}/chart-template" ]]; then
            local scaffold_files
            scaffold_files=$(find "${TEMPLATES_DIR}/chart-template" -type f 2>/dev/null | wc -l | tr -d ' ')
            record_result "pass" "structure" "templates/chart-template" "Chart scaffold template exists (${scaffold_files} files)"
            
            # Validate chart template has required files
            local required_scaffold_files=("Chart.yaml" "values.yaml" ".helmignore")
            local missing_scaffold=()
            for scaffold_file in "${required_scaffold_files[@]}"; do
                if [[ ! -f "${TEMPLATES_DIR}/chart-template/${scaffold_file}" ]]; then
                    missing_scaffold+=("${scaffold_file}")
                fi
            done
            
            if [[ ${#missing_scaffold[@]} -eq 0 ]]; then
                record_result "pass" "structure" "chart-template-files" "Chart scaffold has all required files"
            else
                record_result "warn" "structure" "chart-template-files" "Chart scaffold missing: ${missing_scaffold[*]}"
            fi
            
            # Check for templates directory in scaffold
            if [[ -d "${TEMPLATES_DIR}/chart-template/templates" ]]; then
                record_result "pass" "structure" "chart-template/templates" "Chart scaffold includes templates directory"
            fi
            
            # Check for tests directory in scaffold
            if [[ -d "${TEMPLATES_DIR}/chart-template/tests" ]]; then
                record_result "pass" "structure" "chart-template/tests" "Chart scaffold includes tests directory"
            fi
            
            # Check for CI directory in scaffold
            if [[ -d "${TEMPLATES_DIR}/chart-template/ci" ]]; then
                record_result "pass" "structure" "chart-template/ci" "Chart scaffold includes CI values directory"
            fi
        fi
    fi
    
    log_subsection "Scripts & Automation"
    
    # Check scripts directory
    if [[ -n "${SCRIPTS_DIR}" && -d "${SCRIPTS_DIR}" ]]; then
        local script_count
        script_count=$(find "${SCRIPTS_DIR}" -type f \( -name "*.sh" -o -name "*.py" -o -name "*.js" \) 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "structure" "scripts/" "Scripts directory exists (${script_count} scripts)"
        
        # Check for shell scripts and their executability
        local shell_scripts
        shell_scripts=$(find "${scripts_dir}" -name "*.sh" -type f 2>/dev/null)
        local executable_count=0
        local non_executable=()
        
        while IFS= read -r script; do
            [[ -z "${script}" ]] && continue
            local script_name
            script_name=$(basename "${script}")
            if [[ -x "${script}" ]]; then
                ((executable_count++))
            else
                non_executable+=("${script_name}")
            fi
        done <<< "${shell_scripts}"
        
        if [[ ${#non_executable[@]} -eq 0 ]]; then
            if [[ "${executable_count}" -gt 0 ]]; then
                record_result "pass" "structure" "scripts-executable" "All ${executable_count} shell scripts are executable"
            fi
        else
            record_result "warn" "structure" "scripts-executable" "Non-executable scripts: ${non_executable[*]}"
        fi
        
        # Check for Python scripts
        local python_scripts
        python_scripts=$(find "${SCRIPTS_DIR}" -name "*.py" -type f 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${python_scripts}" -gt 0 ]]; then
            record_result "pass" "structure" "scripts/python" "Python scripts present (${python_scripts} files)"
        fi
        
        # Check for documentation generation scripts
        if [[ -f "${SCRIPTS_DIR}/generate-docs.py" ]] || [[ -f "${SCRIPTS_DIR}/generate-docs.sh" ]]; then
            record_result "pass" "structure" "scripts/generate-docs" "Documentation generation script exists"
        fi
        
        # Check for sync scripts
        if [[ -f "${SCRIPTS_DIR}/sync-chart-docs.py" ]] || [[ -f "${SCRIPTS_DIR}/sync-chart-docs.sh" ]]; then
            record_result "pass" "structure" "scripts/sync-docs" "Documentation sync script exists"
        fi
    fi
    
    log_subsection "GitHub Configuration"
    
    # Check GitHub workflows
    if [[ -n "${REQUIRED_WORKFLOWS}" ]]; then
        read -ra workflows <<< "${REQUIRED_WORKFLOWS}"
        for workflow in "${workflows[@]}"; do
            [[ -z "${workflow}" ]] && continue
            if [[ -f "${REPO_ROOT}/.github/workflows/${workflow}" ]]; then
                record_result "pass" "structure" "workflow/${workflow}" "Workflow file exists"
            else
                record_result "warn" "structure" "workflow/${workflow}" "Workflow file missing"
            fi
        done
    fi
    
    # Check issue templates
    local issue_template_dir="${REPO_ROOT}/.github/ISSUE_TEMPLATE"
    if [[ -d "${issue_template_dir}" ]]; then
        local template_count
        template_count=$(find "${issue_template_dir}" -name "*.md" -o -name "*.yml" -o -name "*.yaml" 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${template_count}" -gt 0 ]]; then
            record_result "pass" "structure" "issue-templates" "Issue templates configured (${template_count} templates)"
        else
            record_result "warn" "structure" "issue-templates" "Issue template directory exists but is empty"
        fi
    fi
    
    # Check for pull request template
    local pr_template_found=false
    for path in ".github/PULL_REQUEST_TEMPLATE.md" ".github/PULL_REQUEST_TEMPLATE" "PULL_REQUEST_TEMPLATE.md"; do
        if [[ -f "${REPO_ROOT}/${path}" ]]; then
            record_result "pass" "structure" "pr-template" "Pull request template exists (${path})"
            pr_template_found=true
            break
        fi
    done
    # Also check for PR template directory
    if [[ "${pr_template_found}" == "false" && -d "${REPO_ROOT}/.github/PULL_REQUEST_TEMPLATE" ]]; then
        local pr_template_count
        pr_template_count=$(find "${REPO_ROOT}/.github/PULL_REQUEST_TEMPLATE" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${pr_template_count}" -gt 0 ]]; then
            record_result "pass" "structure" "pr-template" "PR templates directory exists (${pr_template_count} templates)"
            pr_template_found=true
        fi
    fi
    if [[ "${pr_template_found}" == "false" ]]; then
        record_result "warn" "structure" "pr-template" "No pull request template (recommended for consistent PRs)"
    fi
    
    # Check for GitHub Actions (reusable workflows or composite actions)
    if [[ -d "${REPO_ROOT}/.github/actions" ]]; then
        local action_count
        action_count=$(find "${REPO_ROOT}/.github/actions" -name "action.yml" -o -name "action.yaml" 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${action_count}" -gt 0 ]]; then
            record_result "pass" "structure" "custom-actions" "Custom GitHub Actions defined (${action_count} actions)"
        fi
    fi
    
    log_subsection "Git Hooks & IDE Support"
    
    # Check for husky (git hooks)
    if [[ -d "${REPO_ROOT}/.husky" ]]; then
        local hook_count
        hook_count=$(find "${REPO_ROOT}/.husky" -type f -not -name ".*" 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "structure" ".husky" "Husky git hooks (${hook_count} hooks)"
    fi
    
    # Check for IDE configurations
    if [[ -d "${REPO_ROOT}/.vscode" ]]; then
        local vscode_files
        vscode_files=$(find "${REPO_ROOT}/.vscode" -name "*.json" 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "structure" ".vscode" "VS Code configuration (${vscode_files} config files)"
    fi
    
    if [[ -d "${REPO_ROOT}/.idea" ]]; then
        record_result "pass" "structure" ".idea" "JetBrains IDE configuration present"
    fi
}

# =============================================================================
# Chart Validation
# =============================================================================

check_charts() {
    [[ "${CHECK_CHARTS}" != "true" ]] && return
    [[ -z "${CHARTS_DIR}" || ! -d "${CHARTS_DIR}" ]] && return
    
    log_section "Validating Helm Charts"
    
    local total_charts=0
    local valid_charts=0
    
    for subdir in ${CHART_SUBDIRS}; do
        local chart_dir="${CHARTS_DIR}/${subdir}"
        [[ ! -d "${chart_dir}" ]] && continue
        
        local category="${subdir}"
        log_subsection "Charts in ${category}/"
        
        while IFS= read -r chart_yaml; do
            [[ -z "${chart_yaml}" ]] && continue
            
            local chart_path
            chart_path=$(dirname "${chart_yaml}")
            local chart_name
            chart_name=$(basename "${chart_path}")
            
            # Skip subcharts - these are charts that have "/charts/" in their path
            # relative to the chart directory (e.g., apps/myapp/charts/subchart)
            local relative_path="${chart_path#${chart_dir}/}"
            if [[ "${relative_path}" == *"/charts/"* ]]; then
                log_verbose "Skipping subchart: ${relative_path}"
                continue
            fi
            
            ((total_charts++))
            
            # Check Chart.yaml exists and is valid
            if [[ -f "${chart_yaml}" ]]; then
                # Validate required fields
                local name version
                name=$(yq '.name' "${chart_yaml}" 2>/dev/null | grep -v '^null$' || echo "")
                version=$(yq '.version' "${chart_yaml}" 2>/dev/null | grep -v '^null$' || echo "")
                
                if [[ -z "${name}" ]]; then
                    record_result "fail" "charts" "${category}/${chart_name}" "Chart.yaml missing 'name' field"
                    continue
                fi
                
                if [[ -z "${version}" ]]; then
                    record_result "fail" "charts" "${category}/${chart_name}" "Chart.yaml missing 'version' field"
                    continue
                fi
                
                # Check values.yaml exists
                if [[ ! -f "${chart_path}/values.yaml" ]]; then
                    record_result "warn" "charts" "${category}/${chart_name}" "Missing values.yaml (v${version})"
                    continue
                fi
                
                # Run helm lint
                local lint_output
                if lint_output=$(helm lint "${chart_path}" 2>&1); then
                    ((valid_charts++))
                    record_result "pass" "charts" "${category}/${chart_name}" "Valid chart (v${version})"
                else
                    local error_count
                    error_count=$(echo "${lint_output}" | grep -c "Error:" || echo "0")
                    record_result "fail" "charts" "${category}/${chart_name}" "Lint errors: ${error_count} (v${version})" "${lint_output}"
                fi
            else
                record_result "fail" "charts" "${category}/${chart_name}" "Missing Chart.yaml"
            fi
        done < <(find "${chart_dir}" -maxdepth 2 -name "Chart.yaml" -type f 2>/dev/null)
    done
    
    log_info "Chart summary: ${valid_charts}/${total_charts} charts valid"
}

# =============================================================================
# Documentation Checks
# =============================================================================

check_documentation() {
    [[ "${CHECK_DOCUMENTATION}" != "true" ]] && return
    
    log_section "Checking Documentation"
    
    log_subsection "Documentation Files"
    
    # Check main README
    if [[ -f "${REPO_ROOT}/README.md" ]]; then
        local readme_lines
        readme_lines=$(wc -l < "${REPO_ROOT}/README.md" | tr -d ' ')
        if [[ "${readme_lines}" -gt 10 ]]; then
            record_result "pass" "docs" "README.md" "Main README exists (${readme_lines} lines)"
        else
            record_result "warn" "docs" "README.md" "README.md seems sparse (${readme_lines} lines)"
        fi
    else
        record_result "fail" "docs" "README.md" "Missing main README"
    fi
    
    # Check docs directory
    if [[ -d "${REPO_ROOT}/docs" ]]; then
        local doc_files
        doc_files=$(find "${REPO_ROOT}/docs" -name "*.md" -type f | wc -l | tr -d ' ')
        record_result "pass" "docs" "docs/" "Documentation directory exists (${doc_files} markdown files)"
    else
        record_result "warn" "docs" "docs/" "Missing docs directory"
    fi
    
    # Check MkDocs configuration
    if [[ -f "${REPO_ROOT}/mkdocs.yml" ]]; then
        if yq -e '.site_name' "${REPO_ROOT}/mkdocs.yml" &>/dev/null; then
            record_result "pass" "docs" "mkdocs.yml" "Valid MkDocs configuration"
        else
            record_result "warn" "docs" "mkdocs.yml" "MkDocs configuration may be incomplete"
        fi
    else
        record_result "warn" "docs" "mkdocs.yml" "Missing MkDocs configuration"
    fi
    
    log_subsection "Chart Documentation"
    
    if [[ -n "${CHARTS_DIR}" && -d "${CHARTS_DIR}" ]]; then
        local charts_with_readme=0
        local charts_total=0
        
        for subdir in ${CHART_SUBDIRS}; do
            local chart_dir="${CHARTS_DIR}/${subdir}"
            [[ ! -d "${chart_dir}" ]] && continue
            
            while IFS= read -r chart_yaml; do
                [[ -z "${chart_yaml}" ]] && continue
                local chart_path
                chart_path=$(dirname "${chart_yaml}")
                
                # Skip subcharts - check relative path for /charts/ directory
                local relative_path="${chart_path#${chart_dir}/}"
                if [[ "${relative_path}" == *"/charts/"* ]]; then
                    continue
                fi
                
                ((charts_total++))
                
                if [[ -f "${chart_path}/README.md" ]]; then
                    ((charts_with_readme++))
                fi
            done < <(find "${chart_dir}" -maxdepth 2 -name "Chart.yaml" -type f 2>/dev/null)
        done
        
        local coverage
        if [[ "${charts_total}" -gt 0 ]]; then
            coverage=$((charts_with_readme * 100 / charts_total))
            
            if [[ "${coverage}" -ge 80 ]]; then
                record_result "pass" "docs" "chart-readmes" "Chart README coverage: ${coverage}% (${charts_with_readme}/${charts_total})"
            elif [[ "${coverage}" -ge 50 ]]; then
                record_result "warn" "docs" "chart-readmes" "Chart README coverage: ${coverage}% (${charts_with_readme}/${charts_total})"
            else
                record_result "warn" "docs" "chart-readmes" "Low chart README coverage: ${coverage}% (${charts_with_readme}/${charts_total})"
            fi
        fi
    fi
}

# =============================================================================
# Git Repository Checks
# =============================================================================

check_git_repository() {
    [[ "${CHECK_GIT}" != "true" ]] && return
    
    log_section "Checking Git Repository"
    
    log_subsection "Repository Status"
    
    # Check if it's a git repository
    if ! git -C "${REPO_ROOT}" rev-parse --is-inside-work-tree &>/dev/null; then
        record_result "fail" "git" "repository" "Not a git repository"
        return
    fi
    
    record_result "pass" "git" "repository" "Valid git repository"
    
    # Check for uncommitted changes
    local changes
    changes=$(git -C "${REPO_ROOT}" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    if [[ "${changes}" -eq 0 ]]; then
        record_result "pass" "git" "working-tree" "Clean working tree"
    else
        record_result "warn" "git" "working-tree" "${changes} uncommitted changes"
    fi
    
    # Check current branch
    local branch
    branch=$(git -C "${REPO_ROOT}" rev-parse --abbrev-ref HEAD 2>/dev/null)
    record_result "pass" "git" "branch" "Current branch: ${branch}"
    
    # Check remote
    local remote
    if remote=$(git -C "${REPO_ROOT}" remote get-url origin 2>/dev/null); then
        record_result "pass" "git" "remote" "Origin: ${remote}"
    else
        record_result "warn" "git" "remote" "No remote 'origin' configured"
    fi
    
    log_subsection "Git Hooks"
    
    # Check pre-commit hooks
    if [[ -f "${REPO_ROOT}/.git/hooks/pre-commit" ]]; then
        record_result "pass" "git" "pre-commit-hook" "Pre-commit hook installed"
    else
        record_result "warn" "git" "pre-commit-hook" "Pre-commit hook not installed (run 'make install-hooks')"
    fi
    
    # Check .gitignore
    if [[ -f "${REPO_ROOT}/.gitignore" ]]; then
        local gitignore_lines
        gitignore_lines=$(grep -v '^#' "${REPO_ROOT}/.gitignore" | grep -v '^$' | wc -l | tr -d ' ')
        record_result "pass" "git" ".gitignore" ".gitignore configured (${gitignore_lines} rules)"
    else
        record_result "warn" "git" ".gitignore" "Missing .gitignore"
    fi
}

# =============================================================================
# CI/CD Checks
# =============================================================================

check_cicd() {
    [[ "${CHECK_CICD}" != "true" ]] && return
    
    log_section "Checking CI/CD Configuration"
    
    log_subsection "GitHub Actions"
    
    local workflows_dir="${REPO_ROOT}/.github/workflows"
    
    if [[ -d "${workflows_dir}" ]]; then
        local workflow_count
        workflow_count=$(find "${workflows_dir}" -name "*.yaml" -o -name "*.yml" 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "cicd" "workflows" "Found ${workflow_count} workflow files"
        
        # Validate each workflow
        while IFS= read -r workflow; do
            [[ -z "${workflow}" ]] && continue
            local workflow_name
            workflow_name=$(basename "${workflow}")
            
            if yq -e '.jobs' "${workflow}" &>/dev/null; then
                local job_count
                job_count=$(yq '.jobs | keys | length' "${workflow}" 2>/dev/null)
                record_result "pass" "cicd" "${workflow_name}" "Valid workflow (${job_count} jobs)"
            else
                record_result "fail" "cicd" "${workflow_name}" "Invalid workflow YAML"
            fi
        done < <(find "${workflows_dir}" -name "*.yaml" -o -name "*.yml" 2>/dev/null)
    else
        record_result "fail" "cicd" "workflows" "No GitHub workflows directory found"
    fi
    
    log_subsection "Chart Testing Configuration"
    
    if [[ -f "${REPO_ROOT}/ct.yaml" ]]; then
        local chart_dirs
        chart_dirs=$(yq '.chart-dirs[]?' "${REPO_ROOT}/ct.yaml" 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "cicd" "ct.yaml" "Chart-testing configured (${chart_dirs} chart directories)"
    else
        record_result "warn" "cicd" "ct.yaml" "Missing chart-testing configuration"
    fi
}

# =============================================================================
# GitHub Pages Checks
# =============================================================================

check_github_pages() {
    [[ "${CHECK_GITHUB_PAGES}" != "true" ]] && return
    
    log_section "Checking GitHub Pages Configuration"
    
    log_subsection "Pages Workflow"
    
    # Check for pages workflow
    local pages_workflow="${REPO_ROOT}/.github/workflows/pages.yaml"
    if [[ -f "${pages_workflow}" ]]; then
        record_result "pass" "pages" "pages.yaml" "GitHub Pages workflow exists"
        
        # Check workflow triggers
        if yq -e '.on.push' "${pages_workflow}" &>/dev/null; then
            record_result "pass" "pages" "workflow-trigger" "Push trigger configured"
        else
            record_result "warn" "pages" "workflow-trigger" "No push trigger configured"
        fi
        
        # Check for workflow_dispatch (manual trigger)
        if yq '.on | has("workflow_dispatch")' "${pages_workflow}" 2>/dev/null | grep -q "true"; then
            record_result "pass" "pages" "manual-trigger" "Manual workflow dispatch enabled"
        else
            record_result "warn" "pages" "manual-trigger" "Manual workflow dispatch not enabled"
        fi
    else
        # Check for alternative workflow names
        local alt_workflow
        for alt in "pages.yml" "gh-pages.yaml" "gh-pages.yml" "deploy-pages.yaml" "deploy-pages.yml"; do
            if [[ -f "${REPO_ROOT}/.github/workflows/${alt}" ]]; then
                alt_workflow="${alt}"
                break
            fi
        done
        
        if [[ -n "${alt_workflow}" ]]; then
            record_result "pass" "pages" "pages-workflow" "GitHub Pages workflow exists (${alt_workflow})"
        else
            record_result "warn" "pages" "pages-workflow" "No GitHub Pages workflow found"
        fi
    fi
    
    log_subsection "Static Site Directory"
    
    # Check site directory (source for GitHub Pages)
    local site_dir="${REPO_ROOT}/site"
    if [[ -d "${site_dir}" ]]; then
        local site_files
        site_files=$(find "${site_dir}" -type f | wc -l | tr -d ' ')
        record_result "pass" "pages" "site/" "Site source directory exists (${site_files} files)"
        
        # Check for index.html
        if [[ -f "${site_dir}/index.html" ]]; then
            record_result "pass" "pages" "site/index.html" "Index page exists"
        else
            record_result "warn" "pages" "site/index.html" "Missing index.html in site directory"
        fi
    else
        record_result "warn" "pages" "site/" "No site source directory found"
    fi
    
    # Check site-docs directory (MkDocs output)
    local site_docs_dir="${REPO_ROOT}/site-docs"
    if [[ -d "${site_docs_dir}" ]]; then
        local docs_files
        docs_files=$(find "${site_docs_dir}" -type f | wc -l | tr -d ' ')
        record_result "pass" "pages" "site-docs/" "Built documentation exists (${docs_files} files)"
        
        # Check for index.html in site-docs
        if [[ -f "${site_docs_dir}/index.html" ]]; then
            record_result "pass" "pages" "site-docs/index.html" "Documentation index page exists"
        else
            record_result "warn" "pages" "site-docs/index.html" "Missing index.html in site-docs"
        fi
        
        # Check sitemap
        if [[ -f "${site_docs_dir}/sitemap.xml" ]]; then
            record_result "pass" "pages" "sitemap.xml" "Sitemap exists for SEO"
        else
            record_result "warn" "pages" "sitemap.xml" "No sitemap.xml found"
        fi
    else
        record_result "warn" "pages" "site-docs/" "No built documentation (run 'make docs-build')"
    fi
    
    log_subsection "MkDocs Configuration"
    
    # Validate MkDocs configuration for Pages
    if [[ -f "${REPO_ROOT}/mkdocs.yml" ]]; then
        # Check site_url configuration
        local site_url
        site_url=$(yq '.site_url' "${REPO_ROOT}/mkdocs.yml" 2>/dev/null | grep -v '^null$' || echo "")
        if [[ -n "${site_url}" ]]; then
            record_result "pass" "pages" "mkdocs-site_url" "Site URL configured: ${site_url}"
        else
            record_result "warn" "pages" "mkdocs-site_url" "No site_url configured in mkdocs.yml"
        fi
        
        # Check for required plugins
        local has_minify
        has_minify=$(yq '.plugins[]? | select(. == "minify" or .minify)' "${REPO_ROOT}/mkdocs.yml" 2>/dev/null || echo "")
        if [[ -n "${has_minify}" ]]; then
            record_result "pass" "pages" "mkdocs-minify" "Minify plugin enabled for production"
        else
            record_result "warn" "pages" "mkdocs-minify" "Consider enabling minify plugin for smaller builds"
        fi
    fi
    
    log_subsection "Charts Documentation for Pages"
    
    # Check if chart documentation is being copied to site
    if [[ -d "${site_docs_dir}/charts" ]] || [[ -d "${site_dir}/charts" ]]; then
        local charts_dir
        if [[ -d "${site_docs_dir}/charts" ]]; then
            charts_dir="${site_docs_dir}/charts"
        else
            charts_dir="${site_dir}/charts"
        fi
        
        local chart_docs
        chart_docs=$(find "${charts_dir}" -name "*.md" -o -name "*.html" 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${chart_docs}" -gt 0 ]]; then
            record_result "pass" "pages" "chart-docs" "Chart documentation in site (${chart_docs} files)"
        else
            record_result "warn" "pages" "chart-docs" "No chart documentation files found in site"
        fi
    else
        record_result "warn" "pages" "chart-docs" "No charts directory in site output"
    fi
    
    # Check if gh CLI is available to check deployment status
    if command -v gh &>/dev/null; then
        log_subsection "GitHub Pages Deployment Status"
        
        # Try to get pages info (requires gh auth)
        local pages_status
        if pages_status=$(gh api repos/:owner/:repo/pages 2>/dev/null); then
            local pages_url
            pages_url=$(echo "${pages_status}" | yq '.html_url' 2>/dev/null || echo "")
            local pages_build_status
            pages_build_status=$(echo "${pages_status}" | yq '.status' 2>/dev/null || echo "unknown")
            
            if [[ -n "${pages_url}" && "${pages_url}" != "null" ]]; then
                record_result "pass" "pages" "deployment" "Pages deployed at ${pages_url}"
            fi
            
            if [[ "${pages_build_status}" == "built" ]]; then
                record_result "pass" "pages" "build-status" "Latest build successful"
            elif [[ "${pages_build_status}" == "building" ]]; then
                record_result "warn" "pages" "build-status" "Build in progress"
            elif [[ "${pages_build_status}" != "unknown" && "${pages_build_status}" != "null" ]]; then
                record_result "warn" "pages" "build-status" "Build status: ${pages_build_status}"
            fi
        else
            record_result "skip" "pages" "deployment" "Could not fetch Pages status (gh auth may be required)"
        fi
    else
        record_result "skip" "pages" "deployment" "gh CLI not available for deployment status check"
    fi
}

# =============================================================================
# GitHub Repository Health Checks
# =============================================================================

check_github_health() {
    [[ "${CHECK_GITHUB_HEALTH}" != "true" ]] && return
    
    log_section "Checking GitHub Repository Health"
    
    # Skip if gh CLI is not available
    if ! command -v gh &>/dev/null; then
        record_result "skip" "github" "gh-cli" "gh CLI not available - skipping GitHub health checks"
        return
    fi
    
    # Check if authenticated
    if ! gh auth status &>/dev/null; then
        record_result "skip" "github" "auth" "Not authenticated with GitHub - run 'gh auth login'"
        return
    fi
    
    record_result "pass" "github" "gh-cli" "GitHub CLI available and authenticated"
    
    log_subsection "Recent Workflow Runs"
    
    # Check recent workflow run failures
    local failed_runs
    failed_runs=$(gh run list --status failure --limit 5 --json workflowName,conclusion,createdAt,headBranch 2>/dev/null || echo "")
    
    if [[ -n "${failed_runs}" && "${failed_runs}" != "[]" ]]; then
        local failure_count
        failure_count=$(echo "${failed_runs}" | yq '. | length' 2>/dev/null || echo "0")
        
        if [[ "${failure_count}" -gt 0 ]]; then
            # Get the most recent failure info
            local recent_failure
            recent_failure=$(echo "${failed_runs}" | yq '.[0].workflowName' 2>/dev/null || echo "unknown")
            local recent_branch
            recent_branch=$(echo "${failed_runs}" | yq '.[0].headBranch' 2>/dev/null || echo "unknown")
            
            record_result "warn" "github" "failed-runs" "${failure_count} recent failed workflow runs (latest: ${recent_failure} on ${recent_branch})"
        else
            record_result "pass" "github" "failed-runs" "No recent workflow failures"
        fi
    else
        record_result "pass" "github" "failed-runs" "No recent workflow failures"
    fi
    
    # Check in-progress runs
    local in_progress_runs
    in_progress_runs=$(gh run list --status in_progress --limit 10 --json workflowName 2>/dev/null || echo "")
    
    if [[ -n "${in_progress_runs}" && "${in_progress_runs}" != "[]" ]]; then
        local in_progress_count
        in_progress_count=$(echo "${in_progress_runs}" | yq '. | length' 2>/dev/null || echo "0")
        
        if [[ "${in_progress_count}" -gt 0 ]]; then
            record_result "pass" "github" "in-progress-runs" "${in_progress_count} workflow runs currently in progress"
        fi
    fi
    
    # Check queued runs
    local queued_runs
    queued_runs=$(gh run list --status queued --limit 10 --json workflowName 2>/dev/null || echo "")
    
    if [[ -n "${queued_runs}" && "${queued_runs}" != "[]" ]]; then
        local queued_count
        queued_count=$(echo "${queued_runs}" | yq '. | length' 2>/dev/null || echo "0")
        
        if [[ "${queued_count}" -gt 0 ]]; then
            record_result "warn" "github" "queued-runs" "${queued_count} workflow runs queued (may indicate runner issues)"
        fi
    fi
    
    log_subsection "Repository Issues"
    
    # Check open issues count
    local open_issues
    open_issues=$(gh issue list --state open --limit 100 --json number 2>/dev/null || echo "")
    
    if [[ -n "${open_issues}" ]]; then
        local issue_count
        issue_count=$(echo "${open_issues}" | yq '. | length' 2>/dev/null || echo "0")
        
        if [[ "${issue_count}" -eq 0 ]]; then
            record_result "pass" "github" "open-issues" "No open issues"
        elif [[ "${issue_count}" -lt 10 ]]; then
            record_result "pass" "github" "open-issues" "${issue_count} open issues"
        elif [[ "${issue_count}" -lt 25 ]]; then
            record_result "warn" "github" "open-issues" "${issue_count} open issues (consider triaging)"
        else
            record_result "warn" "github" "open-issues" "${issue_count} open issues (high backlog)"
        fi
    fi
    
    # Check for issues with bug label
    local bug_issues
    bug_issues=$(gh issue list --state open --label bug --limit 50 --json number 2>/dev/null || echo "")
    
    if [[ -n "${bug_issues}" && "${bug_issues}" != "[]" ]]; then
        local bug_count
        bug_count=$(echo "${bug_issues}" | yq '. | length' 2>/dev/null || echo "0")
        
        if [[ "${bug_count}" -gt 0 ]]; then
            record_result "warn" "github" "bug-issues" "${bug_count} open bug issues"
        fi
    fi
    
    log_subsection "Pull Requests"
    
    # Check open PRs
    local open_prs
    open_prs=$(gh pr list --state open --limit 50 --json number,isDraft,reviewDecision 2>/dev/null || echo "")
    
    if [[ -n "${open_prs}" ]]; then
        local pr_count
        pr_count=$(echo "${open_prs}" | yq '. | length' 2>/dev/null || echo "0")
        
        if [[ "${pr_count}" -eq 0 ]]; then
            record_result "pass" "github" "open-prs" "No open pull requests"
        else
            # Count draft PRs
            local draft_count
            draft_count=$(echo "${open_prs}" | yq '[.[] | select(.isDraft == true)] | length' 2>/dev/null || echo "0")
            
            # Count PRs needing review
            local needs_review
            needs_review=$(echo "${open_prs}" | yq '[.[] | select(.reviewDecision == null or .reviewDecision == "REVIEW_REQUIRED")] | length' 2>/dev/null || echo "0")
            
            if [[ "${pr_count}" -lt 5 ]]; then
                record_result "pass" "github" "open-prs" "${pr_count} open PRs (${draft_count} drafts, ${needs_review} need review)"
            else
                record_result "warn" "github" "open-prs" "${pr_count} open PRs (${draft_count} drafts, ${needs_review} need review)"
            fi
        fi
    fi
    
    # Check for stale PRs (no activity in 30+ days)
    local stale_prs
    stale_prs=$(gh pr list --state open --limit 50 --json number,updatedAt 2>/dev/null || echo "")
    
    if [[ -n "${stale_prs}" && "${stale_prs}" != "[]" ]]; then
        local thirty_days_ago
        thirty_days_ago=$(date -v-30d +%Y-%m-%d 2>/dev/null || date -d "30 days ago" +%Y-%m-%d 2>/dev/null || echo "")
        
        if [[ -n "${thirty_days_ago}" ]]; then
            local stale_count
            stale_count=$(echo "${stale_prs}" | yq "[.[] | select(.updatedAt < \"${thirty_days_ago}\")] | length" 2>/dev/null || echo "0")
            
            if [[ "${stale_count}" -gt 0 ]]; then
                record_result "warn" "github" "stale-prs" "${stale_count} stale PRs (no activity in 30+ days)"
            fi
        fi
    fi
    
    log_subsection "Branch Protection"
    
    # Check default branch
    local default_branch
    default_branch=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name' 2>/dev/null || echo "main")
    record_result "pass" "github" "default-branch" "Default branch: ${default_branch}"
    
    # Try to check branch protection (may require admin access)
    local branch_protection
    if branch_protection=$(gh api "repos/:owner/:repo/branches/${default_branch}/protection" 2>/dev/null); then
        local require_reviews
        require_reviews=$(echo "${branch_protection}" | yq '.required_pull_request_reviews.required_approving_review_count // 0' 2>/dev/null || echo "0")
        
        if [[ "${require_reviews}" -gt 0 ]]; then
            record_result "pass" "github" "branch-protection" "Branch protection enabled (${require_reviews} required reviews)"
        else
            record_result "warn" "github" "branch-protection" "Branch protection enabled but no required reviews"
        fi
        
        # Check status checks
        local require_status
        require_status=$(echo "${branch_protection}" | yq '.required_status_checks.strict // false' 2>/dev/null || echo "false")
        
        if [[ "${require_status}" == "true" ]]; then
            record_result "pass" "github" "status-checks" "Strict status checks required"
        fi
    else
        record_result "skip" "github" "branch-protection" "Could not fetch branch protection (may require admin access)"
    fi
    
    log_subsection "Repository Settings"
    
    # Check repository visibility and features
    local repo_info
    if repo_info=$(gh repo view --json isPrivate,hasIssuesEnabled,hasWikiEnabled,hasProjectsEnabled,securityPolicyUrl 2>/dev/null); then
        local is_private
        is_private=$(echo "${repo_info}" | yq '.isPrivate' 2>/dev/null || echo "unknown")
        
        if [[ "${is_private}" == "true" ]]; then
            record_result "pass" "github" "visibility" "Repository is private"
        else
            record_result "pass" "github" "visibility" "Repository is public"
        fi
        
        local has_issues
        has_issues=$(echo "${repo_info}" | yq '.hasIssuesEnabled' 2>/dev/null || echo "false")
        if [[ "${has_issues}" == "true" ]]; then
            record_result "pass" "github" "issues-enabled" "Issues are enabled"
        fi
        
        local security_policy
        security_policy=$(echo "${repo_info}" | yq '.securityPolicyUrl' 2>/dev/null || echo "")
        if [[ -n "${security_policy}" && "${security_policy}" != "null" ]]; then
            record_result "pass" "github" "security-policy" "Security policy configured"
        else
            record_result "warn" "github" "security-policy" "No security policy (consider adding SECURITY.md)"
        fi
    fi
    
    log_subsection "Dependabot & Security"
    
    # Check if dependabot is configured
    if [[ -f "${REPO_ROOT}/.github/dependabot.yml" ]] || [[ -f "${REPO_ROOT}/.github/dependabot.yaml" ]]; then
        record_result "pass" "github" "dependabot" "Dependabot configuration exists"
    else
        record_result "warn" "github" "dependabot" "No Dependabot configuration"
    fi
    
    # Check for security advisories (Dependabot alerts)
    local vuln_alerts
    if vuln_alerts=$(gh api "repos/:owner/:repo/vulnerability-alerts" 2>/dev/null); then
        record_result "pass" "github" "vuln-alerts" "Vulnerability alerts enabled"
    else
        # 404 means not enabled, other errors might be permissions
        record_result "skip" "github" "vuln-alerts" "Could not check vulnerability alerts status"
    fi
    
    # Check for renovate config as alternative to dependabot
    if [[ -f "${REPO_ROOT}/renovate.json" ]] || [[ -f "${REPO_ROOT}/.github/renovate.json" ]] || [[ -f "${REPO_ROOT}/renovate.json5" ]]; then
        record_result "pass" "github" "renovate" "Renovate configuration exists"
    fi
}

# =============================================================================
# Python Environment Checks
# =============================================================================

check_python_environment() {
    [[ "${CHECK_PYTHON}" != "true" ]] && return
    
    log_section "Checking Python Environment"
    
    log_subsection "Python Configuration"
    
    # Check pyproject.toml
    if [[ -f "${REPO_ROOT}/pyproject.toml" ]]; then
        local python_version
        python_version=$(grep 'requires-python' "${REPO_ROOT}/pyproject.toml" 2>/dev/null | head -1 | cut -d'"' -f2)
        record_result "pass" "python" "pyproject.toml" "Project configuration exists (Python ${python_version:-unknown})"
    else
        record_result "warn" "python" "pyproject.toml" "Missing pyproject.toml"
    fi
    
    # Check uv lock file
    if [[ -f "${REPO_ROOT}/uv.lock" ]]; then
        record_result "pass" "python" "uv.lock" "Lock file exists"
    else
        record_result "warn" "python" "uv.lock" "Missing uv.lock (run 'uv sync')"
    fi
    
    # Check virtual environment
    if [[ -d "${REPO_ROOT}/.venv" ]]; then
        record_result "pass" "python" "virtualenv" "Virtual environment exists"
    else
        record_result "warn" "python" "virtualenv" "No virtual environment (run 'uv sync')"
    fi
    
    log_subsection "Python Scripts"
    
    local scripts_dir="${REPO_ROOT}/scripts"
    if [[ -d "${scripts_dir}" ]]; then
        while IFS= read -r script; do
            [[ -z "${script}" ]] && continue
            local script_name
            script_name=$(basename "${script}")
            
            # Try to check syntax
            if python3 -m py_compile "${script}" 2>/dev/null; then
                record_result "pass" "python" "${script_name}" "Valid Python syntax"
            else
                record_result "fail" "python" "${script_name}" "Python syntax error"
            fi
        done < <(find "${scripts_dir}" -name "*.py" -type f 2>/dev/null)
    fi
}

# =============================================================================
# Security Checks
# =============================================================================

check_security() {
    [[ "${CHECK_SECURITY}" != "true" ]] && return
    
    log_section "Checking Security Configuration"
    
    log_subsection "Sensitive Files"
    
    # Check for potential secrets in repository
    local secret_patterns=(
        "password"
        "secret"
        "api_key"
        "apikey"
        "token"
        "private_key"
    )
    
    local secrets_found=0
    for pattern in "${secret_patterns[@]}"; do
        local matches
        matches=$(grep -r -l -i "${pattern}" "${REPO_ROOT}" \
            --include="*.yaml" --include="*.yml" --include="*.json" \
            --exclude-dir=".git" --exclude-dir="node_modules" --exclude-dir=".venv" \
            --exclude-dir="examples" --exclude="*values.yaml" \
            2>/dev/null | wc -l | tr -d ' ')
        
        if [[ "${matches}" -gt 0 ]]; then
            ((secrets_found += matches))
            log_verbose "Found ${matches} files with pattern '${pattern}'"
        fi
    done
    
    if [[ "${secrets_found}" -eq 0 ]]; then
        record_result "pass" "security" "secrets-scan" "No potential secrets found in config files"
    else
        record_result "warn" "security" "secrets-scan" "Found ${secrets_found} files with potential sensitive data (review recommended)"
    fi
    
    # Check .gitignore for sensitive patterns
    if [[ -f "${REPO_ROOT}/.gitignore" ]]; then
        local secure_patterns=(".env" "secrets" "*.key" "*.pem")
        local missing_patterns=()
        
        for pattern in "${secure_patterns[@]}"; do
            if ! grep -q "${pattern}" "${REPO_ROOT}/.gitignore" 2>/dev/null; then
                missing_patterns+=("${pattern}")
            fi
        done
        
        if [[ ${#missing_patterns[@]} -eq 0 ]]; then
            record_result "pass" "security" "gitignore" "Sensitive patterns are ignored"
        else
            record_result "warn" "security" "gitignore" "Consider adding to .gitignore: ${missing_patterns[*]}"
        fi
    fi
    
    # Check SOPS configuration
    if [[ -f "${REPO_ROOT}/.sops.yaml" ]]; then
        record_result "pass" "security" "sops" "SOPS encryption configured"
    else
        record_result "warn" "security" "sops" "No SOPS configuration (secrets management)"
    fi
}

# =============================================================================
# Summary and Output
# =============================================================================

print_summary() {
    log_section "Health Check Summary"
    
    local total=$((CHECKS_PASSED + CHECKS_FAILED + CHECKS_WARNED + CHECKS_SKIPPED))
    
    echo ""
    echo -e "  ${GREEN}✓ Passed:${RESET}  ${CHECKS_PASSED}"
    echo -e "  ${RED}✗ Failed:${RESET}  ${CHECKS_FAILED}"
    echo -e "  ${YELLOW}⚠ Warnings:${RESET} ${CHECKS_WARNED}"
    echo -e "  ${DIM}⊘ Skipped:${RESET} ${CHECKS_SKIPPED}"
    echo -e "  ${BOLD}─────────────────${RESET}"
    echo -e "  ${BOLD}Total:${RESET}    ${total}"
    echo ""
    
    if [[ "${CHECKS_FAILED}" -gt 0 ]]; then
        echo -e "${RED}${BOLD}✗ Repository health check FAILED${RESET}"
        echo -e "${DIM}  Fix the errors above to ensure repository integrity.${RESET}"
    elif [[ "${CHECKS_WARNED}" -gt 0 && "${STRICT}" == "true" ]]; then
        echo -e "${YELLOW}${BOLD}⚠ Repository health check completed with warnings (strict mode)${RESET}"
        echo -e "${DIM}  Review the warnings above for potential improvements.${RESET}"
    elif [[ "${CHECKS_WARNED}" -gt 0 ]]; then
        echo -e "${YELLOW}${BOLD}⚠ Repository health check PASSED with warnings${RESET}"
        echo -e "${DIM}  Review the warnings above for potential improvements.${RESET}"
    else
        echo -e "${GREEN}${BOLD}✓ Repository health check PASSED${RESET}"
        echo -e "${DIM}  All checks completed successfully!${RESET}"
    fi
    echo ""
}

output_json() {
    echo "{"
    echo "  \"summary\": {"
    echo "    \"passed\": ${CHECKS_PASSED},"
    echo "    \"failed\": ${CHECKS_FAILED},"
    echo "    \"warned\": ${CHECKS_WARNED},"
    echo "    \"skipped\": ${CHECKS_SKIPPED},"
    echo "    \"total\": $((CHECKS_PASSED + CHECKS_FAILED + CHECKS_WARNED + CHECKS_SKIPPED))"
    echo "  },"
    echo "  \"results\": ["
    local first=true
    for result in "${JSON_RESULTS[@]}"; do
        if [[ "${first}" == "true" ]]; then
            first=false
        else
            echo ","
        fi
        echo -n "    ${result}"
    done
    echo ""
    echo "  ]"
    echo "}"
}

# =============================================================================
# Help
# =============================================================================

show_help() {
    cat << EOF
Repository Health Check Script
==============================

A comprehensive, reusable health check script for Helm chart repositories.
Performs checks on repository structure, charts, documentation, CI/CD,
GitHub configuration, and more.

Usage:
  ${0##*/} [options]

Options:
  -v, --verbose    Enable verbose output with additional details
  -q, --quiet      Only show errors and final summary
  -s, --strict     Exit with code 1 on warnings (in addition to errors)
  --no-color       Disable colored output
  --json           Output results as JSON (implies --quiet)
  -h, --help       Show this help message

Checks Performed:
  • Dependencies    - Required and optional tools (helm, git, yq, etc.)
  • Structure       - Base repo files (LICENSE, CONTRIBUTING, SECURITY, etc.)
                    - GitHub config (issue templates, PR templates, CODEOWNERS)
                    - Test infrastructure, site, templates, scripts
  • Charts          - Helm chart validation and linting
  • Documentation   - README files and MkDocs configuration
  • Git             - Repository status, hooks, and configuration
  • CI/CD           - GitHub Actions workflows
  • GitHub Pages    - Pages workflow, site directories, and deployment status
  • GitHub Health   - Workflow failures, issues, PRs, branch protection
  • Python          - Python environment and scripts
  • Security        - Secrets scanning and .gitignore patterns

Configuration:
  The script auto-detects repository structure. To customize for your repo,
  edit the REPO_CONFIG section at the top of the script, or set environment
  variables to enable/disable check categories:

    CHECK_DEPENDENCIES=true|false
    CHECK_STRUCTURE=true|false
    CHECK_CHARTS=true|false
    CHECK_DOCUMENTATION=true|false
    CHECK_GIT=true|false
    CHECK_CICD=true|false
    CHECK_GITHUB_PAGES=true|false
    CHECK_GITHUB_HEALTH=true|false
    CHECK_PYTHON=true|false
    CHECK_SECURITY=true|false

  You can also customize paths by editing the script:
    CHARTS_DIR, CHART_SUBDIRS, DOCS_DIR, SITE_DIR, TEST_DIR, etc.

Exit Codes:
  0 - All checks passed
  1 - One or more checks failed (or warnings in strict mode)
  2 - Script error

Examples:
  ${0##*/}                           # Run all checks with default output
  ${0##*/} -v                        # Run with verbose output
  ${0##*/} -q                        # Show only errors and summary
  ${0##*/} --json                    # Output as JSON for automation
  ${0##*/} -s                        # Fail on warnings (for CI)
  CHECK_CHARTS=false ${0##*/}        # Skip chart validation

EOF
}

# =============================================================================
# Main
# =============================================================================

main() {
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -q|--quiet)
                QUIET=true
                shift
                ;;
            -s|--strict)
                STRICT=true
                shift
                ;;
            --no-color)
                NO_COLOR=true
                shift
                ;;
            --json)
                JSON_OUTPUT=true
                QUIET=true
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                echo "Use --help for usage information"
                exit 2
                ;;
        esac
    done
    
    # Setup
    setup_colors
    
    # Check if we're in the repo root
    if [[ ! -f "${REPO_ROOT}/Makefile" ]]; then
        log_error "This script must be run from the helm-charts repository"
        exit 2
    fi
    
    # Show header
    if [[ "${JSON_OUTPUT}" != "true" ]]; then
        echo ""
        echo -e "${BOLD}${MAGENTA}╔═══════════════════════════════════════════════════════════════╗${RESET}"
        echo -e "${BOLD}${MAGENTA}║         Helm Charts Repository Health Check                   ║${RESET}"
        echo -e "${BOLD}${MAGENTA}║         $(date '+%Y-%m-%d %H:%M:%S')                                   ║${RESET}"
        echo -e "${BOLD}${MAGENTA}╚═══════════════════════════════════════════════════════════════╝${RESET}"
    fi
    
    # Run all checks
    check_dependencies
    check_repository_structure
    check_charts
    check_documentation
    check_git_repository
    check_cicd
    check_github_pages
    check_github_health
    check_python_environment
    check_security
    
    # Output results
    if [[ "${JSON_OUTPUT}" == "true" ]]; then
        output_json
    else
        print_summary
    fi
    
    # Determine exit code
    if [[ "${CHECKS_FAILED}" -gt 0 ]]; then
        exit 1
    elif [[ "${STRICT}" == "true" && "${CHECKS_WARNED}" -gt 0 ]]; then
        exit 1
    fi
    
    exit 0
}

main "$@"
