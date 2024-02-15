#!/usr/bin/env zsh
# shellcheck shell=bash

alias gst="git status --untracked-files=no --short"
alias grh="git reset --hard"
alias gr="HUSKY=0 HUSKY_SKIP_HOOKS=1 git rebase"
alias gri="HUSKY=0 HUSKY_SKIP_HOOKS=1 git rebase --interactive --rebase-merges"
alias gm="HUSKY=0 HUSKY_SKIP_HOOKS=1 git merge"
alias gmc="HUSKY=0 HUSKY_SKIP_HOOKS=1 git merge --continue"
alias nohook="HUSKY=0 HUSKY_SKIP_HOOKS=1"
alias gf="git fetch --all"
alias gs="git status --short -uno"


# function git-status() {
#     for stat in $(git status --porcelain); do
#         local g_status;
#         local g_filename;
#         g_status=$(echo "$stat" | cut -d' ' -f1)
#         g_filename=$(echo "$stat" | cut -d' ' -f2-)
#         if [[ "${g_status}" == "??" ]]; then
#             # shellcheck disable=SC2028,SC2154
#             echo -e "%F{008}${g_filename}${fg[default]}"
#         else
#             # shellcheck disable=SC2028,SC2154
#             echo -e "${fg[green]}${g_filename}${fg[default]}"
#         fi
#     done
# }

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

LIVE_GITK_CONFIG="$HOME/.config/git/gitk"

__surj_gitk_del_geometry() {
    sed -i -e '/^set geometry/d' "$LIVE_GITK_CONFIG"
    sed -i -e '/^set permviews/d' "$LIVE_GITK_CONFIG"
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
    gitk --date-order "${args[@]}"
}

# Fixes graphical issues with git-gui / gitk on macOS
# extend_path /usr/local/opt/tcl-tk/bin

# Silence some OSX warning about TK being deprecated
export TK_SILENCE_DEPRECATION=1

# alias k="gk"
