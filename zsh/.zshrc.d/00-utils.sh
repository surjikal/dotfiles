#!/usr/bin/env zsh

function not {
    if [[ $($@) -eq 0 ]]; then return 1; else return 0; fi
}

# Check if command is available...
function is_installed {
    hash "$1" > /dev/null 2>&1
}

function scriptdir {
    if is_installed greadlink; then greadlink -f "$1"; fi
    readlink -f "$1"
}

function ssh_tunnel {
  local src=$1
  local dst=$2
  local host=$3
  if [[ -z ${src} ]]; then
    echo "Usage: ssh_tunnel <src> [dst] [host]"
    return -1
  fi
  if [[ -z ${host} ]]; then
    host=${dst}
    dst=${src}
  fi
  ssh -N -T -L 0.0.0.0:${src}:localhost:${dst} ${host}
}

function warn {
  echo $fg[yellow]warning:$fg[default] $@
}
