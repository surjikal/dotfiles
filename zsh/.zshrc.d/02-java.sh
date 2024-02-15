#!/usr/bin/env zsh
# shellcheck shell=bash

if is_installed jenv; then
    export PATH="$HOME/.jenv/bin:$PATH"
    export PATH="$HOME/.jenv/shims:$PATH"
    eval "$(jenv init -)"
fi
