#!/usr/bin/env zsh
# shellcheck shell=bash

# Seems to make 'pipenv shell' a lot faster, breaks auto-virtualenv
# export PIPENV_SHELL_FANCY=1
export PIPENV_VERBOSITY=-1
export PIPENV_VENV_IN_PROJECT="enabled"
export PIPENV_DEFAULT_PYTHON_VERSION="3.8.5"
export PIP_IGNORE_INSTALLED=1
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

if is_installed pyenv; then
    eval "$(pyenv init -)"
    PYENV_ROOT="$(pyenv root)"
    export PYENV_ROOT
fi

if is_installed pyenv-virtualenv-init; then
    eval "$(pyenv virtualenv-init -)"
fi

if is_installed pip; then
    export PIP_REQUIRE_VIRTUALENV=true
    function gpip()  { PIP_REQUIRE_VIRTUALENV="" pip "$@"; }
    function gpip3() { PIP_REQUIRE_VIRTUALENV="" pip3 "$@"; }
fi
