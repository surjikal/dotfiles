#!/usr/bin/env zsh
# shellcheck shell=bash

# export HISTFILE=$HOME/.zsh.custom.history
# export HISTTIMEFORMAT="[%F %T] "
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=1000000000

# Appends every command to the history file once it is executed
setopt inc_append_history

# Reloads the history whenever you use it
setopt share_history
