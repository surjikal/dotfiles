#!/usr/bin/env zsh
# shellcheck shell=bash

# Check if command is available...
function is_installed {
  command -v "$1" > /dev/null 2>&1
}

function is_vscode_terminal {
  [[ $TERM_PROGRAM = 'vscode' ]]
}

function is_subdir {
    local directory="$1"
    local subdirectory="$2"
    [ "${subdirectory##"$directory"}" != "$subdirectory" ] && return -1
    return 0
}

function not {
  # shellcheck disable=SC2091,SC2068
  $($@) || return 0
  return 1
}

# Extend path, only if target dir exists
function extend_path {
  [[ -d "$1" ]] && export PATH="$1:$PATH"
}

function fatal {
  export DOTFILES_FATAL_ERROR=1
  # shellcheck disable=SC2102,SC2154,SC2068,SC2086
  echo ${fg[red]}error:${fg[default]} $@
}

function error {
  # shellcheck disable=SC2102,SC2154,SC2068,SC2086
  echo ${fg[red]}error:${fg[default]} $@
}

function warn {
  # shellcheck disable=SC2102,SC2154,SC2068,SC2086
  echo ${fg[yellow]}warning:${fg[default]} $@
}

function file_name {
  local file
  file="$(basename "$1")"
  echo "${file%.*}"
}

function file_ext {
  local file
  file="$(basename "$1")"
  echo "${file##*.}"
}

function exec_retry {
  local -r cmd=$1
  for ((i = 0; i < 3; i++)); do
    if eval "$cmd"; then
      return 0
    fi
    sleep 5
  done
  return 1
}

# https://github.com/romkatv/powerlevel10k
function color_scheme {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}

# https://superuser.com/questions/1228411/silent-background-jobs-in-zsh/1285272
function silent_fork() {
  if [[ -n $ZSH_VERSION ]]; then  # zsh:  https://superuser.com/a/1285272/365890
    setopt local_options no_notify no_monitor
    # We'd use &| to background and disown, but incompatible with bash, so:
    "$@" &
  elif [[ -n $BASH_VERSION ]]; then  # bash: https://stackoverflow.com/a/27340076/5353461
    { 2>&3 "$@"& } 3>&2 2>/dev/null
  else  # Unknownness - just background it
    "$@" &
  fi
}

function silent_wait() {
  wait 2>/dev/null &1
}
