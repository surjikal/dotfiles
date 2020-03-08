#!/usr/bin/env zsh

# set -eux

export EDITOR="${EDITOR:-vi}"
export DOTFILES="$HOME/.dotfiles"

# Emergency aliases / commands
alias cddot="cd $DOTFILES/zsh"
alias cdot="cddot"
alias dotfiles="nano $DOTFILES/zsh/.zshrc"

export NO_RCS=""
alias reload="unset NO_RCS && exec $SHELL -l"
alias ohshit="env NO_RCS=1 exec $SHELL -l"
function dot { dotfiles }
[[ ! -z "$NO_RCS" ]] && return

autoload -U colors; colors

# Source all from zshrc.d
export ZSHRCD="$DOTFILES/zsh/.zshrc.d"
for f in `find -L "$ZSHRCD" -name "*.sh" -type f | sort`; do
    chmod +x $f
    source "$f"
done
