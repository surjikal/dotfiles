#!/usr/bin/env zsh

export PATH="$HOME/.local/bin:$PATH" # pipx
if is_installed pyenv; then eval "$(pyenv init -)"; fi # pyenv
export PIP_REQUIRE_VIRTUALENV=true
function gpip()  { PIP_REQUIRE_VIRTUALENV="" pip "$@" }
function gpip3() { PIP_REQUIRE_VIRTUALENV="" pip3 "$@" }
