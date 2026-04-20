#!/usr/bin/env bash
# protonpass-provider — Company secret provider powered by Proton Pass CLI
#
# A user-friendly wrapper around pass-cli that provides:
#   - Profile-based secret mapping (vault items → env vars)
#   - .env file generation from Proton Pass vaults
#   - Template injection with {{ pass://... }} references
#   - Interactive vault/item browsing (fzf-powered)
#   - Kubernetes secret/ExternalSecret YAML generation
#
# Usage: protonpass-provider <command> [options]
#
# Run 'protonpass-provider help' for full command reference.

set -euo pipefail

# ─── Constants ───────────────────────────────────────────────────────────────

readonly VERSION="1.0.0"
readonly PROG="protonpass-provider"
readonly CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/protonpass-provider"
readonly PROFILES_DIR="${CONFIG_DIR}/profiles"
readonly STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/protonpass-provider"

# Colors
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly BOLD='\033[1m'
readonly DIM='\033[2m'
readonly RESET='\033[0m'

# ─── Helpers ─────────────────────────────────────────────────────────────────

log_info() { echo -e "${BLUE}ℹ${RESET} $*"; }
log_ok() { echo -e "${GREEN}✔${RESET} $*"; }
log_warn() { echo -e "${YELLOW}⚠${RESET} $*" >&2; }
log_error() { echo -e "${RED}✖${RESET} $*" >&2; }
log_step() { echo -e "${CYAN}▸${RESET} $*"; }

die() {
    log_error "$@"
    exit 1
}

require_cmd() {
    command -v "$1" &>/dev/null || die "Required command not found: $1. Run '${PROG} setup' to install dependencies."
}

require_auth() {
    pass-cli vault list &>/dev/null 2>&1 || die "Not authenticated with Proton Pass. Run '${PROG} login'"
}

has_fzf() { command -v fzf &>/dev/null; }
has_yq() { command -v yq &>/dev/null; }

ensure_dirs() {
    mkdir -p "${CONFIG_DIR}" "${PROFILES_DIR}" "${STATE_DIR}"
}

# ─── Setup & Auth ────────────────────────────────────────────────────────────

cmd_setup() {
    log_info "Setting up Proton Pass secret provider..."
    ensure_dirs

    # Check/install pass-cli
    if command -v pass-cli &>/dev/null; then
        local version
        version=$(pass-cli --version 2>/dev/null || echo "unknown")
        log_ok "pass-cli already installed (${version})"
    else
        log_step "Installing pass-cli..."
        if [[ "$OSTYPE" == "darwin"* ]] && command -v brew &>/dev/null; then
            brew install protonpass/tap/pass-cli
        else
            curl -fsSL https://proton.me/download/pass-cli/install.sh | bash
        fi
        log_ok "pass-cli installed"
    fi

    # Check/install optional tools
    if has_fzf; then
        log_ok "fzf available (interactive browsing enabled)"
    else
        log_warn "fzf not installed. Install it for interactive vault browsing: brew install fzf"
    fi

    if has_yq; then
        log_ok "yq available (YAML profile support enabled)"
    else
        log_warn "yq not installed. Install it for YAML profile support: brew install yq"
    fi

    # Install shell completions
    log_step "Installing shell completions for pass-cli..."
    if [[ -n "${ZSH_VERSION:-}" ]] || [[ "$SHELL" == *zsh* ]]; then
        local comp_dir="${HOME}/.zfunc"
        mkdir -p "${comp_dir}"
        pass-cli completions zsh >"${comp_dir}/_pass-cli" 2>/dev/null || true
        log_ok "Zsh completions installed to ${comp_dir}/_pass-cli"
    elif [[ -n "${BASH_VERSION:-}" ]] || [[ "$SHELL" == *bash* ]]; then
        local comp_dir="${HOME}/.local/share/bash-completion/completions"
        mkdir -p "${comp_dir}"
        pass-cli completions bash >"${comp_dir}/pass-cli" 2>/dev/null || true
        log_ok "Bash completions installed to ${comp_dir}/pass-cli"
    fi

    # Create default config if none exists
    if [[ ! -f "${CONFIG_DIR}/config.yaml" ]]; then
        log_step "Creating default configuration..."
        cat >"${CONFIG_DIR}/config.yaml" <<'YAML'
# Proton Pass Provider Configuration
# See: https://github.com/codefuturist/helm-charts/docs/secrets/protonpass-profiles.md

# Default vault for lookups when no vault is specified in a profile
default_vault: ""

# Vaults to never access (safety deny list)
denied_vaults: []

# Output format for env commands (dotenv, json, yaml)
default_format: "dotenv"

# Mask secret values in terminal output by default
mask_secrets: true
YAML
        log_ok "Configuration created at ${CONFIG_DIR}/config.yaml"
    fi

    echo ""
    log_ok "Setup complete! Next steps:"
    echo -e "  1. ${BOLD}${PROG} login${RESET}          — Authenticate with Proton Pass"
    echo -e "  2. ${BOLD}${PROG} vaults${RESET}         — List your vaults"
    echo -e "  3. ${BOLD}${PROG} profile create${RESET}  — Create a secret profile"
    echo -e "  4. ${BOLD}${PROG} env <profile>${RESET}   — Generate .env from profile"
}

cmd_login() {
    require_cmd pass-cli
    log_step "Authenticating with Proton Pass..."
    pass-cli login
    log_ok "Successfully authenticated"
}

cmd_logout() {
    require_cmd pass-cli
    pass-cli logout 2>/dev/null || true
    log_ok "Session cleared"
}

cmd_status() {
    require_cmd pass-cli
    echo -e "${BOLD}Proton Pass Provider Status${RESET}"
    echo "─────────────────────────────"

    # Auth check
    if pass-cli vault list &>/dev/null 2>&1; then
        echo -e "  Auth:     ${GREEN}Authenticated${RESET}"
    else
        echo -e "  Auth:     ${RED}Not authenticated${RESET}"
        echo -e "  Run:      ${PROG} login"
        return
    fi

    # Vault count
    local vault_count
    vault_count=$(pass-cli vault list 2>/dev/null | wc -l | tr -d ' ')
    echo -e "  Vaults:   ${vault_count} accessible"

    # Config
    echo -e "  Config:   ${CONFIG_DIR}/config.yaml"

    # Profiles
    local profile_count=0
    if [[ -d "${PROFILES_DIR}" ]]; then
        profile_count=$(find "${PROFILES_DIR}" -name "*.yaml" -o -name "*.yml" 2>/dev/null | wc -l | tr -d ' ')
    fi
    echo -e "  Profiles: ${profile_count} configured"

    # Tools
    echo ""
    echo -e "  ${DIM}Tools:${RESET}"
    echo -e "    pass-cli:  $(command -v pass-cli &>/dev/null && echo -e "${GREEN}✔${RESET}" || echo -e "${RED}✖${RESET}")"
    echo -e "    fzf:       $(has_fzf && echo -e "${GREEN}✔${RESET} (interactive mode)" || echo -e "${DIM}○ (optional)${RESET}")"
    echo -e "    yq:        $(has_yq && echo -e "${GREEN}✔${RESET} (YAML profiles)" || echo -e "${DIM}○ (optional)${RESET}")"
}

# ─── Secret Retrieval ────────────────────────────────────────────────────────

cmd_get() {
    require_cmd pass-cli
    require_auth
    local ref="${1:?Usage: ${PROG} get <pass://vault/item/field>}"

    if [[ "$ref" != pass://* ]]; then
        die "Invalid reference format. Use: pass://vault/item/field"
    fi

    # Use inject to resolve the reference
    echo "{{ ${ref} }}" | pass-cli inject
}

cmd_vaults() {
    require_cmd pass-cli
    require_auth
    echo -e "${BOLD}Proton Pass Vaults${RESET}"
    echo "───────────────────"
    pass-cli vault list
}

cmd_list() {
    require_cmd pass-cli
    require_auth
    local vault="${1:-}"

    if [[ -z "$vault" ]]; then
        # Interactive vault selection if fzf is available
        if has_fzf; then
            vault=$(pass-cli vault list 2>/dev/null | fzf --prompt="Select vault: " --height=40%)
            [[ -z "$vault" ]] && die "No vault selected"
        else
            die "Usage: ${PROG} list <vault-name>  (install fzf for interactive selection)"
        fi
    fi

    echo -e "${BOLD}Items in '${vault}'${RESET}"
    echo "───────────────────"
    pass-cli item list --vault "$vault"
}

cmd_search() {
    require_cmd pass-cli
    require_auth
    local query="${1:?Usage: ${PROG} search <query>}"

    log_step "Searching across vaults for '${query}'..."
    # List all vaults and search items in each
    while IFS= read -r vault; do
        local items
        items=$(pass-cli item list --vault "$vault" 2>/dev/null | grep -i "$query" || true)
        if [[ -n "$items" ]]; then
            echo -e "\n${BOLD}${vault}${RESET}"
            echo "$items"
        fi
    done < <(pass-cli vault list 2>/dev/null)
}

# ─── Environment Generation ──────────────────────────────────────────────────

cmd_env() {
    require_cmd pass-cli
    require_auth
    local profile_name="${1:?Usage: ${PROG} env <profile-name> [--output FILE]}"
    shift
    local output_file="${1:-.env.local}"

    local profile_file
    profile_file=$(_find_profile "$profile_name")

    log_step "Generating environment from profile '${profile_name}'..."

    # Parse the profile and resolve secrets
    local env_content=""
    local count=0

    if has_yq; then
        # Parse YAML profile with yq
        while IFS='=' read -r key ref; do
            [[ -z "$key" || -z "$ref" ]] && continue
            local value
            value=$(echo "{{ ${ref} }}" | pass-cli inject 2>/dev/null) || {
                log_warn "Failed to resolve: ${key} → ${ref}"
                continue
            }
            env_content+="${key}=${value}\n"
            ((count++))
        done < <(yq eval '.mappings | to_entries | .[] | .key + "=" + .value' "$profile_file" 2>/dev/null)

        # Process personal vault overrides if present
        while IFS='=' read -r key ref; do
            [[ -z "$key" || -z "$ref" ]] && continue
            local value
            value=$(echo "{{ ${ref} }}" | pass-cli inject 2>/dev/null) || {
                log_warn "Failed to resolve personal secret: ${key} → ${ref}"
                continue
            }
            env_content+="${key}=${value}\n"
            ((count++))
        done < <(yq eval '.personal // {} | to_entries | .[] | .key + "=" + .value' "$profile_file" 2>/dev/null)
    else
        # Fallback: simple KEY=pass://... line parsing
        while IFS='=' read -r key ref; do
            [[ -z "$key" || "$key" == \#* || -z "$ref" ]] && continue
            key=$(echo "$key" | xargs)
            ref=$(echo "$ref" | xargs | tr -d '"' | tr -d "'")
            [[ "$ref" != pass://* ]] && continue

            local value
            value=$(echo "{{ ${ref} }}" | pass-cli inject 2>/dev/null) || {
                log_warn "Failed to resolve: ${key} → ${ref}"
                continue
            }
            env_content+="${key}=${value}\n"
            ((count++))
        done < <(grep -E '^[A-Z_]+\s*=' "$profile_file" 2>/dev/null || true)
    fi

    if [[ "$output_file" == "-" ]]; then
        echo -e "$env_content"
    else
        echo -e "# Generated by ${PROG} from profile '${profile_name}'" >"$output_file"
        echo -e "# $(date -Iseconds)" >>"$output_file"
        echo -e "$env_content" >>"$output_file"
        chmod 600 "$output_file"
        log_ok "Generated ${output_file} with ${count} secrets"
    fi
}

cmd_env_diff() {
    require_cmd pass-cli
    require_auth
    local profile_name="${1:?Usage: ${PROG} env-diff <profile-name> [env-file]}"
    local env_file="${2:-.env.local}"

    [[ -f "$env_file" ]] || die "File not found: ${env_file}"

    log_step "Comparing ${env_file} against profile '${profile_name}'..."

    # Generate fresh env to temp file
    local tmp_env
    tmp_env=$(mktemp)
    trap 'rm -f "${tmp_env}"' EXIT

    cmd_env "$profile_name" "$tmp_env"

    # Show diff
    if diff --color=auto "$env_file" "$tmp_env" >/dev/null 2>&1; then
        log_ok "No drift detected — ${env_file} matches vault state"
    else
        log_warn "Drift detected between ${env_file} and vault:"
        diff --color=auto "$env_file" "$tmp_env" || true
    fi
}

cmd_inject() {
    require_cmd pass-cli
    require_auth
    local template="${1:?Usage: ${PROG} inject <template-file> [--output FILE]}"
    shift
    local output="${1:-}"

    [[ -f "$template" ]] || die "Template not found: ${template}"

    log_step "Injecting secrets into ${template}..."

    if [[ -n "$output" ]]; then
        pass-cli inject --in-file "$template" --out-file "$output" --force
        chmod 600 "$output"
        log_ok "Generated ${output}"
    else
        pass-cli inject --in-file "$template"
    fi
}

cmd_run() {
    require_cmd pass-cli
    require_auth
    local profile_name="${1:?Usage: ${PROG} run <profile-name> -- <command> [args...]}"
    shift

    # Find the -- separator
    local cmd_start=false
    local cmd_args=()

    for arg in "$@"; do
        if [[ "$arg" == "--" ]]; then
            cmd_start=true
            continue
        fi
        if $cmd_start; then
            cmd_args+=("$arg")
        fi
    done

    [[ ${#cmd_args[@]} -eq 0 ]] && die "Usage: ${PROG} run <profile> -- <command> [args...]"

    # Generate temp .env file from profile
    local tmp_env
    tmp_env=$(mktemp "${TMPDIR:-/tmp}/.env.XXXXXX")
    trap 'rm -f "${tmp_env}"' EXIT

    cmd_env "$profile_name" "$tmp_env"

    log_step "Running command with secrets from profile '${profile_name}'..."
    pass-cli run --env-file "$tmp_env" -- "${cmd_args[@]}"
}

# ─── Profile Management ─────────────────────────────────────────────────────

cmd_profile_list() {
    ensure_dirs
    echo -e "${BOLD}Secret Profiles${RESET}"
    echo "────────────────"

    if [[ -z "$(ls -A "${PROFILES_DIR}" 2>/dev/null)" ]]; then
        echo -e "  ${DIM}No profiles configured. Run '${PROG} profile create <name>' to create one.${RESET}"
        return
    fi

    for f in "${PROFILES_DIR}"/*.yaml "${PROFILES_DIR}"/*.yml; do
        [[ -f "$f" ]] || continue
        local name
        name=$(basename "$f" | sed 's/\.ya\?ml$//')
        local desc=""
        if has_yq; then
            desc=$(yq eval '.description // ""' "$f" 2>/dev/null)
        fi
        if [[ -n "$desc" ]]; then
            echo -e "  ${BOLD}${name}${RESET}  ${DIM}— ${desc}${RESET}"
        else
            echo -e "  ${BOLD}${name}${RESET}"
        fi
    done
}

cmd_profile_create() {
    require_cmd pass-cli
    require_auth
    ensure_dirs
    local name="${1:?Usage: ${PROG} profile create <name>}"
    local profile_file="${PROFILES_DIR}/${name}.yaml"

    [[ -f "$profile_file" ]] && die "Profile '${name}' already exists. Use '${PROG} profile edit ${name}'"

    echo -e "${BOLD}Creating profile: ${name}${RESET}\n"

    # Get description
    read -rp "Description: " description

    # Get vault
    echo ""
    log_step "Available vaults:"
    pass-cli vault list 2>/dev/null
    echo ""
    read -rp "Primary vault name: " vault

    # Interactive mapping creation
    echo ""
    log_info "Add secret mappings (ENV_VAR → vault item/field)."
    log_info "Press Enter with empty name to finish.\n"

    local mappings=""
    while true; do
        read -rp "Environment variable name (or Enter to finish): " env_var
        [[ -z "$env_var" ]] && break

        read -rp "  Item title/ID: " item
        read -rp "  Field name [password]: " field
        field="${field:-password}"

        mappings+="  ${env_var}: \"pass://${vault}/${item}/${field}\"\n"
        log_ok "Added: ${env_var} → pass://${vault}/${item}/${field}"
        echo ""
    done

    # Write profile
    cat >"$profile_file" <<EOF
# Proton Pass secret profile: ${name}
name: "${name}"
description: "${description}"
vault: "${vault}"

# Shared vault mappings (ENV_VAR → pass:// URI)
mappings:
$(echo -e "$mappings")
# Personal vault overrides (optional)
# These use the developer's personal Proton Pass vault
personal: {}
  # GITHUB_TOKEN: "pass://Personal/GitHub/token"
EOF

    log_ok "Profile '${name}' created at ${profile_file}"
    echo -e "\nUse it: ${BOLD}${PROG} env ${name}${RESET}"
}

cmd_profile_edit() {
    local name="${1:?Usage: ${PROG} profile edit <name>}"
    local profile_file
    profile_file=$(_find_profile "$name")

    ${EDITOR:-${VISUAL:-vi}} "$profile_file"
    log_ok "Profile '${name}' updated"
}

# ─── Kubernetes Helpers ──────────────────────────────────────────────────────

cmd_k8s_secret() {
    require_cmd pass-cli
    require_auth
    local namespace="${1:?Usage: ${PROG} k8s-secret <namespace> <secret-name> <profile>}"
    local secret_name="${2:?Usage: ${PROG} k8s-secret <namespace> <secret-name> <profile>}"
    local profile_name="${3:?Usage: ${PROG} k8s-secret <namespace> <secret-name> <profile>}"

    local profile_file
    profile_file=$(_find_profile "$profile_name")

    log_step "Generating Kubernetes Secret YAML from profile '${profile_name}'..."

    echo "---"
    echo "apiVersion: v1"
    echo "kind: Secret"
    echo "metadata:"
    echo "  name: ${secret_name}"
    echo "  namespace: ${namespace}"
    echo "type: Opaque"
    echo "stringData:"

    if has_yq; then
        while IFS='=' read -r key ref; do
            [[ -z "$key" || -z "$ref" ]] && continue
            local value
            value=$(echo "{{ ${ref} }}" | pass-cli inject 2>/dev/null) || continue
            echo "  ${key}: \"${value}\""
        done < <(yq eval '.mappings | to_entries | .[] | .key + "=" + .value' "$profile_file" 2>/dev/null)
    fi
}

cmd_k8s_externalsecret() {
    local profile_name="${1:?Usage: ${PROG} k8s-externalsecret <profile> [store-name]}"
    local store_name="${2:-protonpass}"

    local profile_file
    profile_file=$(_find_profile "$profile_name")

    log_step "Generating ExternalSecret YAML from profile '${profile_name}'..."

    local vault=""
    if has_yq; then
        vault=$(yq eval '.vault // ""' "$profile_file" 2>/dev/null)
    fi

    echo "---"
    echo "apiVersion: external-secrets.io/v1"
    echo "kind: ExternalSecret"
    echo "metadata:"
    echo "  name: ${profile_name}"
    echo "spec:"
    echo "  refreshInterval: \"5m\""
    echo "  secretStoreRef:"
    echo "    name: ${store_name}"
    echo "    kind: ClusterSecretStore"
    echo "  data:"

    if has_yq; then
        while IFS='=' read -r key ref; do
            [[ -z "$key" || -z "$ref" ]] && continue
            # Parse pass://vault/item/field into components
            local path="${ref#pass://}"
            local item field
            item=$(echo "$path" | cut -d'/' -f2)
            field=$(echo "$path" | cut -d'/' -f3)
            echo "    - secretKey: ${key}"
            echo "      remoteRef:"
            echo "        key: \"${item}\""
            echo "        property: \"${field}\""
        done < <(yq eval '.mappings | to_entries | .[] | .key + "=" + .value' "$profile_file" 2>/dev/null)
    fi
}

# ─── Audit ───────────────────────────────────────────────────────────────────

cmd_audit() {
    require_cmd pass-cli
    require_auth

    echo -e "${BOLD}Secret Audit Report${RESET}"
    echo "────────────────────"
    echo ""

    # List all profiles and their status
    echo -e "${BOLD}Profiles:${RESET}"
    for f in "${PROFILES_DIR}"/*.yaml "${PROFILES_DIR}"/*.yml; do
        [[ -f "$f" ]] || continue
        local name
        name=$(basename "$f" | sed 's/\.ya\?ml$//')
        local count=0
        if has_yq; then
            count=$(yq eval '.mappings | length' "$f" 2>/dev/null || echo 0)
        fi
        echo -e "  ${name}: ${count} mapped secrets"
    done

    echo ""
    echo -e "${BOLD}Vaults:${RESET}"
    pass-cli vault list 2>/dev/null | while IFS= read -r vault; do
        echo -e "  ${vault}"
    done
}

# ─── Internal Helpers ────────────────────────────────────────────────────────

_find_profile() {
    local name="$1"
    local file=""

    for ext in yaml yml; do
        if [[ -f "${PROFILES_DIR}/${name}.${ext}" ]]; then
            file="${PROFILES_DIR}/${name}.${ext}"
            break
        fi
    done

    [[ -z "$file" ]] && die "Profile not found: ${name}\nAvailable profiles: $(find "${PROFILES_DIR}" -maxdepth 1 \( -name '*.yaml' -o -name '*.yml' \) -exec basename {} \; 2>/dev/null | sed 's/\.ya\?ml$//' | tr '\n' ', ')"
    echo "$file"
}

# ─── Help & Usage ────────────────────────────────────────────────────────────

cmd_help() {
    cat <<EOF
${BOLD}${PROG}${RESET} v${VERSION} — Company secret provider powered by Proton Pass CLI

${BOLD}USAGE${RESET}
    ${PROG} <command> [options]

${BOLD}SETUP & AUTH${RESET}
    setup               Install pass-cli, configure defaults, install completions
    login               Authenticate with Proton Pass
    logout              Clear the current session
    status              Show authentication and configuration status

${BOLD}SECRET RETRIEVAL${RESET}
    get <ref>           Get a secret value (pass://vault/item/field)
    vaults              List accessible vaults
    list [vault]        List items in a vault (interactive with fzf)
    search <query>      Search for items across all vaults

${BOLD}ENVIRONMENT MANAGEMENT${RESET}
    env <profile>       Generate .env.local from a profile
    env-diff <profile>  Show drift between .env and current vault state
    inject <template>   Process a template file with secret injection
    run <profile> -- <cmd>  Run a command with secrets from a profile

${BOLD}PROFILE MANAGEMENT${RESET}
    profile list        List all configured profiles
    profile create <n>  Create a new profile interactively
    profile edit <n>    Edit an existing profile

${BOLD}KUBERNETES HELPERS${RESET}
    k8s-secret <ns> <name> <profile>    Generate K8s Secret YAML
    k8s-externalsecret <profile>        Generate ExternalSecret YAML

${BOLD}ADMIN${RESET}
    audit               Show secret audit report
    help                Show this help message
    version             Show version

${BOLD}EXAMPLES${RESET}
    # Initial setup
    ${PROG} setup
    ${PROG} login

    # Create a profile for your app
    ${PROG} profile create myapp-dev

    # Generate .env from profile
    ${PROG} env myapp-dev

    # Run a command with secrets injected
    ${PROG} run myapp-dev -- npm start

    # Inject secrets into a template
    ${PROG} inject config.yaml.template config.yaml

    # Generate Kubernetes resources
    ${PROG} k8s-externalsecret myapp-dev > externalsecret.yaml

${BOLD}PROFILE FORMAT${RESET}
    Profiles live in ${PROFILES_DIR}/<name>.yaml:

    name: "myapp-dev"
    description: "MyApp development secrets"
    vault: "Company Secrets"
    mappings:
      DATABASE_URL: "pass://Company Secrets/MyApp DB/connection_string"
      API_KEY: "pass://Company Secrets/API Keys/myapp"
    personal:
      GITHUB_TOKEN: "pass://Personal/GitHub/token"

${BOLD}DOCUMENTATION${RESET}
    https://github.com/codefuturist/helm-charts/docs/secrets/
EOF
}

cmd_version() {
    echo "${PROG} v${VERSION}"
}

# ─── Main Dispatch ───────────────────────────────────────────────────────────

main() {
    local cmd="${1:-help}"
    shift || true

    case "$cmd" in
        setup) cmd_setup "$@" ;;
        login) cmd_login "$@" ;;
        logout) cmd_logout "$@" ;;
        status) cmd_status "$@" ;;
        get) cmd_get "$@" ;;
        vaults) cmd_vaults "$@" ;;
        list) cmd_list "$@" ;;
        search) cmd_search "$@" ;;
        env) cmd_env "$@" ;;
        env-diff) cmd_env_diff "$@" ;;
        inject) cmd_inject "$@" ;;
        run) cmd_run "$@" ;;
        profile)
            local subcmd="${1:-list}"
            shift || true
            case "$subcmd" in
                list) cmd_profile_list "$@" ;;
                create) cmd_profile_create "$@" ;;
                edit) cmd_profile_edit "$@" ;;
                *) die "Unknown profile command: ${subcmd}" ;;
            esac
            ;;
        k8s-secret) cmd_k8s_secret "$@" ;;
        k8s-externalsecret) cmd_k8s_externalsecret "$@" ;;
        audit) cmd_audit "$@" ;;
        help | --help | -h) cmd_help ;;
        version | --version) cmd_version ;;
        *) die "Unknown command: ${cmd}\nRun '${PROG} help' for usage." ;;
    esac
}

main "$@"
