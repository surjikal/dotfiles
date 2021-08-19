#!/usr/bin/env zsh
# shellcheck shell=bash

# gg - opens up git gui
# gk - opens up gitk
alias gs="git status --untracked-files=no --short"
alias grh="git reset --hard"
alias gr="HUSKY_SKIP_HOOKS=1 git rebase"
alias gri="HUSKY_SKIP_HOOKS=1 git rebase --interactive"
alias gf="git fetch --all"

function git-branch-age() {
    eval "$(
        git for-each-ref --shell --format \
            "git --no-pager log -1 --date=iso --format='%%ad '%(align:left,25)%(refname:short)%(end)' %%h %%s' \$(git merge-base %(refname:short) master);" \
            refs/heads
    )" | sort
}

# Git stash pop, with fzf to select the stash
function gsp() {
    cmd="${1:-pop}"
    stash=$(git stash list | fzf | cut -d: -f1)
    [[ -z "$stash" ]] && return 0
    git stash "$cmd" "$stash"
}

# Git reset, with fzf to select the file
function gsr() {
    local file
    file=$(git status --untracked-files=no --short | fzf --prompt='reset file' --info=inline)
    [ -z "$file" ] && return 0
    file=$(echo "$file" | cut -c4-)
    git checkout -- "$file"
}

# Git Gui seems to revert to 200x200 when resized to full screen.
# This forces a full screen layout.
function gg() {
    git config --local --replace-all gui.wmstate "zoomed"
    git config --local --replace-all gui.geometry "1792x1075+0+23 509 700"
    git config --local --replace-all gui.commitmsgwidth "180"
    git gui "$@"
}

function gga() {
    gg --amend
}

# Implements bidirectional Gitk config sync, because the symlinks
# get overwritten for some reason.
#
# Also hardcoding the Gitk layout here, to keep the git tree clean.

CODE_GITK_CONFIG="$DOTFILES/git/.config/git/gitk"
LIVE_GITK_CONFIG="$HOME/.config/git/gitk"

__surj_gitk_del_geometry() {
    sed -i '/^set geometry/d' "$LIVE_GITK_CONFIG"
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
set permviews {}" >>"$LIVE_GITK_CONFIG"
}

function gk() {
    local args=("${@:-"--all"}")
    __surj_gitk_add_geometry
    gitk "${args[@]}"
}

# Fixes graphical issues with git-gui / gitk on macOS
extend_path /usr/local/opt/tcl-tk/bin

# Silence some OSX warning about TK being deprecated
export TK_SILENCE_DEPRECATION=1
