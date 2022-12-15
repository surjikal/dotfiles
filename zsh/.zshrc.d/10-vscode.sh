#!/usr/bin/env zsh
# shellcheck shell=bash

if is_installed code-insiders; then
    alias code="code-insiders"
    alias vscode="code-insiders"
    export VISUAL="code-insiders"
elif is_installed code; then
    alias vscode="code"
    export VISUAL="code"
else
    export VISUAL="${VISUAL:-$EDITOR}"
fi
