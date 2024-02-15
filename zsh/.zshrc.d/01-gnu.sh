#!/usr/bin/env zsh
# shellcheck shell=bash

# coreutils
extend_path "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin"

# gnu grep
extend_path "${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin"

# gnu tar
extend_path "${HOMEBREW_PREFIX}/opt/gnu-tar/libexec/gnubin"

# gnu bc
extend_path "${HOMEBREW_PREFIX}/opt/bc/bin"

# gnu sed
extend_path "${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin"

# gnu find
extend_path "${HOMEBREW_PREFIX}/opt/findutils/libexec/gnubin"

# needed by jsonv
# https://github.com/archan937/jsonv.sh
alias gawk="awk"

export LESS='--raw-control-chars --mouse --wheel-lines=1'
