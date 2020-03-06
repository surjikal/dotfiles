#!/usr/bin/env zsh

alias dotfiles="code-insiders -n $DOTFILES/dotfiles.code-workspace"
alias VISUAL="code-insiders"

function dot {
    local file="$1"
    if [[ -z "$file" ]] then; dotfiles; else;
    file=$(find $DOTFILES/zsh/.zshrc.d -name "*-${file}*.sh" | head -n1)
    echo "$fg[yellow] editing file:$fg[default] $file"
    $EDITOR "$file"
    fi
}
