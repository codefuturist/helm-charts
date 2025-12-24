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
# This section uses bash arrays for easy extensibility. To customize:
# 1. Modify arrays by adding/removing elements
# 2. Set variables to empty array () or empty string "" to disable checks
# 3. Override via environment variables where supported

# Auto-detect paths - override these if your repo structure differs
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# -----------------------------------------------------------------------------
# Directory Configuration
# -----------------------------------------------------------------------------

# Chart directories - set CHARTS_DIR="" to disable chart checks
CHARTS_DIR="${REPO_ROOT}/charts"

# Subdirectories under CHARTS_DIR containing charts (bash array)
CHART_SUBDIRS=(
    "apps"
    "libs"
    "vendors"
)

# Documentation directories
DOCS_DIR="${REPO_ROOT}/docs"
SITE_DIR="${REPO_ROOT}/site"
SITE_DOCS_DIR="${REPO_ROOT}/site-docs"

# Test directory and subdirectories (bash array)
TEST_DIR="${REPO_ROOT}/test"
TEST_SUBDIRS=(
    "fixtures"
    "e2e"
    "integration"
    "unit"
)

# Templates directory
TEMPLATES_DIR="${REPO_ROOT}/templates"

# Scripts directory
SCRIPTS_DIR="${REPO_ROOT}/scripts"

# -----------------------------------------------------------------------------
# Tool Requirements (bash arrays)
# -----------------------------------------------------------------------------

# Required tools - script will fail if these are missing
REQUIRED_TOOLS=(
    "helm"
    "git"
    "yq"
    "python3"
)

# Optional tools - script will warn if these are missing
OPTIONAL_TOOLS=(
    "uv"
    "helm-docs"
    "ct"
    "pre-commit"
    "yamllint"
)

# Helm plugins to check
HELM_PLUGINS=(
    "unittest"
)

# -----------------------------------------------------------------------------
# GitHub Workflows (bash array)
# -----------------------------------------------------------------------------

# Required workflow files (relative to .github/workflows/)
REQUIRED_WORKFLOWS=(
    "lint-test.yaml"
    "release.yaml"
    "docs.yaml"
)

# -----------------------------------------------------------------------------
# Root Files to Check (bash arrays)
# -----------------------------------------------------------------------------

# Essential root files that MUST exist (will fail if missing)
ESSENTIAL_ROOT_FILES=(
    "README.md"
)

# Recommended root files (will warn if missing)
RECOMMENDED_ROOT_FILES=(
    "LICENSE"
    "Makefile"
    ".gitignore"
    ".editorconfig"
)

# Optional root configuration files to check (informational)
OPTIONAL_ROOT_FILES=(
    "pyproject.toml"
    "uv.lock"
    "package.json"
    "go.mod"
    "Cargo.toml"
    "mkdocs.yml"
    "ct.yaml"
    "Tiltfile"
    "Dockerfile"
    "docker-compose.yml"
    "renovate.json"
    ".pre-commit-config.yaml"
    ".yamllint"
    ".cz.toml"
    ".sops.yaml"
    ".gitattributes"
)

# Community/documentation files to check (with location variants)
COMMUNITY_FILES=(
    "CONTRIBUTING.md"
    "SECURITY.md"
    "CHANGELOG.md"
    "CODE_OF_CONDUCT.md"
    "CODEOWNERS"
)

# Location prefixes to search for community files
COMMUNITY_FILE_LOCATIONS=(
    ""
    "docs/"
    ".github/"
)

# -----------------------------------------------------------------------------
# Essential Directories (bash array)
# -----------------------------------------------------------------------------

# Directories that should exist (will warn if missing)
ESSENTIAL_DIRS=(
    "docs"
    ".github/workflows"
)

# -----------------------------------------------------------------------------
# Unwanted/Misplaced Files (bash arrays)
# -----------------------------------------------------------------------------

# Files that should NOT exist at repo root (common mistakes)
UNWANTED_ROOT_FILES=(
    ".DS_Store"
    "Thumbs.db"
    "desktop.ini"
    ".env"
    ".env.local"
    ".env.development"
    ".env.production"
    "*.log"
    "*.tmp"
    "*.bak"
    "*.swp"
    "*.swo"
    "*~"
    "node_modules"
    "__pycache__"
    ".pytest_cache"
    ".mypy_cache"
    ".ruff_cache"
    "*.pyc"
    "*.pyo"
    ".coverage"
    "coverage.xml"
    "htmlcov"
    ".tox"
    ".nox"
    "dist"
    "build"
    "*.egg-info"
    ".eggs"
    "venv"
    ".venv"
    "env"
    ".idea"
    ".vscode"
    "*.iml"
    ".project"
    ".classpath"
    ".settings"
    "*.sublime-*"
    ".terraform"
    "*.tfstate"
    "*.tfstate.*"
    "crash.log"
)

# Files that should NOT exist anywhere in the repo (glob patterns)
UNWANTED_FILES_ANYWHERE=(
    "**/.DS_Store"
    "**/Thumbs.db"
    "**/*.log"
    "**/*.tmp"
    "**/*.bak"
    "**/*.swp"
    "**/*.swo"
    "**/*~"
    "**/__pycache__/**"
    "**/*.pyc"
    "**/*.pyo"
    "**/.env"
    "**/.env.local"
)

# Files that are misplaced (pattern -> expected location)
# Format: "file_pattern|expected_location_description"
MISPLACED_FILE_PATTERNS=(
    "charts/**/README.md|docs/ or chart root only"
    "*.yaml|appropriate directory (not root, unless config)"
    "*.yml|appropriate directory (not root, unless config)"
)

# Directories that should NOT exist at repo root
UNWANTED_ROOT_DIRS=(
    "node_modules"
    "__pycache__"
    ".pytest_cache"
    ".mypy_cache"
    ".ruff_cache"
    ".coverage"
    "htmlcov"
    ".tox"
    ".nox"
    "dist"
    "build"
    ".eggs"
    "venv"
    ".venv"
    "env"
    ".idea"
    ".vscode"
    ".settings"
    ".terraform"
    ".cache"
)

# Temporary/generated files that should be cleaned up
TEMPORARY_FILE_PATTERNS=(
    "*.orig"
    "*.rej"
    "*.backup"
    "*.old"
    "*_backup"
    "*_old"
    "*.BACKUP.*"
    "*.BASE.*"
    "*.LOCAL.*"
    "*.REMOTE.*"
)

# Large files that probably shouldn't be committed (in bytes, 10MB default)
LARGE_FILE_THRESHOLD="${LARGE_FILE_THRESHOLD:-10485760}"

# File extensions that are suspicious in a Helm repo
SUSPICIOUS_EXTENSIONS=(
    ".exe"
    ".dll"
    ".so"
    ".dylib"
    ".bin"
    ".dat"
    ".zip"
    ".tar"
    ".tar.gz"
    ".tgz"
    ".rar"
    ".7z"
    ".jar"
    ".war"
    ".ear"
    ".class"
    ".o"
    ".a"
)

# -----------------------------------------------------------------------------
# Gitignore Pattern Verification (bash arrays)
# -----------------------------------------------------------------------------
# Patterns that SHOULD be ignored by git and should not be tracked.
# These are common OS, IDE, and temporary files that should never be committed.

# Linux patterns that should be gitignored
GITIGNORE_LINUX_PATTERNS=(
    "*~"
    ".fuse_hidden*"
    ".directory"
    ".Trash-*"
    ".nfs*"
)

# macOS patterns that should be gitignored
GITIGNORE_MACOS_PATTERNS=(
    ".DS_Store"
    ".AppleDouble"
    ".LSOverride"
    "Icon"
    "._*"
    ".DocumentRevisions-V100"
    ".fseventsd"
    ".Spotlight-V100"
    ".TemporaryItems"
    ".Trashes"
    ".VolumeIcon.icns"
    ".com.apple.timemachine.donotpresent"
    ".AppleDB"
    ".AppleDesktop"
    "Network Trash Folder"
    "Temporary Items"
    ".apdisk"
    "*.icloud"
)

# Windows patterns that should be gitignored
GITIGNORE_WINDOWS_PATTERNS=(
    "Thumbs.db"
    "Thumbs.db:encryptable"
    "ehthumbs.db"
    "ehthumbs_vista.db"
    "*.stackdump"
    "[Dd]esktop.ini"
    "\$RECYCLE.BIN/"
    "*.cab"
    "*.msi"
    "*.msix"
    "*.msm"
    "*.msp"
    "*.lnk"
)

# -----------------------------------------------------------------------------
# Security Patterns (bash array)
# -----------------------------------------------------------------------------

# Patterns to scan for potential secrets (case-insensitive grep)
SECRET_PATTERNS=(
    "password"
    "secret"
    "api_key"
    "apikey"
    "token"
    "private_key"
    "credential"
)

# File extensions to exclude from secret scanning
SECRET_SCAN_EXCLUDES=(
    "*.md"
    "*.txt"
    "*.yaml"
    "*.yml"
    "*.json"
    "*.lock"
)

# -----------------------------------------------------------------------------
# Check Category Toggles (environment variable overrides supported)
# -----------------------------------------------------------------------------

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
CHECK_UNWANTED="${CHECK_UNWANTED:-true}"
CHECK_GITIGNORE="${CHECK_GITIGNORE:-true}"

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

# Get version for a tool (extensible - add new tools here)
get_tool_version() {
    local tool="$1"
    local version=""
    
    case "${tool}" in
        helm)       version=$(helm version --short 2>/dev/null | head -1) ;;
        git)        version=$(git --version 2>/dev/null | awk '{print $3}') ;;
        yq)         version=$(yq --version 2>/dev/null | head -1 | awk '{print $NF}') ;;
        python3)    version=$(python3 --version 2>/dev/null | awk '{print $2}') ;;
        python)     version=$(python --version 2>/dev/null | awk '{print $2}') ;;
        node)       version=$(node --version 2>/dev/null) ;;
        npm)        version=$(npm --version 2>/dev/null) ;;
        go)         version=$(go version 2>/dev/null | awk '{print $3}') ;;
        docker)     version=$(docker --version 2>/dev/null | awk '{print $3}' | tr -d ',') ;;
        kubectl)    version=$(kubectl version --client --short 2>/dev/null | awk '{print $3}') ;;
        uv)         version=$(uv --version 2>/dev/null | awk '{print $2}') ;;
        helm-docs)  version=$(helm-docs --version 2>/dev/null | head -1) ;;
        ct)         version=$(ct version 2>/dev/null | head -1) ;;
        pre-commit) version=$(pre-commit --version 2>/dev/null | awk '{print $2}') ;;
        yamllint)   version=$(yamllint --version 2>/dev/null | awk '{print $2}') ;;
        jq)         version=$(jq --version 2>/dev/null) ;;
        shellcheck) version=$(shellcheck --version 2>/dev/null | grep "^version:" | awk '{print $2}') ;;
        *)          version=$(${tool} --version 2>/dev/null | head -1) ;;
    esac
    
    echo "${version:-unknown}"
}

check_dependencies() {
    [[ "${CHECK_DEPENDENCIES}" != "true" ]] && return
    
    log_section "Checking Required Dependencies"
    
    # Check required tools
    if [[ ${#REQUIRED_TOOLS[@]} -gt 0 ]]; then
        log_subsection "Required Tools"
        for tool in "${REQUIRED_TOOLS[@]}"; do
            [[ -z "${tool}" ]] && continue
            if command -v "${tool}" &>/dev/null; then
                local version
                version=$(get_tool_version "${tool}")
                record_result "pass" "dependencies" "${tool}" "Found (${version})"
            else
                record_result "fail" "dependencies" "${tool}" "Not found - required for repository operations"
            fi
        done
    fi
    
    # Check optional tools
    if [[ ${#OPTIONAL_TOOLS[@]} -gt 0 ]]; then
        log_subsection "Optional Tools"
        for tool in "${OPTIONAL_TOOLS[@]}"; do
            [[ -z "${tool}" ]] && continue
            if command -v "${tool}" &>/dev/null; then
                local version
                version=$(get_tool_version "${tool}")
                record_result "pass" "dependencies" "${tool}" "Found (${version})"
            else
                record_result "warn" "dependencies" "${tool}" "Not found - some features may be unavailable"
            fi
        done
    fi
    
    # Check helm plugins
    if [[ ${#HELM_PLUGINS[@]} -gt 0 ]] && command -v helm &>/dev/null; then
        log_subsection "Helm Plugins"
        for plugin in "${HELM_PLUGINS[@]}"; do
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

# Helper: Get file info for display
get_file_info() {
    local file="$1"
    local info=""
    
    if [[ -f "${file}" ]]; then
        local lines size
        lines=$(wc -l < "${file}" 2>/dev/null | tr -d ' ')
        size=$(du -h "${file}" 2>/dev/null | awk '{print $1}')
        info="${lines} lines, ${size}"
    fi
    
    echo "${info}"
}

# Helper: Detect license type
detect_license_type() {
    local file="$1"
    
    if grep -qi "MIT" "${file}" 2>/dev/null; then
        echo "MIT"
    elif grep -qi "Apache" "${file}" 2>/dev/null; then
        echo "Apache"
    elif grep -qi "GPL" "${file}" 2>/dev/null; then
        echo "GPL"
    elif grep -qi "BSD" "${file}" 2>/dev/null; then
        echo "BSD"
    elif grep -qi "ISC" "${file}" 2>/dev/null; then
        echo "ISC"
    elif grep -qi "MPL" "${file}" 2>/dev/null; then
        echo "MPL"
    else
        echo "Custom"
    fi
}

# Helper: Get details for a specific file type
get_file_details() {
    local file="$1"
    local basename
    basename=$(basename "${file}")
    
    case "${basename}" in
        Makefile)
            local targets
            targets=$(grep -c "^[a-zA-Z_-]*:" "${file}" 2>/dev/null || echo "0")
            echo "${targets} targets"
            ;;
        README.md|CONTRIBUTING.md|CHANGELOG.md|SECURITY.md|CODE_OF_CONDUCT.md)
            get_file_info "${file}"
            ;;
        LICENSE)
            local size
            size=$(wc -c < "${file}" 2>/dev/null | tr -d ' ')
            if [[ "${size}" -gt 0 ]]; then
                echo "$(detect_license_type "${file}")"
            else
                echo "empty"
            fi
            ;;
        pyproject.toml)
            local deps
            deps=$(grep -c "dependencies" "${file}" 2>/dev/null || echo "0")
            echo "deps: ${deps} sections"
            ;;
        package.json)
            local deps
            deps=$(grep -c "dependencies" "${file}" 2>/dev/null || echo "0")
            echo "${deps} dependency sections"
            ;;
        *.lock|uv.lock|package-lock.json|yarn.lock|Cargo.lock)
            du -h "${file}" 2>/dev/null | awk '{print $1}'
            ;;
        mkdocs.yml)
            local site_name
            site_name=$(yq '.site_name' "${file}" 2>/dev/null | grep -v '^null$' || echo "")
            [[ -n "${site_name}" ]] && echo "site: ${site_name}" || echo ""
            ;;
        ct.yaml)
            local dirs
            dirs=$(yq '.chart-dirs | length' "${file}" 2>/dev/null || echo "0")
            echo "${dirs} chart dirs"
            ;;
        Tiltfile)
            get_file_info "${file}"
            ;;
        .gitignore)
            local rules
            rules=$(grep -v '^#' "${file}" 2>/dev/null | grep -v '^$' | wc -l | tr -d ' ')
            echo "${rules} patterns"
            ;;
        .gitattributes)
            local rules
            rules=$(grep -v '^#' "${file}" 2>/dev/null | grep -v '^$' | wc -l | tr -d ' ')
            echo "${rules} rules"
            ;;
        .pre-commit-config.yaml)
            local hooks
            hooks=$(grep -c "id:" "${file}" 2>/dev/null || echo "0")
            echo "${hooks} hooks"
            ;;
        .editorconfig)
            local sections
            sections=$(grep -c "^\[" "${file}" 2>/dev/null || echo "0")
            echo "${sections} sections"
            ;;
        .cz.toml)
            local cz_name
            cz_name=$(grep "name" "${file}" 2>/dev/null | head -1 | cut -d'"' -f2 || echo "default")
            echo "${cz_name}"
            ;;
        .sops.yaml)
            local rules
            rules=$(grep -c "path_regex" "${file}" 2>/dev/null || echo "0")
            echo "${rules} rules"
            ;;
        CODEOWNERS)
            local rules
            rules=$(grep -v '^#' "${file}" 2>/dev/null | grep -v '^$' | wc -l | tr -d ' ')
            echo "${rules} rules"
            ;;
        *)
            echo ""
            ;;
    esac
}

check_repository_structure() {
    [[ "${CHECK_STRUCTURE}" != "true" ]] && return
    
    log_section "Checking Repository Structure"
    
    # -------------------------------------------------------------------------
    # Check essential root files (must exist)
    # -------------------------------------------------------------------------
    if [[ ${#ESSENTIAL_ROOT_FILES[@]} -gt 0 ]]; then
        log_subsection "Essential Files"
        for file in "${ESSENTIAL_ROOT_FILES[@]}"; do
            [[ -z "${file}" ]] && continue
            if [[ -f "${REPO_ROOT}/${file}" ]]; then
                local details
                details=$(get_file_details "${REPO_ROOT}/${file}")
                if [[ -n "${details}" ]]; then
                    record_result "pass" "structure" "${file}" "Exists (${details})"
                else
                    record_result "pass" "structure" "${file}" "Exists"
                fi
            else
                record_result "fail" "structure" "${file}" "Missing essential file"
            fi
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check recommended root files (should exist)
    # -------------------------------------------------------------------------
    if [[ ${#RECOMMENDED_ROOT_FILES[@]} -gt 0 ]]; then
        log_subsection "Recommended Files"
        for file in "${RECOMMENDED_ROOT_FILES[@]}"; do
            [[ -z "${file}" ]] && continue
            if [[ -f "${REPO_ROOT}/${file}" ]]; then
                local details
                details=$(get_file_details "${REPO_ROOT}/${file}")
                if [[ -n "${details}" && "${details}" != "empty" ]]; then
                    record_result "pass" "structure" "${file}" "Exists (${details})"
                elif [[ "${details}" == "empty" ]]; then
                    record_result "warn" "structure" "${file}" "File is empty"
                else
                    record_result "pass" "structure" "${file}" "Exists"
                fi
            else
                record_result "warn" "structure" "${file}" "Recommended file missing"
            fi
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check optional configuration files (informational)
    # -------------------------------------------------------------------------
    if [[ ${#OPTIONAL_ROOT_FILES[@]} -gt 0 ]]; then
        log_subsection "Configuration Files"
        for file in "${OPTIONAL_ROOT_FILES[@]}"; do
            [[ -z "${file}" ]] && continue
            if [[ -f "${REPO_ROOT}/${file}" ]]; then
                local details
                details=$(get_file_details "${REPO_ROOT}/${file}")
                if [[ -n "${details}" ]]; then
                    record_result "pass" "structure" "${file}" "${details}"
                else
                    record_result "pass" "structure" "${file}" "Configured"
                fi
            fi
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check community/documentation files (with location variants)
    # -------------------------------------------------------------------------
    if [[ ${#COMMUNITY_FILES[@]} -gt 0 ]]; then
        log_subsection "Community & Documentation"
        for file in "${COMMUNITY_FILES[@]}"; do
            [[ -z "${file}" ]] && continue
            local found=false
            local found_path=""
            
            for prefix in "${COMMUNITY_FILE_LOCATIONS[@]}"; do
                local check_path="${REPO_ROOT}/${prefix}${file}"
                if [[ -f "${check_path}" ]]; then
                    found=true
                    found_path="${prefix}${file}"
                    break
                fi
            done
            
            if [[ "${found}" == "true" ]]; then
                local details
                details=$(get_file_details "${REPO_ROOT}/${found_path}")
                if [[ -n "${details}" ]]; then
                    record_result "pass" "structure" "${file}" "Found at ${found_path} (${details})"
                else
                    record_result "pass" "structure" "${file}" "Found at ${found_path}"
                fi
            else
                record_result "warn" "structure" "${file}" "Not found"
            fi
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check essential directories
    # -------------------------------------------------------------------------
    log_subsection "Directory Structure"
    
    # Check configured essential directories
    for dir in "${ESSENTIAL_DIRS[@]}"; do
        [[ -z "${dir}" ]] && continue
        if [[ -d "${REPO_ROOT}/${dir}" ]]; then
            local count
            count=$(find "${REPO_ROOT}/${dir}" -maxdepth 1 \( -type f -o -type d \) 2>/dev/null | wc -l | tr -d ' ')
            record_result "pass" "structure" "${dir}" "Directory exists (${count} items)"
        else
            record_result "warn" "structure" "${dir}" "Directory not found"
        fi
    done
    
    # Check chart directories if configured
    if [[ -n "${CHARTS_DIR}" && -d "${CHARTS_DIR}" ]]; then
        local count
        count=$(find "${CHARTS_DIR}" -maxdepth 1 \( -type f -o -type d \) 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "structure" "$(basename "${CHARTS_DIR}")" "Charts directory (${count} items)"
        
        for subdir in "${CHART_SUBDIRS[@]}"; do
            [[ -z "${subdir}" ]] && continue
            if [[ -d "${CHARTS_DIR}/${subdir}" ]]; then
                count=$(find "${CHARTS_DIR}/${subdir}" -maxdepth 1 \( -type f -o -type d \) 2>/dev/null | wc -l | tr -d ' ')
                record_result "pass" "structure" "$(basename "${CHARTS_DIR}")/${subdir}" "Directory exists (${count} items)"
            fi
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check test infrastructure
    # -------------------------------------------------------------------------
    if [[ -n "${TEST_DIR}" && -d "${TEST_DIR}" ]]; then
        log_subsection "Test Infrastructure"
        record_result "pass" "structure" "test/" "Test directory exists"
        
        for subdir in "${TEST_SUBDIRS[@]}"; do
            [[ -z "${subdir}" ]] && continue
            if [[ -d "${TEST_DIR}/${subdir}" ]]; then
                local file_count
                file_count=$(find "${TEST_DIR}/${subdir}" -type f 2>/dev/null | wc -l | tr -d ' ')
                if [[ "${file_count}" -gt 0 ]]; then
                    record_result "pass" "structure" "test/${subdir}" "Test ${subdir} directory (${file_count} files)"
                else
                    record_result "warn" "structure" "test/${subdir}" "Test ${subdir} directory is empty"
                fi
            fi
        done
        
        # Chart unit test coverage
        check_chart_test_coverage
    fi
    
    # -------------------------------------------------------------------------
    # Check site/static assets
    # -------------------------------------------------------------------------
    if [[ -n "${SITE_DIR}" && -d "${SITE_DIR}" ]]; then
        log_subsection "Site & Static Assets"
        check_site_directory
    fi
    
    # -------------------------------------------------------------------------
    # Check templates
    # -------------------------------------------------------------------------
    if [[ -n "${TEMPLATES_DIR}" && -d "${TEMPLATES_DIR}" ]]; then
        log_subsection "Templates & Scaffolding"
        check_templates_directory
    fi
    
    # -------------------------------------------------------------------------
    # Check scripts
    # -------------------------------------------------------------------------
    if [[ -n "${SCRIPTS_DIR}" && -d "${SCRIPTS_DIR}" ]]; then
        log_subsection "Scripts & Automation"
        check_scripts_directory
    fi
    
    # -------------------------------------------------------------------------
    # Check GitHub configuration
    # -------------------------------------------------------------------------
    log_subsection "GitHub Configuration"
    check_github_config
}

# Helper: Check chart unit test coverage
check_chart_test_coverage() {
    [[ -z "${CHARTS_DIR}" || ! -d "${CHARTS_DIR}" ]] && return
    
    local charts_with_tests=0
    local charts_total=0
    
    for subdir in "${CHART_SUBDIRS[@]}"; do
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
            record_result "pass" "structure" "chart-tests" "Chart unit test coverage: ${test_coverage}% (${charts_with_tests}/${charts_total})"
        elif [[ "${test_coverage}" -gt 0 ]]; then
            record_result "warn" "structure" "chart-tests" "Low test coverage: ${test_coverage}% (${charts_with_tests}/${charts_total})"
        else
            record_result "warn" "structure" "chart-tests" "No chart unit tests (0/${charts_total})"
        fi
    fi
}

# Helper: Check site directory
check_site_directory() {
    local site_file_count
    site_file_count=$(find "${SITE_DIR}" -type f 2>/dev/null | wc -l | tr -d ' ')
    record_result "pass" "structure" "site/" "Site directory (${site_file_count} files)"
    
    [[ -f "${SITE_DIR}/index.html" ]] && \
        record_result "pass" "structure" "site/index.html" "Site index page exists"
    
    if [[ -f "${SITE_DIR}/index.yaml" ]]; then
        local chart_count
        chart_count=$(grep -c "^  [a-zA-Z]" "${SITE_DIR}/index.yaml" 2>/dev/null || echo "0")
        record_result "pass" "structure" "site/index.yaml" "Helm repo index (${chart_count} entries)"
    fi
    
    if [[ -f "${SITE_DIR}/CNAME" ]]; then
        local domain
        domain=$(head -1 "${SITE_DIR}/CNAME" 2>/dev/null)
        record_result "pass" "structure" "site/CNAME" "Custom domain: ${domain}"
    fi
    
    [[ -f "${SITE_DIR}/.nojekyll" ]] && \
        record_result "pass" "structure" "site/.nojekyll" "Jekyll processing disabled"
    
    [[ -f "${SITE_DIR}/artifacthub-repo.yaml" ]] && \
        record_result "pass" "structure" "site/artifacthub" "ArtifactHub metadata exists"
}

# Helper: Check templates directory
check_templates_directory() {
    local template_count
    template_count=$(find "${TEMPLATES_DIR}" -type f 2>/dev/null | wc -l | tr -d ' ')
    record_result "pass" "structure" "templates/" "Templates directory (${template_count} files)"
    
    [[ -f "${TEMPLATES_DIR}/README.md.gotmpl" ]] && \
        record_result "pass" "structure" "templates/README.md.gotmpl" "Helm-docs README template"
    
    [[ -f "${TEMPLATES_DIR}/_helpers.gotmpl" ]] && \
        record_result "pass" "structure" "templates/_helpers.gotmpl" "Helm-docs helpers template"
    
    if [[ -d "${TEMPLATES_DIR}/chart-template" ]]; then
        local scaffold_files
        scaffold_files=$(find "${TEMPLATES_DIR}/chart-template" -type f 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "structure" "templates/chart-template" "Chart scaffold (${scaffold_files} files)"
        
        # Check scaffold required files
        local required=("Chart.yaml" "values.yaml" ".helmignore")
        local missing=()
        for f in "${required[@]}"; do
            [[ ! -f "${TEMPLATES_DIR}/chart-template/${f}" ]] && missing+=("${f}")
        done
        
        if [[ ${#missing[@]} -eq 0 ]]; then
            record_result "pass" "structure" "chart-template-files" "Scaffold has required files"
        else
            record_result "warn" "structure" "chart-template-files" "Missing: ${missing[*]}"
        fi
        
        [[ -d "${TEMPLATES_DIR}/chart-template/templates" ]] && \
            record_result "pass" "structure" "chart-template/templates" "Scaffold includes templates"
        [[ -d "${TEMPLATES_DIR}/chart-template/tests" ]] && \
            record_result "pass" "structure" "chart-template/tests" "Scaffold includes tests"
        [[ -d "${TEMPLATES_DIR}/chart-template/ci" ]] && \
            record_result "pass" "structure" "chart-template/ci" "Scaffold includes CI values"
    fi
}

# Helper: Check scripts directory
check_scripts_directory() {
    local script_count
    script_count=$(find "${SCRIPTS_DIR}" -type f \( -name "*.sh" -o -name "*.py" -o -name "*.js" \) 2>/dev/null | wc -l | tr -d ' ')
    record_result "pass" "structure" "scripts/" "Scripts directory (${script_count} scripts)"
    
    # Check shell script executability
    local shell_scripts
    shell_scripts=$(find "${SCRIPTS_DIR}" -name "*.sh" -type f 2>/dev/null)
    local executable_count=0
    local non_executable=()
    
    while IFS= read -r script; do
        [[ -z "${script}" ]] && continue
        if [[ -x "${script}" ]]; then
            ((executable_count++))
        else
            non_executable+=("$(basename "${script}")")
        fi
    done <<< "${shell_scripts}"
    
    if [[ ${#non_executable[@]} -eq 0 && "${executable_count}" -gt 0 ]]; then
        record_result "pass" "structure" "scripts-executable" "All ${executable_count} shell scripts executable"
    elif [[ ${#non_executable[@]} -gt 0 ]]; then
        record_result "warn" "structure" "scripts-executable" "Non-executable: ${non_executable[*]}"
    fi
    
    # Check for Python scripts
    local python_count
    python_count=$(find "${SCRIPTS_DIR}" -name "*.py" -type f 2>/dev/null | wc -l | tr -d ' ')
    [[ "${python_count}" -gt 0 ]] && \
        record_result "pass" "structure" "scripts/python" "Python scripts (${python_count} files)"
}

# Helper: Check GitHub configuration
check_github_config() {
    # Check workflows
    if [[ ${#REQUIRED_WORKFLOWS[@]} -gt 0 ]]; then
        for workflow in "${REQUIRED_WORKFLOWS[@]}"; do
            [[ -z "${workflow}" ]] && continue
            if [[ -f "${REPO_ROOT}/.github/workflows/${workflow}" ]]; then
                record_result "pass" "structure" "workflow/${workflow}" "Workflow exists"
            else
                record_result "warn" "structure" "workflow/${workflow}" "Workflow missing"
            fi
        done
    fi
    
    # Check issue templates
    local issue_dir="${REPO_ROOT}/.github/ISSUE_TEMPLATE"
    if [[ -d "${issue_dir}" ]]; then
        local count
        count=$(find "${issue_dir}" \( -name "*.md" -o -name "*.yml" -o -name "*.yaml" \) 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${count}" -gt 0 ]]; then
            record_result "pass" "structure" "issue-templates" "Issue templates (${count} templates)"
        fi
    fi
    
    # Check PR template
    local pr_template_found=false
    for path in ".github/PULL_REQUEST_TEMPLATE.md" ".github/PULL_REQUEST_TEMPLATE" "PULL_REQUEST_TEMPLATE.md"; do
        if [[ -f "${REPO_ROOT}/${path}" ]]; then
            record_result "pass" "structure" "pr-template" "PR template exists"
            pr_template_found=true
            break
        fi
    done
    
    # Check custom actions
    if [[ -d "${REPO_ROOT}/.github/actions" ]]; then
        local action_count
        action_count=$(find "${REPO_ROOT}/.github/actions" \( -name "action.yml" -o -name "action.yaml" \) 2>/dev/null | wc -l | tr -d ' ')
        [[ "${action_count}" -gt 0 ]] && \
            record_result "pass" "structure" "custom-actions" "Custom actions (${action_count} actions)"
    fi
    
    # Check IDE configurations
    if [[ -d "${REPO_ROOT}/.husky" ]]; then
        local hook_count
        hook_count=$(find "${REPO_ROOT}/.husky" -type f -not -name ".*" 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "structure" ".husky" "Git hooks (${hook_count} hooks)"
    fi
    
    if [[ -d "${REPO_ROOT}/.vscode" ]]; then
        local vscode_files
        vscode_files=$(find "${REPO_ROOT}/.vscode" -name "*.json" 2>/dev/null | wc -l | tr -d ' ')
        record_result "pass" "structure" ".vscode" "VS Code config (${vscode_files} files)"
    fi
    
    [[ -d "${REPO_ROOT}/.idea" ]] && \
        record_result "pass" "structure" ".idea" "JetBrains IDE config"
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
    
    for subdir in "${CHART_SUBDIRS[@]}"; do
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
            
            # Skip subcharts
            local relative_path="${chart_path#${chart_dir}/}"
            if [[ "${relative_path}" == *"/charts/"* ]]; then
                log_verbose "Skipping subchart: ${relative_path}"
                continue
            fi
            
            ((total_charts++))
            
            if [[ -f "${chart_yaml}" ]]; then
                local name version
                name=$(yq '.name' "${chart_yaml}" 2>/dev/null | grep -v '^null$' || echo "")
                version=$(yq '.version' "${chart_yaml}" 2>/dev/null | grep -v '^null$' || echo "")
                
                if [[ -z "${name}" ]]; then
                    record_result "fail" "charts" "${category}/${chart_name}" "Missing 'name' field"
                    continue
                fi
                
                if [[ -z "${version}" ]]; then
                    record_result "fail" "charts" "${category}/${chart_name}" "Missing 'version' field"
                    continue
                fi
                
                if [[ ! -f "${chart_path}/values.yaml" ]]; then
                    record_result "warn" "charts" "${category}/${chart_name}" "Missing values.yaml (v${version})"
                    continue
                fi
                
                local lint_output
                if lint_output=$(helm lint "${chart_path}" 2>&1); then
                    ((valid_charts++))
                    record_result "pass" "charts" "${category}/${chart_name}" "Valid chart (v${version})"
                else
                    local error_count
                    error_count=$(echo "${lint_output}" | grep -c "Error:" || echo "0")
                    record_result "fail" "charts" "${category}/${chart_name}" "Lint errors: ${error_count} (v${version})"
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
    fi
    
    log_subsection "Chart Documentation"
    
    if [[ -n "${CHARTS_DIR}" && -d "${CHARTS_DIR}" ]]; then
        local charts_with_readme=0
        local charts_total=0
        
        for subdir in "${CHART_SUBDIRS[@]}"; do
            local chart_dir="${CHARTS_DIR}/${subdir}"
            [[ ! -d "${chart_dir}" ]] && continue
            
            while IFS= read -r chart_yaml; do
                [[ -z "${chart_yaml}" ]] && continue
                local chart_path
                chart_path=$(dirname "${chart_yaml}")
                
                local relative_path="${chart_path#${chart_dir}/}"
                [[ "${relative_path}" == *"/charts/"* ]] && continue
                
                ((charts_total++))
                [[ -f "${chart_path}/README.md" ]] && ((charts_with_readme++))
            done < <(find "${chart_dir}" -maxdepth 2 -name "Chart.yaml" -type f 2>/dev/null)
        done
        
        if [[ "${charts_total}" -gt 0 ]]; then
            local coverage=$((charts_with_readme * 100 / charts_total))
            if [[ "${coverage}" -ge 80 ]]; then
                record_result "pass" "docs" "chart-readmes" "Chart README coverage: ${coverage}%"
            elif [[ "${coverage}" -ge 50 ]]; then
                record_result "warn" "docs" "chart-readmes" "Chart README coverage: ${coverage}%"
            else
                record_result "warn" "docs" "chart-readmes" "Low README coverage: ${coverage}%"
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
        record_result "warn" "git" "pre-commit-hook" "Pre-commit hook not installed"
    fi
    
    # Check .gitignore
    if [[ -f "${REPO_ROOT}/.gitignore" ]]; then
        local gitignore_lines
        gitignore_lines=$(grep -v '^#' "${REPO_ROOT}/.gitignore" | grep -v '^$' | wc -l | tr -d ' ')
        record_result "pass" "git" ".gitignore" ".gitignore configured (${gitignore_lines} rules)"
    fi
    
    # -------------------------------------------------------------------------
    # Git Remote Health Checks
    # -------------------------------------------------------------------------
    check_git_remotes
}

# Helper: Comprehensive git remote health checks
check_git_remotes() {
    log_subsection "Git Remote Health"
    
    # Get list of all configured remotes
    local remotes=()
    while IFS= read -r remote; do
        [[ -n "${remote}" ]] && remotes+=("${remote}")
    done < <(git -C "${REPO_ROOT}" remote 2>/dev/null)
    
    if [[ ${#remotes[@]} -eq 0 ]]; then
        record_result "warn" "git" "remotes" "No remotes configured"
        return
    fi
    
    record_result "pass" "git" "remotes-count" "${#remotes[@]} remote(s) configured: ${remotes[*]}"
    
    # -------------------------------------------------------------------------
    # Check each remote
    # -------------------------------------------------------------------------
    for remote_name in "${remotes[@]}"; do
        local fetch_url push_url
        fetch_url=$(git -C "${REPO_ROOT}" remote get-url "${remote_name}" 2>/dev/null || echo "")
        push_url=$(git -C "${REPO_ROOT}" remote get-url --push "${remote_name}" 2>/dev/null || echo "")
        
        # Validate remote URL format
        if [[ -z "${fetch_url}" ]]; then
            record_result "fail" "git" "remote-${remote_name}-url" "No fetch URL configured"
            continue
        fi
        
        # Check URL format (SSH or HTTPS)
        local url_type="unknown"
        local url_display="${fetch_url}"
        
        if [[ "${fetch_url}" == git@* ]]; then
            url_type="SSH"
            # Extract host and repo for display
            local ssh_host="${fetch_url#git@}"
            ssh_host="${ssh_host%%:*}"
            local ssh_path="${fetch_url#*:}"
            url_display="${ssh_host}:${ssh_path}"
        elif [[ "${fetch_url}" == https://* ]]; then
            url_type="HTTPS"
            url_display="${fetch_url#https://}"
        elif [[ "${fetch_url}" == http://* ]]; then
            url_type="HTTP"
            url_display="${fetch_url#http://}"
            record_result "warn" "git" "remote-${remote_name}-protocol" "Using insecure HTTP protocol"
        elif [[ "${fetch_url}" == ssh://* ]]; then
            url_type="SSH"
            url_display="${fetch_url#ssh://}"
        elif [[ "${fetch_url}" == /* || "${fetch_url}" == ./* ]]; then
            url_type="Local"
            url_display="${fetch_url}"
        fi
        
        record_result "pass" "git" "remote-${remote_name}" "${url_type}: ${url_display}"
        
        # Check if fetch and push URLs differ
        if [[ -n "${push_url}" && "${fetch_url}" != "${push_url}" ]]; then
            record_result "warn" "git" "remote-${remote_name}-push" "Push URL differs: ${push_url}"
        fi
        
        # -------------------------------------------------------------------------
        # Test remote connectivity (with timeout)
        # -------------------------------------------------------------------------
        log_verbose "Testing connectivity to ${remote_name}..."
        
        # Use git ls-remote with timeout to test connectivity
        local ls_remote_output
        local connectivity_ok=false
        
        # Try to connect with a short timeout (5 seconds)
        if ls_remote_output=$(timeout 10 git -C "${REPO_ROOT}" ls-remote --exit-code --heads "${remote_name}" HEAD 2>&1); then
            connectivity_ok=true
            record_result "pass" "git" "remote-${remote_name}-connect" "Remote is reachable"
        else
            local exit_code=$?
            case ${exit_code} in
                2)
                    # Exit code 2 means remote is reachable but HEAD doesn't exist (empty repo or different ref)
                    connectivity_ok=true
                    record_result "pass" "git" "remote-${remote_name}-connect" "Remote is reachable (may be empty or have different refs)"
                    ;;
                124)
                    record_result "warn" "git" "remote-${remote_name}-connect" "Connection timed out (may be network issue or slow remote)"
                    ;;
                128)
                    # Authentication or access error
                    if echo "${ls_remote_output}" | grep -qi "permission denied\|authentication\|publickey"; then
                        record_result "fail" "git" "remote-${remote_name}-connect" "Authentication failed (check SSH keys or credentials)"
                    elif echo "${ls_remote_output}" | grep -qi "not found\|does not exist"; then
                        record_result "fail" "git" "remote-${remote_name}-connect" "Remote repository not found"
                    elif echo "${ls_remote_output}" | grep -qi "could not resolve\|name or service not known"; then
                        record_result "fail" "git" "remote-${remote_name}-connect" "Could not resolve hostname"
                    else
                        record_result "fail" "git" "remote-${remote_name}-connect" "Connection failed: ${ls_remote_output}"
                    fi
                    ;;
                *)
                    record_result "warn" "git" "remote-${remote_name}-connect" "Unknown connection error (exit code: ${exit_code})"
                    ;;
            esac
        fi
        
        # -------------------------------------------------------------------------
        # Check tracking branches and sync status
        # -------------------------------------------------------------------------
        if [[ "${connectivity_ok}" == "true" ]]; then
            # Check for tracking branches
            local tracking_branches=()
            while IFS= read -r branch; do
                [[ -n "${branch}" ]] && tracking_branches+=("${branch}")
            done < <(git -C "${REPO_ROOT}" branch -r 2>/dev/null | grep "^  ${remote_name}/" | sed "s|^  ${remote_name}/||" | grep -v "HEAD")
            
            if [[ ${#tracking_branches[@]} -gt 0 ]]; then
                record_result "pass" "git" "remote-${remote_name}-branches" "${#tracking_branches[@]} remote branches tracked"
                log_verbose "Remote branches: ${tracking_branches[*]:0:10}$([[ ${#tracking_branches[@]} -gt 10 ]] && echo " ... and more")"
            else
                record_result "warn" "git" "remote-${remote_name}-branches" "No remote branches tracked (run 'git fetch ${remote_name}')"
            fi
            
            # Check if local branch is ahead/behind remote
            local current_branch
            current_branch=$(git -C "${REPO_ROOT}" rev-parse --abbrev-ref HEAD 2>/dev/null)
            
            if [[ -n "${current_branch}" && "${current_branch}" != "HEAD" ]]; then
                local upstream
                upstream=$(git -C "${REPO_ROOT}" rev-parse --abbrev-ref "${current_branch}@{upstream}" 2>/dev/null || echo "")
                
                if [[ -n "${upstream}" && "${upstream}" == "${remote_name}/"* ]]; then
                    local ahead behind
                    ahead=$(git -C "${REPO_ROOT}" rev-list --count "${upstream}..${current_branch}" 2>/dev/null || echo "0")
                    behind=$(git -C "${REPO_ROOT}" rev-list --count "${current_branch}..${upstream}" 2>/dev/null || echo "0")
                    
                    if [[ "${ahead}" -eq 0 && "${behind}" -eq 0 ]]; then
                        record_result "pass" "git" "remote-${remote_name}-sync" "Branch '${current_branch}' is in sync with '${upstream}'"
                    elif [[ "${ahead}" -gt 0 && "${behind}" -eq 0 ]]; then
                        record_result "warn" "git" "remote-${remote_name}-sync" "Branch '${current_branch}' is ${ahead} commit(s) ahead of '${upstream}'"
                    elif [[ "${ahead}" -eq 0 && "${behind}" -gt 0 ]]; then
                        record_result "warn" "git" "remote-${remote_name}-sync" "Branch '${current_branch}' is ${behind} commit(s) behind '${upstream}'"
                    else
                        record_result "warn" "git" "remote-${remote_name}-sync" "Branch '${current_branch}' has diverged from '${upstream}' (${ahead} ahead, ${behind} behind)"
                    fi
                fi
            fi
        fi
        
        # -------------------------------------------------------------------------
        # Check remote-specific settings
        # -------------------------------------------------------------------------
        
        # Check fetch refspecs
        local fetch_refspecs=()
        while IFS= read -r refspec; do
            [[ -n "${refspec}" ]] && fetch_refspecs+=("${refspec}")
        done < <(git -C "${REPO_ROOT}" config --get-all "remote.${remote_name}.fetch" 2>/dev/null)
        
        if [[ ${#fetch_refspecs[@]} -gt 0 ]]; then
            log_verbose "Fetch refspecs for ${remote_name}: ${fetch_refspecs[*]}"
            
            # Check for unusual refspecs
            for refspec in "${fetch_refspecs[@]}"; do
                if [[ "${refspec}" != "+refs/heads/*:refs/remotes/${remote_name}/*" ]]; then
                    record_result "warn" "git" "remote-${remote_name}-refspec" "Non-standard fetch refspec: ${refspec}"
                fi
            done
        fi
        
        # Check push default
        local push_default
        push_default=$(git -C "${REPO_ROOT}" config --get "remote.${remote_name}.push" 2>/dev/null || echo "")
        if [[ -n "${push_default}" ]]; then
            log_verbose "Push config for ${remote_name}: ${push_default}"
        fi
        
        # -------------------------------------------------------------------------
        # Check for stale remote refs
        # -------------------------------------------------------------------------
        local stale_refs=()
        while IFS= read -r ref; do
            [[ -n "${ref}" ]] && stale_refs+=("${ref}")
        done < <(git -C "${REPO_ROOT}" remote prune "${remote_name}" --dry-run 2>/dev/null | grep "^\s*\* \[would prune\]" | sed 's/.*\[would prune\] //')
        
        if [[ ${#stale_refs[@]} -gt 0 ]]; then
            record_result "warn" "git" "remote-${remote_name}-stale" "${#stale_refs[@]} stale refs (run 'git remote prune ${remote_name}')"
            log_verbose "Stale refs: ${stale_refs[*]}"
        else
            record_result "pass" "git" "remote-${remote_name}-stale" "No stale remote refs"
        fi
    done
    
    # -------------------------------------------------------------------------
    # Check for origin as the primary remote
    # -------------------------------------------------------------------------
    log_subsection "Primary Remote Validation"
    
    local has_origin=false
    for remote_name in "${remotes[@]}"; do
        [[ "${remote_name}" == "origin" ]] && has_origin=true
    done
    
    if [[ "${has_origin}" == "true" ]]; then
        record_result "pass" "git" "primary-remote" "Standard 'origin' remote configured"
        
        # Check if origin is the correct type for this repo
        local origin_url
        origin_url=$(git -C "${REPO_ROOT}" remote get-url origin 2>/dev/null || echo "")
        
        if [[ "${origin_url}" == *"github.com"* ]]; then
            record_result "pass" "git" "remote-host" "Origin points to GitHub"
            
            # Extract owner/repo from GitHub URL
            local github_repo=""
            if [[ "${origin_url}" == git@github.com:* ]]; then
                github_repo="${origin_url#git@github.com:}"
                github_repo="${github_repo%.git}"
            elif [[ "${origin_url}" == https://github.com/* ]]; then
                github_repo="${origin_url#https://github.com/}"
                github_repo="${github_repo%.git}"
            fi
            
            if [[ -n "${github_repo}" ]]; then
                log_verbose "GitHub repository: ${github_repo}"
            fi
        elif [[ "${origin_url}" == *"gitlab.com"* ]]; then
            record_result "pass" "git" "remote-host" "Origin points to GitLab"
        elif [[ "${origin_url}" == *"bitbucket.org"* ]]; then
            record_result "pass" "git" "remote-host" "Origin points to Bitbucket"
        elif [[ "${origin_url}" == *"azure.com"* || "${origin_url}" == *"visualstudio.com"* ]]; then
            record_result "pass" "git" "remote-host" "Origin points to Azure DevOps"
        fi
    else
        record_result "warn" "git" "primary-remote" "No 'origin' remote (convention suggests using 'origin' for primary)"
    fi
    
    # -------------------------------------------------------------------------
    # Check for fork setup (upstream remote)
    # -------------------------------------------------------------------------
    local has_upstream=false
    for remote_name in "${remotes[@]}"; do
        [[ "${remote_name}" == "upstream" ]] && has_upstream=true
    done
    
    if [[ "${has_upstream}" == "true" ]]; then
        record_result "pass" "git" "fork-setup" "Fork setup detected ('upstream' remote configured)"
        
        # Check upstream connectivity
        local upstream_url
        upstream_url=$(git -C "${REPO_ROOT}" remote get-url upstream 2>/dev/null || echo "")
        log_verbose "Upstream URL: ${upstream_url}"
    fi
    
    # -------------------------------------------------------------------------
    # Check last fetch time
    # -------------------------------------------------------------------------
    log_subsection "Remote Synchronization"
    
    local fetch_head="${REPO_ROOT}/.git/FETCH_HEAD"
    if [[ -f "${fetch_head}" ]]; then
        local last_fetch_time
        last_fetch_time=$(stat -f %m "${fetch_head}" 2>/dev/null || stat -c %Y "${fetch_head}" 2>/dev/null || echo "0")
        local current_time
        current_time=$(date +%s)
        local fetch_age=$((current_time - last_fetch_time))
        
        local fetch_age_human=""
        if [[ ${fetch_age} -lt 3600 ]]; then
            fetch_age_human="$((fetch_age / 60)) minutes ago"
        elif [[ ${fetch_age} -lt 86400 ]]; then
            fetch_age_human="$((fetch_age / 3600)) hours ago"
        else
            fetch_age_human="$((fetch_age / 86400)) days ago"
        fi
        
        if [[ ${fetch_age} -lt 86400 ]]; then  # Less than 1 day
            record_result "pass" "git" "last-fetch" "Last fetch: ${fetch_age_human}"
        elif [[ ${fetch_age} -lt 604800 ]]; then  # Less than 1 week
            record_result "warn" "git" "last-fetch" "Last fetch: ${fetch_age_human} (consider running 'git fetch')"
        else
            record_result "warn" "git" "last-fetch" "Last fetch: ${fetch_age_human} (stale - run 'git fetch --all')"
        fi
    else
        record_result "warn" "git" "last-fetch" "No fetch history found (run 'git fetch')"
    fi
    
    # -------------------------------------------------------------------------
    # Check for uncommitted remote tracking changes
    # -------------------------------------------------------------------------
    local unpushed_branches=()
    while IFS= read -r branch_info; do
        [[ -n "${branch_info}" ]] && unpushed_branches+=("${branch_info}")
    done < <(git -C "${REPO_ROOT}" for-each-ref --format='%(refname:short) %(push:track)' refs/heads 2>/dev/null | grep '\[ahead' | awk '{print $1}')
    
    if [[ ${#unpushed_branches[@]} -gt 0 ]]; then
        record_result "warn" "git" "unpushed-branches" "${#unpushed_branches[@]} branch(es) have unpushed commits: ${unpushed_branches[*]}"
    else
        record_result "pass" "git" "unpushed-branches" "All branches are in sync with remote"
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
        fi
    fi
    
    # Check site-docs directory (MkDocs output)
    local site_docs_dir="${REPO_ROOT}/site-docs"
    if [[ -d "${site_docs_dir}" ]]; then
        local docs_files
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
# Unwanted/Misplaced Files Checks
# =============================================================================

check_unwanted() {
    [[ "${CHECK_UNWANTED}" != "true" ]] && return
    
    log_section "Checking for Unwanted/Misplaced Files"
    
    local unwanted_count=0
    local misplaced_count=0
    
    # -------------------------------------------------------------------------
    # Check for unwanted files at repository root
    # -------------------------------------------------------------------------
    log_subsection "Unwanted Root Files"
    
    local root_unwanted=()
    for pattern in "${UNWANTED_ROOT_FILES[@]}"; do
        # Use find for glob patterns, direct check for exact names
        if [[ "${pattern}" == *"*"* ]]; then
            while IFS= read -r file; do
                [[ -n "${file}" ]] && root_unwanted+=("$(basename "${file}")")
            done < <(find "${REPO_ROOT}" -maxdepth 1 -name "${pattern}" 2>/dev/null)
        else
            if [[ -e "${REPO_ROOT}/${pattern}" ]]; then
                root_unwanted+=("${pattern}")
            fi
        fi
    done
    
    if [[ ${#root_unwanted[@]} -eq 0 ]]; then
        record_result "pass" "unwanted" "root-files" "No unwanted files at repository root"
    else
        ((unwanted_count += ${#root_unwanted[@]}))
        local file_list="${root_unwanted[*]}"
        if [[ ${#root_unwanted[@]} -gt 5 ]]; then
            file_list="${root_unwanted[*]:0:5} ... and $((${#root_unwanted[@]} - 5)) more"
        fi
        record_result "fail" "unwanted" "root-files" "Found ${#root_unwanted[@]} unwanted files: ${file_list}"
        
        log_verbose "Unwanted root files:"
        for file in "${root_unwanted[@]}"; do
            log_verbose "  - ${file}"
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check for unwanted directories at repository root
    # -------------------------------------------------------------------------
    log_subsection "Unwanted Root Directories"
    
    local root_unwanted_dirs=()
    for dir in "${UNWANTED_ROOT_DIRS[@]}"; do
        if [[ -d "${REPO_ROOT}/${dir}" ]]; then
            root_unwanted_dirs+=("${dir}")
        fi
    done
    
    if [[ ${#root_unwanted_dirs[@]} -eq 0 ]]; then
        record_result "pass" "unwanted" "root-dirs" "No unwanted directories at repository root"
    else
        ((unwanted_count += ${#root_unwanted_dirs[@]}))
        record_result "fail" "unwanted" "root-dirs" "Found ${#root_unwanted_dirs[@]} unwanted directories: ${root_unwanted_dirs[*]}"
    fi
    
    # -------------------------------------------------------------------------
    # Check for unwanted files anywhere in the repo
    # -------------------------------------------------------------------------
    log_subsection "Unwanted Files (Repository-wide)"
    
    local unwanted_anywhere=()
    for pattern in "${UNWANTED_FILES_ANYWHERE[@]}"; do
        while IFS= read -r file; do
            [[ -n "${file}" ]] && unwanted_anywhere+=("${file#${REPO_ROOT}/}")
        done < <(find "${REPO_ROOT}" -path "${REPO_ROOT}/.git" -prune -o -path "${pattern#\*\*/}" -print 2>/dev/null | grep -v "^${REPO_ROOT}/.git")
    done
    
    # Also check common patterns using find
    while IFS= read -r file; do
        [[ -n "${file}" ]] && unwanted_anywhere+=("${file#${REPO_ROOT}/}")
    done < <(find "${REPO_ROOT}" -path "${REPO_ROOT}/.git" -prune -o \( \
        -name ".DS_Store" -o \
        -name "Thumbs.db" -o \
        -name "*.log" -o \
        -name "*.tmp" -o \
        -name "*.bak" -o \
        -name "*.swp" -o \
        -name "*.swo" -o \
        -name "*~" -o \
        -name "*.pyc" -o \
        -name "*.pyo" \
    \) -print 2>/dev/null)
    
    # Remove duplicates
    local unique_unwanted=()
    declare -A seen
    for file in "${unwanted_anywhere[@]}"; do
        if [[ -z "${seen[${file}]:-}" ]]; then
            seen["${file}"]=1
            unique_unwanted+=("${file}")
        fi
    done
    
    if [[ ${#unique_unwanted[@]} -eq 0 ]]; then
        record_result "pass" "unwanted" "anywhere" "No unwanted files found in repository"
    else
        ((unwanted_count += ${#unique_unwanted[@]}))
        local preview_count=5
        if [[ ${#unique_unwanted[@]} -le ${preview_count} ]]; then
            record_result "fail" "unwanted" "anywhere" "Found ${#unique_unwanted[@]} unwanted files: ${unique_unwanted[*]}"
        else
            record_result "fail" "unwanted" "anywhere" "Found ${#unique_unwanted[@]} unwanted files (showing first ${preview_count}): ${unique_unwanted[*]:0:${preview_count}}"
        fi
        
        log_verbose "All unwanted files:"
        for file in "${unique_unwanted[@]}"; do
            log_verbose "  - ${file}"
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check for temporary/generated files (merge artifacts, backups)
    # -------------------------------------------------------------------------
    log_subsection "Temporary/Generated Files"
    
    local temp_files=()
    for pattern in "${TEMPORARY_FILE_PATTERNS[@]}"; do
        while IFS= read -r file; do
            [[ -n "${file}" ]] && temp_files+=("${file#${REPO_ROOT}/}")
        done < <(find "${REPO_ROOT}" -path "${REPO_ROOT}/.git" -prune -o -name "${pattern}" -print 2>/dev/null | grep -v "^${REPO_ROOT}/.git$")
    done
    
    if [[ ${#temp_files[@]} -eq 0 ]]; then
        record_result "pass" "unwanted" "temp-files" "No temporary/generated files found"
    else
        ((unwanted_count += ${#temp_files[@]}))
        record_result "warn" "unwanted" "temp-files" "Found ${#temp_files[@]} temporary files (should be cleaned up)"
        
        log_verbose "Temporary files:"
        for file in "${temp_files[@]}"; do
            log_verbose "  - ${file}"
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check for suspicious file extensions
    # -------------------------------------------------------------------------
    log_subsection "Suspicious File Extensions"
    
    local suspicious_files=()
    for ext in "${SUSPICIOUS_EXTENSIONS[@]}"; do
        while IFS= read -r file; do
            [[ -n "${file}" ]] && suspicious_files+=("${file#${REPO_ROOT}/}")
        done < <(find "${REPO_ROOT}" -path "${REPO_ROOT}/.git" -prune -o -name "*${ext}" -print 2>/dev/null | grep -v "^${REPO_ROOT}/.git$")
    done
    
    if [[ ${#suspicious_files[@]} -eq 0 ]]; then
        record_result "pass" "unwanted" "suspicious-ext" "No suspicious file extensions found"
    else
        record_result "warn" "unwanted" "suspicious-ext" "Found ${#suspicious_files[@]} files with suspicious extensions (binaries typically shouldn't be committed)"
        
        log_verbose "Suspicious files:"
        for file in "${suspicious_files[@]}"; do
            log_verbose "  - ${file}"
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check for large files
    # -------------------------------------------------------------------------
    log_subsection "Large Files"
    
    local large_files=()
    local threshold_mb=$((LARGE_FILE_THRESHOLD / 1024 / 1024))
    
    while IFS= read -r file; do
        [[ -n "${file}" ]] && large_files+=("${file#${REPO_ROOT}/}")
    done < <(find "${REPO_ROOT}" -path "${REPO_ROOT}/.git" -prune -o -type f -size "+${LARGE_FILE_THRESHOLD}c" -print 2>/dev/null | grep -v "^${REPO_ROOT}/.git$")
    
    if [[ ${#large_files[@]} -eq 0 ]]; then
        record_result "pass" "unwanted" "large-files" "No files larger than ${threshold_mb}MB found"
    else
        record_result "warn" "unwanted" "large-files" "Found ${#large_files[@]} files larger than ${threshold_mb}MB (consider Git LFS)"
        
        log_verbose "Large files:"
        for file in "${large_files[@]}"; do
            local size
            size=$(du -h "${REPO_ROOT}/${file}" 2>/dev/null | cut -f1)
            log_verbose "  - ${file} (${size})"
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check for __pycache__ directories
    # -------------------------------------------------------------------------
    log_subsection "Python Cache Directories"
    
    local pycache_dirs=()
    while IFS= read -r dir; do
        [[ -n "${dir}" ]] && pycache_dirs+=("${dir#${REPO_ROOT}/}")
    done < <(find "${REPO_ROOT}" -path "${REPO_ROOT}/.git" -prune -o -type d -name "__pycache__" -print 2>/dev/null | grep -v "^${REPO_ROOT}/.git$")
    
    if [[ ${#pycache_dirs[@]} -eq 0 ]]; then
        record_result "pass" "unwanted" "pycache" "No __pycache__ directories found"
    else
        ((unwanted_count += ${#pycache_dirs[@]}))
        record_result "fail" "unwanted" "pycache" "Found ${#pycache_dirs[@]} __pycache__ directories (should be gitignored)"
    fi
    
    # -------------------------------------------------------------------------
    # Check for misplaced files
    # -------------------------------------------------------------------------
    log_subsection "Misplaced Files"
    
    # Check for YAML files at root that might be misplaced
    local root_yamls=()
    while IFS= read -r file; do
        local basename
        basename=$(basename "${file}")
        # Skip known config files
        case "${basename}" in
            mkdocs.yml|ct.yaml|.yamllint|.pre-commit-config.yaml|renovate.json|docker-compose.yml|docker-compose.yaml)
                continue
                ;;
            *)
                root_yamls+=("${basename}")
                ;;
        esac
    done < <(find "${REPO_ROOT}" -maxdepth 1 \( -name "*.yaml" -o -name "*.yml" \) -type f 2>/dev/null)
    
    if [[ ${#root_yamls[@]} -gt 0 ]]; then
        # Check if any seem misplaced (not in OPTIONAL_ROOT_FILES)
        local misplaced_yamls=()
        for yaml in "${root_yamls[@]}"; do
            local is_expected=false
            for expected in "${OPTIONAL_ROOT_FILES[@]}"; do
                if [[ "${yaml}" == "${expected}" ]]; then
                    is_expected=true
                    break
                fi
            done
            if [[ "${is_expected}" == "false" ]]; then
                misplaced_yamls+=("${yaml}")
            fi
        done
        
        if [[ ${#misplaced_yamls[@]} -gt 0 ]]; then
            ((misplaced_count += ${#misplaced_yamls[@]}))
            record_result "warn" "unwanted" "misplaced-yaml" "Found ${#misplaced_yamls[@]} possibly misplaced YAML files at root: ${misplaced_yamls[*]}"
        fi
    fi
    
    # Check for source code files at root (might be misplaced)
    local root_code=()
    while IFS= read -r file; do
        root_code+=("$(basename "${file}")")
    done < <(find "${REPO_ROOT}" -maxdepth 1 \( \
        -name "*.py" -o \
        -name "*.js" -o \
        -name "*.ts" -o \
        -name "*.go" -o \
        -name "*.rs" -o \
        -name "*.java" -o \
        -name "*.c" -o \
        -name "*.cpp" -o \
        -name "*.h" \
    \) -type f 2>/dev/null)
    
    if [[ ${#root_code[@]} -gt 0 ]]; then
        ((misplaced_count += ${#root_code[@]}))
        record_result "warn" "unwanted" "misplaced-code" "Found ${#root_code[@]} source files at root (consider moving to src/ or scripts/): ${root_code[*]}"
    fi
    
    # -------------------------------------------------------------------------
    # Check for common editor/IDE config at unexpected locations
    # -------------------------------------------------------------------------
    log_subsection "Editor/IDE Configuration"
    
    local editor_configs=()
    # Check for .vscode or .idea in subdirectories (should only be at root if at all)
    while IFS= read -r dir; do
        [[ -n "${dir}" && "${dir}" != "${REPO_ROOT}/.vscode" && "${dir}" != "${REPO_ROOT}/.idea" ]] && \
            editor_configs+=("${dir#${REPO_ROOT}/}")
    done < <(find "${REPO_ROOT}" -path "${REPO_ROOT}/.git" -prune -o \( -name ".vscode" -o -name ".idea" \) -type d -print 2>/dev/null | grep -v "^${REPO_ROOT}/.git$")
    
    if [[ ${#editor_configs[@]} -gt 0 ]]; then
        ((misplaced_count += ${#editor_configs[@]}))
        record_result "warn" "unwanted" "editor-config" "Found editor config in unexpected locations: ${editor_configs[*]}"
    else
        record_result "pass" "unwanted" "editor-config" "No misplaced editor configurations found"
    fi
    
    # -------------------------------------------------------------------------
    # Summary
    # -------------------------------------------------------------------------
    log_subsection "Unwanted Files Summary"
    
    if [[ ${unwanted_count} -eq 0 && ${misplaced_count} -eq 0 ]]; then
        record_result "pass" "unwanted" "summary" "Repository is clean - no unwanted or misplaced files"
    else
        if [[ ${unwanted_count} -gt 0 ]]; then
            record_result "fail" "unwanted" "summary-unwanted" "Total unwanted files/directories: ${unwanted_count}"
        fi
        if [[ ${misplaced_count} -gt 0 ]]; then
            record_result "warn" "unwanted" "summary-misplaced" "Total potentially misplaced files: ${misplaced_count}"
        fi
    fi
}

# =============================================================================
# Gitignore Pattern Verification
# =============================================================================

check_gitignore_patterns() {
    [[ "${CHECK_GITIGNORE}" != "true" ]] && return
    
    log_section "Checking Gitignore Pattern Compliance"
    
    # Skip if not a git repository
    if ! git -C "${REPO_ROOT}" rev-parse --is-inside-work-tree &>/dev/null; then
        record_result "skip" "gitignore" "repository" "Not a git repository - skipping gitignore checks"
        return
    fi
    
    local tracked_violations=()
    local unignored_patterns=()
    local total_patterns=0
    local ignored_count=0
    local tracked_count=0
    
    # Helper function to check if a pattern is ignored by git
    check_pattern_ignored() {
        local pattern="$1"
        local category="$2"
        
        ((total_patterns++))
        
        # Create a test file path (we don't create the file, just check if it would be ignored)
        local test_path="${pattern}"
        
        # Handle patterns with wildcards differently
        if [[ "${pattern}" == *"*"* ]]; then
            # For wildcard patterns, create a sample filename
            local sample_name
            case "${pattern}" in
                "*~") sample_name="test~" ;;
                "._*") sample_name="._test" ;;
                "*.icloud") sample_name="test.icloud" ;;
                "*.stackdump") sample_name="test.stackdump" ;;
                "*.cab") sample_name="test.cab" ;;
                "*.msi") sample_name="test.msi" ;;
                "*.msix") sample_name="test.msix" ;;
                "*.msm") sample_name="test.msm" ;;
                "*.msp") sample_name="test.msp" ;;
                "*.lnk") sample_name="test.lnk" ;;
                ".fuse_hidden*") sample_name=".fuse_hidden123" ;;
                ".Trash-*") sample_name=".Trash-1000" ;;
                ".nfs*") sample_name=".nfs123456" ;;
                *) sample_name="${pattern//\*/test}" ;;
            esac
            test_path="${sample_name}"
        fi
        
        # Handle special characters in pattern names
        case "${pattern}" in
            "[Dd]esktop.ini")
                # Test both variants
                if git -C "${REPO_ROOT}" check-ignore -q "desktop.ini" 2>/dev/null || \
                   git -C "${REPO_ROOT}" check-ignore -q "Desktop.ini" 2>/dev/null; then
                    ((ignored_count++))
                    return 0
                else
                    unignored_patterns+=("${pattern}")
                    return 1
                fi
                ;;
            "\$RECYCLE.BIN/")
                test_path="\$RECYCLE.BIN"
                ;;
        esac
        
        # Check if the pattern would be ignored
        if git -C "${REPO_ROOT}" check-ignore -q "${test_path}" 2>/dev/null; then
            ((ignored_count++))
            return 0
        else
            unignored_patterns+=("${pattern}")
            return 1
        fi
    }
    
    # Helper function to check if any matching files are tracked
    check_tracked_files() {
        local pattern="$1"
        local category="$2"
        
        local tracked_files=()
        
        # Handle different pattern types
        case "${pattern}" in
            "*~"|"._*"|"*.icloud"|"*.stackdump"|"*.cab"|"*.msi"|"*.msix"|"*.msm"|"*.msp"|"*.lnk")
                # Glob patterns
                while IFS= read -r file; do
                    [[ -n "${file}" ]] && tracked_files+=("${file}")
                done < <(git -C "${REPO_ROOT}" ls-files "${pattern}" 2>/dev/null)
                ;;
            ".fuse_hidden*"|".Trash-*"|".nfs*")
                # Prefix patterns
                local prefix="${pattern%\*}"
                while IFS= read -r file; do
                    [[ -n "${file}" && "${file}" == ${prefix}* ]] && tracked_files+=("${file}")
                done < <(git -C "${REPO_ROOT}" ls-files 2>/dev/null)
                ;;
            "[Dd]esktop.ini")
                # Case variant patterns
                while IFS= read -r file; do
                    [[ -n "${file}" ]] && tracked_files+=("${file}")
                done < <(git -C "${REPO_ROOT}" ls-files "desktop.ini" "Desktop.ini" 2>/dev/null)
                ;;
            "\$RECYCLE.BIN/")
                # Special directory
                while IFS= read -r file; do
                    [[ -n "${file}" && "${file}" == "\$RECYCLE.BIN"* ]] && tracked_files+=("${file}")
                done < <(git -C "${REPO_ROOT}" ls-files 2>/dev/null)
                ;;
            *)
                # Exact match or simple pattern
                while IFS= read -r file; do
                    [[ -n "${file}" ]] && tracked_files+=("${file}")
                done < <(git -C "${REPO_ROOT}" ls-files "${pattern}" 2>/dev/null)
                ;;
        esac
        
        if [[ ${#tracked_files[@]} -gt 0 ]]; then
            ((tracked_count++))
            for file in "${tracked_files[@]}"; do
                tracked_violations+=("${category}:${pattern}:${file}")
            done
            return 1
        fi
        return 0
    }
    
    # -------------------------------------------------------------------------
    # Check Linux patterns
    # -------------------------------------------------------------------------
    log_subsection "Linux Patterns"
    
    local linux_ignored=0
    local linux_total=${#GITIGNORE_LINUX_PATTERNS[@]}
    local linux_unignored=()
    
    for pattern in "${GITIGNORE_LINUX_PATTERNS[@]}"; do
        [[ -z "${pattern}" ]] && continue
        if check_pattern_ignored "${pattern}" "linux"; then
            ((linux_ignored++))
        else
            linux_unignored+=("${pattern}")
        fi
        check_tracked_files "${pattern}" "linux"
    done
    
    if [[ ${#linux_unignored[@]} -eq 0 ]]; then
        record_result "pass" "gitignore" "linux-patterns" "All ${linux_total} Linux patterns are gitignored"
    else
        record_result "warn" "gitignore" "linux-patterns" "${#linux_unignored[@]}/${linux_total} patterns not ignored: ${linux_unignored[*]}"
    fi
    
    # -------------------------------------------------------------------------
    # Check macOS patterns
    # -------------------------------------------------------------------------
    log_subsection "macOS Patterns"
    
    local macos_ignored=0
    local macos_total=${#GITIGNORE_MACOS_PATTERNS[@]}
    local macos_unignored=()
    
    for pattern in "${GITIGNORE_MACOS_PATTERNS[@]}"; do
        [[ -z "${pattern}" ]] && continue
        if check_pattern_ignored "${pattern}" "macos"; then
            ((macos_ignored++))
        else
            macos_unignored+=("${pattern}")
        fi
        check_tracked_files "${pattern}" "macos"
    done
    
    if [[ ${#macos_unignored[@]} -eq 0 ]]; then
        record_result "pass" "gitignore" "macos-patterns" "All ${macos_total} macOS patterns are gitignored"
    else
        record_result "warn" "gitignore" "macos-patterns" "${#macos_unignored[@]}/${macos_total} patterns not ignored: ${macos_unignored[*]}"
    fi
    
    # -------------------------------------------------------------------------
    # Check Windows patterns
    # -------------------------------------------------------------------------
    log_subsection "Windows Patterns"
    
    local windows_ignored=0
    local windows_total=${#GITIGNORE_WINDOWS_PATTERNS[@]}
    local windows_unignored=()
    
    for pattern in "${GITIGNORE_WINDOWS_PATTERNS[@]}"; do
        [[ -z "${pattern}" ]] && continue
        if check_pattern_ignored "${pattern}" "windows"; then
            ((windows_ignored++))
        else
            windows_unignored+=("${pattern}")
        fi
        check_tracked_files "${pattern}" "windows"
    done
    
    if [[ ${#windows_unignored[@]} -eq 0 ]]; then
        record_result "pass" "gitignore" "windows-patterns" "All ${windows_total} Windows patterns are gitignored"
    else
        record_result "warn" "gitignore" "windows-patterns" "${#windows_unignored[@]}/${windows_total} patterns not ignored: ${windows_unignored[*]}"
    fi
    
    # -------------------------------------------------------------------------
    # Check for tracked violations
    # -------------------------------------------------------------------------
    log_subsection "Tracked File Violations"
    
    if [[ ${#tracked_violations[@]} -eq 0 ]]; then
        record_result "pass" "gitignore" "tracked-files" "No OS/temp files are currently tracked"
    else
        record_result "fail" "gitignore" "tracked-files" "Found ${#tracked_violations[@]} tracked files that should be gitignored"
        
        log_verbose "Tracked violations:"
        for violation in "${tracked_violations[@]}"; do
            local category="${violation%%:*}"
            local rest="${violation#*:}"
            local pattern="${rest%%:*}"
            local file="${rest#*:}"
            log_verbose "  - [${category}] ${file} (matches ${pattern})"
        done
    fi
    
    # -------------------------------------------------------------------------
    # Check for untracked files matching patterns (verify they ARE untracked)
    # -------------------------------------------------------------------------
    log_subsection "Untracked OS Files Check"
    
    local untracked_os_files=()
    
    # Check for common OS files that exist but are untracked (good!)
    local os_patterns=(".DS_Store" "Thumbs.db" "desktop.ini" ".directory")
    for pattern in "${os_patterns[@]}"; do
        while IFS= read -r file; do
            [[ -n "${file}" ]] && untracked_os_files+=("${file}")
        done < <(find "${REPO_ROOT}" -path "${REPO_ROOT}/.git" -prune -o -name "${pattern}" -print 2>/dev/null | grep -v "^${REPO_ROOT}/.git$")
    done
    
    if [[ ${#untracked_os_files[@]} -eq 0 ]]; then
        record_result "pass" "gitignore" "untracked-os-files" "No OS-specific files present in working directory"
    else
        # Check if they're properly untracked
        local tracked_os_files=()
        for file in "${untracked_os_files[@]}"; do
            local relative="${file#${REPO_ROOT}/}"
            if git -C "${REPO_ROOT}" ls-files --error-unmatch "${relative}" &>/dev/null; then
                tracked_os_files+=("${relative}")
            fi
        done
        
        if [[ ${#tracked_os_files[@]} -eq 0 ]]; then
            record_result "pass" "gitignore" "untracked-os-files" "${#untracked_os_files[@]} OS files exist but are properly untracked"
        else
            record_result "fail" "gitignore" "untracked-os-files" "${#tracked_os_files[@]} OS files are tracked: ${tracked_os_files[*]}"
        fi
    fi
    
    # -------------------------------------------------------------------------
    # Summary
    # -------------------------------------------------------------------------
    log_subsection "Gitignore Summary"
    
    local coverage_pct=0
    if [[ ${total_patterns} -gt 0 ]]; then
        coverage_pct=$((ignored_count * 100 / total_patterns))
    fi
    
    if [[ ${coverage_pct} -ge 90 && ${tracked_count} -eq 0 ]]; then
        record_result "pass" "gitignore" "summary" "Excellent gitignore coverage: ${coverage_pct}% (${ignored_count}/${total_patterns} patterns)"
    elif [[ ${coverage_pct} -ge 70 && ${tracked_count} -eq 0 ]]; then
        record_result "warn" "gitignore" "summary" "Good gitignore coverage: ${coverage_pct}% (${ignored_count}/${total_patterns} patterns)"
    elif [[ ${tracked_count} -gt 0 ]]; then
        record_result "fail" "gitignore" "summary" "Gitignore issues: ${coverage_pct}% coverage, ${tracked_count} tracked violations"
    else
        record_result "warn" "gitignore" "summary" "Low gitignore coverage: ${coverage_pct}% (${ignored_count}/${total_patterns} patterns)"
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
                    - Remote health: connectivity, sync status, stale refs
                    - Tracking branches, last fetch time, unpushed commits
  • CI/CD           - GitHub Actions workflows
  • GitHub Pages    - Pages workflow, site directories, and deployment status
  • GitHub Health   - Workflow failures, issues, PRs, branch protection
  • Python          - Python environment and scripts
  • Security        - Secrets scanning and .gitignore patterns
  • Unwanted Files  - Temporary files, caches, misplaced files, large files
  • Gitignore       - Linux/macOS/Windows patterns properly ignored, no tracked violations

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
    CHECK_UNWANTED=true|false
    CHECK_GITIGNORE=true|false

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
    check_unwanted
    check_gitignore_patterns
    
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
