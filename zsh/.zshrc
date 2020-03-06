#!/usr/bin/env zsh

# Emergency aliases
alias dotfiles="nane $DOTFILES/zsh/.zshrc"
alias cddot="cd $DOTFILES/zsh"
alias cdot="cddot"
alias dotedit="dotfiles"
# alias dot="dotfiles"
alias reload='unset NO_RCS; exec "$SHELL" -l'
alias ohshit="cd $DOTFILES/zsh; NO_RCS=1 exec "$SHELL" -l"
[[ ! -z $NO_RCS ]] && return

autoload -U colors; colors

# Remove macOS turds
for f in `find "$DOTFILES" -name ".DS_Store" -depth`; do
    echo $fg[yellow]removing turd:$fg[default] $f;
    rm "$f"
done

# Source all from zshrc.d
export ZSHRCD="$HOME/.zshrc.d"
for f in `find -L "$ZSHRCD" -name "*.sh" -type f | sort`; do
    chmod +x $f
    source "$f" || echo $f
done
