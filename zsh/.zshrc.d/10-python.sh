#!/usr/bin/env zsh

is_installed pipx  && export PATH="$HOME/.local/bin:$PATH"
is_installed pyenv && eval "$(pyenv init -)"

if is_installed pip; then
    export PIP_REQUIRE_VIRTUALENV=true
    function gpip()  { PIP_REQUIRE_VIRTUALENV="" pip "$@" }
    function gpip3() { PIP_REQUIRE_VIRTUALENV="" pip3 "$@" }
fi
