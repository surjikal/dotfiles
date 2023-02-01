#!/usr/bin/env zsh
# shellcheck shell=bash

# coreutils
extend_path /usr/local/opt/coreutils/libexec/gnubin

# gnu grep
extend_path /usr/local/opt/grep/libexec/gnubin

# gnu tar
extend_path /usr/local/opt/gnu-tar/libexec/gnubin

# gnu bc
extend_path /usr/local/opt/bc/bin

# gnu sed
extend_path /usr/local/opt/gnu-sed/libexec/gnubin

# needed by jsonv
# https://github.com/archan937/jsonv.sh
alias gawk="awk"

export LESS='--raw-control-chars --mouse --wheel-lines=1'
