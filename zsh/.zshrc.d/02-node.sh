#!/usr/bin/env zsh
# shellcheck shell=bash

# Enable persistent REPL history for `node`.
export NODE_REPL_HISTORY=~/.node_history

# Allow 32³ entries; the default is 1000.
export NODE_REPL_HISTORY_SIZE='32768'

# Use sloppy mode by default, matching web browsers.
export NODE_REPL_MODE='sloppy'

# Add local node modules to path
export PATH="$PATH:$HOME/node_modules/.bin"
export PATH="/usr/local/opt/icu4c/bin:$PATH"

# Prefer node_module binaries from current working directory, if available
export PATH="./node_modules/.bin:$PATH"

# Setup volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$PATH:$VOLTA_HOME/bin"

# https://github.com/FiloSottile/mkcert#using-the-root-with-nodejs
if is_installed mkcert; then
    NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
    export NODE_EXTRA_CA_CERTS
fi
