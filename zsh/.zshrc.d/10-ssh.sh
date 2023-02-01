#!/usr/bin/env zsh
# shellcheck shell=bash

function ssh_tunnel() {
  local src=$1
  local dst=$2
  local host=$3
  if [[ -z ${src} ]]; then
    echo "Usage: ssh_tunnel <src> [dst] [host]"
    return 255
  fi
  if [[ -z ${host} ]]; then
    host=${dst}
    dst=${src}
  fi
  ssh -N -T -L "0.0.0.0:${src}:127.0.0.1:${dst}" "${host}"
}


_SSHCONF_SEARCH_PATH="$HOME/.ssh/config.d"

function _sshconf__list_files {
    local query="$1"
    find "${_SSHCONF_SEARCH_PATH}" -name "*${query}*" -type f
}

function _edit {
    local file="$1"
    if is_vscode_terminal; then
        code -w "$file"
    else
        $VISUAL $file
    fi
}

# Usage: sshconf [query]
function sshconf {
    local query="$1"

    # No arguments: open dotfiles in editor
    if [[ -z "$query" ]]; then
        $VISUAL "$_SSHCONF_SEARCH_PATH"

    # sshconf [query]: tries to match the query against an existing file
    else
        result=$(_sshconf__list_files "$query" | head -n1)

        # query found...
        # shellcheck disable=SC1046,SC1073
        if [[ -f "$result" ]]; then
            [[ ! -t 1 ]] && echo "$result" && return 0
            >&2 echo "${fg[yellow]}edited:${fg[default]} $result"
            _edit "$result"
        # query not found...
        else
            [[ -t 1 ]] && >&2 {
                echo "${fg[red]}error:${fg[default]} could not find ${fg[cyan]}${query}${fg[default]}"
            }
            return 1
        fi
    fi

    return 0
}

# Tab completion for 'sshconf' command
# compdef __sshconf_completions sshconf
# function __sshconf_completions {
#     local _slugs="$(_sshconf__list_files | xargs -L 1 basename | grep -v '^\.')"
#     _arguments -C \
#         "1: :($_slugs)" \
#         "*::arg:->args"
# }
