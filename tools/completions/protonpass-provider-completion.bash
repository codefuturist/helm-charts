# Bash completion for protonpass-provider
# Source this file or add to ~/.local/share/bash-completion/completions/

_protonpass_provider() {
    local cur prev words cword
    _init_completion || return

    local commands="setup login logout status get vaults list search env env-diff inject run profile k8s-secret k8s-externalsecret audit help version"
    local profile_commands="list create edit"

    case "${prev}" in
        protonpass-provider|protonpass-provider.sh)
            COMPREPLY=($(compgen -W "${commands}" -- "${cur}"))
            return
            ;;
        profile)
            COMPREPLY=($(compgen -W "${profile_commands}" -- "${cur}"))
            return
            ;;
        env|env-diff|run|k8s-secret|k8s-externalsecret)
            # Complete with profile names
            local profiles_dir="${XDG_CONFIG_HOME:-$HOME/.config}/protonpass-provider/profiles"
            if [[ -d "${profiles_dir}" ]]; then
                local profiles
                profiles=$(find "${profiles_dir}" -name "*.yaml" -o -name "*.yml" 2>/dev/null | xargs -I{} basename {} | sed 's/\.ya\?ml$//')
                COMPREPLY=($(compgen -W "${profiles}" -- "${cur}"))
            fi
            return
            ;;
        create|edit)
            if [[ "${words[1]}" == "profile" ]]; then
                local profiles_dir="${XDG_CONFIG_HOME:-$HOME/.config}/protonpass-provider/profiles"
                if [[ -d "${profiles_dir}" ]]; then
                    local profiles
                    profiles=$(find "${profiles_dir}" -name "*.yaml" -o -name "*.yml" 2>/dev/null | xargs -I{} basename {} | sed 's/\.ya\?ml$//')
                    COMPREPLY=($(compgen -W "${profiles}" -- "${cur}"))
                fi
            fi
            return
            ;;
        inject)
            # Complete with template files
            COMPREPLY=($(compgen -f -X '!*.template' -- "${cur}"))
            COMPREPLY+=($(compgen -f -X '!*.tmpl' -- "${cur}"))
            return
            ;;
        get)
            # Suggest pass:// prefix
            if [[ -z "${cur}" ]]; then
                COMPREPLY=("pass://")
            fi
            return
            ;;
    esac

    COMPREPLY=($(compgen -W "${commands}" -- "${cur}"))
}

complete -F _protonpass_provider protonpass-provider
complete -F _protonpass_provider protonpass-provider.sh
