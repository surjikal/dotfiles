#!/usr/bin/env zsh

if is_installed code-insiders; then
    alias dotfiles="code-insiders -n $DOTFILES"
    alias VISUAL="code-insiders"
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

function dot {
    local query="$1"
    # no arguments: run 'dotfiles' command
    if [[ -z "$query" ]] then;
        dotfiles;
    elif [[ "$query" == br* ]]; then
        $EDITOR "$BREWFILE"
        sort "$BREWFILE" -o "$BREWFILE"
        >&2 echo -n "${fg[green]}update using:${fg[default]}\nbrew bundle ${BREWFILE}\n"
    else
        result=$(_list_files "$query" | head -n1)
        if [[ -f "$result" ]]; then
            >&2 echo "${fg[yellow]}edited:${fg[default]} $result"
            $EDITOR "$result"
        else;
            >&2 echo "${fg[red]}error:${fg[default]} could not find ${fg[cyan]}${query}${fg[default]}"
            return 1
        fi
    fi
    return 0
}


# Tab completion for 'dot' command
compdef _dot dot
function _dot {
    local _slugs="$(_list_slugs)"
    echo $_slugs
    local _extras="brew"
    _arguments -C \
        "1: :($_extras $_slugs)" \
        "*::arg:->args"
}
