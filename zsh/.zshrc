#!/usr/bin/env zsh
# shellcheck shell=bash

# DOTFILES_PROFILE="${DOTFILES_PROFILE:-}"

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

[[ -n "${NO_RCS+1}" ]] && return

# fix some issue with google drive + stow
rm -f "${HOME}/Google Drive"

# clean macOS turds since it makes stow complain...
# rm -f "${DOTFILES}"/**/.DS_Store

# setup asdf early
if [[ -f /usr/local/opt/asdf/libexec/asdf.sh ]]; then
    . /usr/local/opt/asdf/libexec/asdf.sh
fi

# Source all from zshrc.d
export ZSHRCD="$DOTFILES/zsh/.zshrc.d"
for f in $(find -s -L "$ZSHRCD" -name "*.sh" -type f); do
    if [[ -n "${DOTFILES_FATAL_ERROR+1}" ]]; then
        echo "Stopping due to fatal error"
        return
    fi
    [[ -n "${DOTFILES_PROFILE+1}" ]] && echo "source: $f"
    [[ -n "${DOTFILES_LOG_SOURCE+1}" ]] && echo "source: $f"
    chmod +x "$f"
    # shellcheck source=/dev/null
    source "$f"
    [[ -n "${DOTFILES_DELAY+1}" ]] && sleep $DOTFILES_DELAY
done

if [[ -n "$DOTFILES_PROFILE" ]]; then
    zprof
fi

# Everything added below has been added by install scripts
##########################################################
