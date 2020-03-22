#!/usr/bin/env zsh

if is_installed code-insiders; then
    alias code="code-insiders"
    alias vscode="code"
    alias dotfiles="code -n $DOTFILES"
    export VISUAL="code"
fi

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
        $EDITOR $file
    fi
}


# Usage: dot [brew|query?]
function dot {
    local query="$1"

    # No arguments: open dotfiles in editor
    if [[ -z "$query" ]] then;
        [[ ! -t 1 ]] && echo "$DOTFILES" && return 0
        dotfiles;

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
        if [[ -f "$result" ]]; then
            [[ ! -t 1 ]] && echo "$result" && return 0
            >&2 echo "${fg[yellow]}edited:${fg[default]} $result"
            _edit "$result"

        # query not found...
        else;
            [[ -t 1 ]] && >&2 echo "${fg[red]}error:${fg[default]} could not find ${fg[cyan]}${query}${fg[default]}"
            return 1
        fi
    fi

    return 0
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
