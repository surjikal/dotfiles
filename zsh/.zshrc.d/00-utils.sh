#!/usr/bin/env zsh

# Check if command is available...
function is_installed {
  command -v "$1" > /dev/null 2>&1
}

function not {
  $($@) || return 0
  return 1
}

# Extend path, only if target dir exists
function extend_path {
  [[ -d "$1" ]] && export PATH="$1:$PATH"
}

function warn {
  echo $fg[yellow]warning:$fg[default] $@
}

# https://github.com/romkatv/powerlevel10k
function color_scheme {
  for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done
}
