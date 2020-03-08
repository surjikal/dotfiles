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
