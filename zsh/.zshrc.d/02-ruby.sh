#!/usr/bin/env zsh
# shellcheck shell=bash

# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed
# and these are never upgraded. This uses the upgraded brew openssl instead.
RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export RUBY_CONFIGURE_OPTS

export PATH="$PATH:$HOME/.rvm/bin"
