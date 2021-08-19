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
    [ "${subdirectory##$directory}" != "$subdirectory" ] && return -1
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

function error {
  # shellcheck disable=SC2102,SC2154,SC2068,SC2086
  echo ${fg[red]}error:${fg[default]} $@
}

function warn {
  # shellcheck disable=SC2102,SC2154,SC2068,SC2086
  echo ${fg[yellow]}warning:${fg[default]} $@
}

function file_name {
  echo "${$(basename "$1")%.*}"
}

function file_ext {
  echo "${$(basename "$1")##*.}"
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
