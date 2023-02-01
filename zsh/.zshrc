#!/usr/bin/env zsh
# shellcheck shell=bash

# set -x

# if [[ -n "$DOTFILES_PROFILE" ]]; then
#     zmodload zsh/zprof
# fi

export EDITOR="${EDITOR:-vi}"
export DOTFILES="$HOME/.dotfiles"

# Emergency aliases / commands
alias cdot="cddot"
alias cddot='cd "$DOTFILES"'

alias reload='unset NO_RCS && exec $SHELL -l'
alias ohshit='NO_RCS=1 exec $SHELL -l'

[[ -n "$NO_RCS" ]] && return

# fix some issue with google drive + stow
rm -f "$HOME/Google Drive"

# setup asdf early
if [[ -f /usr/local/opt/asdf/libexec/asdf.sh ]]; then
    . /usr/local/opt/asdf/libexec/asdf.sh
fi

# Source all from zshrc.d
export ZSHRCD="$DOTFILES/zsh/.zshrc.d"
for f in $(find -s -L "$ZSHRCD" -name "*.sh" -type f); do
    [[ -n "$DOTFILES_PROFILE" ]] && echo "source: $f"
    chmod +x "$f"
    # shellcheck source=/dev/null
    source "$f"
done

if [[ -n "$DOTFILES_PROFILE" ]]; then
    zprof
fi

# Everything added below has been added by install scripts
##########################################################
