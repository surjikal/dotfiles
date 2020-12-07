#!/usr/bin/env zsh
# shellcheck shell=bash

# set -eux

export EDITOR="${EDITOR:-vi}"
export DOTFILES="$HOME/.dotfiles"

# Emergency aliases / commands
alias cdot="cddot"
alias cddot='cd "$DOTFILES/zsh"'
alias dotfiles='nano "$DOTFILES/zsh/.zshrc"'

alias reload='unset NO_RCS && exec $SHELL -l'
alias ohshit='NO_RCS=1 exec $SHELL -l'
function dot {
    dotfiles
}

[[ -n "$NO_RCS" ]] && return

autoload -U colors; colors

# Source all from zshrc.d
export ZSHRCD="$DOTFILES/zsh/.zshrc.d"
for f in $(find -L "$ZSHRCD" -name "*.sh" -type f | sort); do
    chmod +x "$f"
    # shellcheck source=/dev/null
    source "$f"
done
