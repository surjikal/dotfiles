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
        # shellcheck disable=SC2001
        echo "$f" | sed -e 's/^.*\-\(.*\)\.sh$/\1/'
    done
}

# Helper that opens up the dotfile in vscode
function _edit_file {
    local file="$1"
    $VISUAL "$file"
}

function _create_file {
    local file="$1"
    {
        echo "#!/usr/bin/env zsh"
        echo "# shellcheck shell=bash"
        echo ""
        echo ""
    } >>"$file"
}

# Usage: dotfiles [brew|query?]
function dotfiles {
    local query="$1"

    # No arguments: open dotfiles in editor
    if [[ -z "$query" ]]; then
        [[ ! -t 1 ]] && echo "$DOTFILES" && return 0
        $VISUAL "$DOTFILES"

    # dotfiles brew
    elif [[ "$query" == br* ]]; then
        [[ ! -t 1 ]] && echo "$BREWFILE" && return 0
        _edit_file "$BREWFILE"
        sort "$BREWFILE" -o "$BREWFILE"
        # shellcheck disable=SC2028,SC2154
        echo >&2 -n "${fg[green]}update using:${fg[default]}\nbrew bundle ${BREWFILE}\n"

    # dotfiles [query]: tries to match the query against an existing file
    else
        result=$(_list_files "$query" | head -n1)

        # query found...
        # shellcheck disable=SC1046,SC1073
        if [[ -f "$result" ]]; then
            [[ ! -t 1 ]] && echo "$result" && return 0
            echo >&2 "${fg[yellow]}edited:${fg[default]} $result"
            _edit_file "$result"
        # query not found...
        else
            [[ -t 1 ]] && {
                echo "${fg[red]}error:${fg[default]} could not find ${fg[cyan]}${query}${fg[default]}"
                local filename="10-$query.sh"
                echo "Create new dotfile ($filename)?"
                read -r "response?y|[n]: "
                # shellcheck disable=SC2154
                echo "$response"
                if [[ "$response" =~ ^[Yy]$ ]]; then
                    local filepath="$DOTFILES_SEARCH_PATH/$filename"
                    _create_file "$filepath"
                    _edit_file "$filepath"
                fi
            } >&2
            return 1
        fi
    fi

    return 0
}
alias dt='dotfiles'

# Tab completion for 'dot' command
compdef __dotfiles_completions dot
function __dotfiles_completions {
    local _extras="brew"
    local _slugs
    _slugs="$(_list_slugs)"
    _arguments -C \
        "1: :($_extras $_slugs)" \
        "*::arg:->args"
}
