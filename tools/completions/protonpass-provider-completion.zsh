#compdef protonpass-provider protonpass-provider.sh
# Zsh completion for protonpass-provider

_protonpass_provider_profiles() {
    local profiles_dir="${XDG_CONFIG_HOME:-$HOME/.config}/protonpass-provider/profiles"
    if [[ -d "${profiles_dir}" ]]; then
        local -a profiles
        profiles=(${profiles_dir}/*.yaml(N:t:r) ${profiles_dir}/*.yml(N:t:r))
        _describe 'profile' profiles
    fi
}

_protonpass_provider() {
    local -a commands=(
        'setup:Install pass-cli, configure defaults, install completions'
        'login:Authenticate with Proton Pass'
        'logout:Clear the current session'
        'status:Show authentication and configuration status'
        'get:Get a secret value (pass://vault/item/field)'
        'vaults:List accessible vaults'
        'list:List items in a vault (interactive with fzf)'
        'search:Search for items across all vaults'
        'env:Generate .env.local from a profile'
        'env-diff:Show drift between .env and vault state'
        'inject:Process a template file with secret injection'
        'run:Run a command with secrets from a profile'
        'profile:Manage secret profiles'
        'k8s-secret:Generate Kubernetes Secret YAML'
        'k8s-externalsecret:Generate ExternalSecret YAML'
        'audit:Show secret audit report'
        'help:Show help message'
        'version:Show version'
    )

    local -a profile_commands=(
        'list:List all profiles'
        'create:Create a new profile interactively'
        'edit:Edit an existing profile'
    )

    _arguments -C \
        '1:command:->command' \
        '*::arg:->args'

    case "$state" in
        command)
            _describe 'command' commands
            ;;
        args)
            case "${words[1]}" in
                profile)
                    _arguments '1:subcommand:->subcommand' '*::arg:->subargs'
                    case "$state" in
                        subcommand) _describe 'profile command' profile_commands ;;
                        subargs)
                            case "${words[1]}" in
                                create|edit) _protonpass_provider_profiles ;;
                            esac
                            ;;
                    esac
                    ;;
                env|env-diff|run|k8s-secret|k8s-externalsecret)
                    _protonpass_provider_profiles
                    ;;
                inject)
                    _files -g '*.template|*.tmpl'
                    ;;
                get)
                    _message 'pass://vault/item/field'
                    ;;
                list)
                    _message 'vault name'
                    ;;
                search)
                    _message 'search query'
                    ;;
            esac
            ;;
    esac
}

_protonpass_provider "$@"
