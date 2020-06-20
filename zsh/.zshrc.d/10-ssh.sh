#!/usr/bin/env zsh

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

alias sshconf="nano $HOME/.ssh/config"
