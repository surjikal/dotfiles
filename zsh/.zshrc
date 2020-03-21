#!/usr/bin/env zsh

# set -eux

# export HISTFILE="$HOME/.zsh_history"
# export HISTSIZE=999999999
# export SAVEHIST=$HISTSIZE

export EDITOR="${EDITOR:-vi}"
export DOTFILES="$HOME/.dotfiles"

# Emergency aliases / commands
alias cddot="cd $DOTFILES/zsh"
alias cdot="cddot"
alias dotfiles="nano $DOTFILES/zsh/.zshrc"

alias reload="unset NO_RCS && exec $SHELL -l"
alias ohshit="NO_RCS=1 exec $SHELL -l"
function dot { dotfiles }
[[ ! -z "$NO_RCS" ]] && return

autoload -U colors; colors

# Source all from zshrc.d
export ZSHRCD="$DOTFILES/zsh/.zshrc.d"
for f in `find -L "$ZSHRCD" -name "*.sh" -type f | sort`; do
    chmod +x $f
    source "$f"
done
