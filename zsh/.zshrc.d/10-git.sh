#!/usr/bin/env zsh

# gg - opens up git gui
# gk - opens up gitk
alias gs="git status --untracked-files=no --short"
alias grh="git reset --hard"
alias gri="git rebase --interactive"
alias gf="git fetch --all"


# Git Gui seems to revert to 200x200 when resized to full screen.
# This forces a full screen layout.
function gg {
    git config --local --replace-all gui.wmstate "normal"
    git config --local --replace-all gui.geometry "9999x9999+0+0 500 450"
    git gui
}


# Implements bidirectional Gitk config sync, because the symlinks
# get overwritten for some reason.
#
# Also hardcoding the Gitk layout here, to keep the git tree clean.

LIVE_GITK_CONFIG="$HOME/.config/git/gitk"
CODE_GITK_CONFIG="$DOTFILES/git/.config/git/gitk"


__surj_gitk_del_geometry() {
    sed -i '/^set geometry/d'  "$LIVE_GITK_CONFIG"
    sed -i '/^set permviews/d' "$LIVE_GITK_CONFIG"
}


__surj_gitk_add_geometry() {
    __surj_gitk_del_geometry
    echo -e \
"set geometry(main) 1792x1075+0+23
set geometry(state) zoomed
set geometry(topwidth) 1792
set geometry(topheight) 635
set geometry(pwsash0) \"1245 1\"
set geometry(pwsash1) \"1598 1\"
set geometry(botwidth) 1484
set geometry(botheight) 435
set permviews {}" >> "$LIVE_GITK_CONFIG"
}


function gk {
    local args=("${@:-"--all"}")
    __surj_gitk_add_geometry
    gitk $args[@]
    __surj_gitk_del_geometry
    cp $LIVE_GITK_CONFIG $CODE_GITK_CONFIG
}


# Fixes graphical issues with git-gui / gitk on macOS
extend_path /usr/local/opt/tcl-tk
