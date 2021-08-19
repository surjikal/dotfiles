#!/usr/bin/env zsh
# shellcheck shell=bash

DOTFILES_SEARCH_PATH="$DOTFILES/zsh/.zshrc.d"
BREWFILE="$DOTFILES/Brewfile"

function _list_files {
    local query="$1"
    find "${DOTFILES_SEARCH_PATH}" -name "*${query}*.sh" -type f
}

function _list_slugs {
    for f in $(_list_files); do
        echo $f | sed -e 's/^.*\-\(.*\)\.sh$/\1/'
    done
}

# Helper that opens up the dotfile in vscode
# if we're in a vscode terminal
function _edit {
    local file="$1"
    if is_vscode_terminal; then
        code -w "$file"
    else
        $VISUAL $file
    fi
}


# Usage: dot [brew|query?]
function dot {
    local query="$1"

    # No arguments: open dotfiles in editor
    if [[ -z "$query" ]]; then
        [[ ! -t 1 ]] && echo "$DOTFILES" && return 0
        $VISUAL "$DOTFILES"

    # dot brew
    elif [[ "$query" == br* ]]; then
        [[ ! -t 1 ]] && echo "$BREWFILE" && return 0
        _edit "$BREWFILE"
        sort "$BREWFILE" -o "$BREWFILE"
        >&2 echo -n "${fg[green]}update using:${fg[default]}\nbrew bundle ${BREWFILE}\n"

    # dot [query]: tries to match the query against an existing file
    else
        result=$(_list_files "$query" | head -n1)

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
                local filename="10-$query.sh"
                echo "Create new dotfile ($filename)?"
                read "response?y|[n]: "
                echo $response
                if [[ "$response" =~ ^[Yy]$ ]]; then
                    _edit "$DOTFILES_SEARCH_PATH/$filename"
                fi
            }
            return 1
        fi
    fi

    return 0
}

function dotgg {
    cd $DOTFILES && gg
}

# Tab completion for 'dot' command
compdef __dot_completions dot
function __dot_completions {
    local _slugs="$(_list_slugs)"
    local _extras="brew"
    _arguments -C \
        "1: :($_extras $_slugs)" \
        "*::arg:->args"
}
