#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck disable=SC2102,SC2154,SC2068,SC2086

function shellinfo {
    echo ${fg[blue]}setopt:${fg[default]} $@
    setopt
    echo ${fg[blue]}unsetopt:${fg[default]} $@
    unsetopt
}
