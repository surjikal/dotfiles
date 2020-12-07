#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck disable=SC2034

custom_pyenv() {
    local version;
    version=$(pyenv version-alias)
    if [[ "${version}" != "global" ]]; then
        echo "${version//\%/%%}"
    fi
}
POWERLEVEL9K_CUSTOM_PYENV="custom_pyenv"
POWERLEVEL9K_CUSTOM_PYENV_BACKGROUND='clear'
export VIRTUAL_ENV_DISABLE_PROMPT=1
