#!/usr/bin/env zsh
# shellcheck shell=bash

# poetry
export POETRY_VIRTUALENVS_IN_PROJECT=true
export POETRY_VIRTUALENVS_PREFER_ACTIVE_PYTHON=true
# export POETRY_VIRTUALENVS_OPTIONS_NO_SETUPTOOLS=true
# export POETRY_VIRTUALENVS_OPTIONS_NO_PIP=true
export POETRY_HOME="$HOME/.poetry"
export PATH="$POETRY_HOME/bin:$PATH"

# Seems to make 'pipenv shell' a lot faster, but breaks virtualenv auto activation
# export PIPENV_SHELL_FANCY=1
export PIPENV_VERBOSITY=-1
export PIPENV_VENV_IN_PROJECT="enabled"

# https://pipenv.pypa.io/en/latest/advanced/#working-with-platform-provided-python-components
export PIP_IGNORE_INSTALLED=1
export PIPENV_DEFAULT_PYTHON_VERSION="3.8.12" # should match pyenv global

# Unsure what it does, but yolo. Safe to remove later.
# https://bugs.python.org/issue33725
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

if is_installed pyenv; then
    export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
    eval "$(pyenv init -)"
    PYENV_ROOT="$(pyenv root)"
    export PYENV_ROOT
    export PIPENV_PYTHON="$PYENV_ROOT/shims/python"
fi

if is_installed pip; then
    export PIP_REQUIRE_VIRTUALENV=true
    function gpip() { PIP_REQUIRE_VIRTUALENV="" pip "$@"; }
    function gpip3() { PIP_REQUIRE_VIRTUALENV="" pip3 "$@"; }
fi
