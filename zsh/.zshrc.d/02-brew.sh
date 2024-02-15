#!/usr/bin/env zsh
# shellcheck shell=bash

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_NO_INSTALL_CLEANUP=1

# Prevents brew from updating random stuff when installing something
# This happens after a brew update and is annoying
export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1

# If CMAKE uses all the 8 cores, computer just locks up
# export CMAKE_BUILD_PARALLEL_LEVEL=6
