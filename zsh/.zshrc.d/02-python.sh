#!/usr/bin/env zsh
# shellcheck shell=bash

export PIP_IGNORE_INSTALLED=1
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Seems to make 'pipenv shell' a lot faster, but breaks virtualenv auto activation
# export PIPENV_SHELL_FANCY=1
export PIPENV_VERBOSITY=-1
export PIPENV_VENV_IN_PROJECT="enabled"
export PIPENV_DEFAULT_PYTHON_VERSION="3.8.5"

# Unsure what it does, but yolo. Safe to remove later.
# https://bugs.python.org/issue33725
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

if is_installed pyenv; then
    eval "$(pyenv init -)"
    PYENV_ROOT="$(pyenv root)"
    export PYENV_ROOT
fi

if is_installed pip; then
    export PIP_REQUIRE_VIRTUALENV=true
    function gpip() { PIP_REQUIRE_VIRTUALENV="" pip "$@"; }
    function gpip3() { PIP_REQUIRE_VIRTUALENV="" pip3 "$@"; }
fi
