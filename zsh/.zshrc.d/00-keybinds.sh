#!/usr/bin/env bash

# CTRL + BACKSPACE
bindkey '^?' backward-kill-line

# OPTION + LEFT|RIGHT
if [[ "${TERM}" == "alacritty" ]]; then
    bindkey "^[[1;3D" backward-word
    bindkey "^[[1;3C" forward-word
elif [[ "${TERM}" == xterm* ]]; then
    bindkey "^[^[[D" backward-word
    bindkey "^[^[[C" forward-word
fi
