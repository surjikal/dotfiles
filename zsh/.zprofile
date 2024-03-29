#!/usr/bin/env zsh
# shellcheck shell=bash

function is_installed {
    command -v "$1" >/dev/null 2>&1
}

# had some trouble with brew
eval "$(/opt/homebrew/bin/brew shellenv)"
export PATH="$PATH:$HOMEBREW_PREFIX/bin"

# Required for pyenv version 2
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if is_installed pyenv; then
    eval "$(pyenv init --path)"
fi

# Created by `userpath` on 2019-10-10 20:22:56
export PATH="$PATH:$HOME/.local/bin"
export PATH="$HOME/.poetry/bin:$PATH"

# Added automatically
#############################################
