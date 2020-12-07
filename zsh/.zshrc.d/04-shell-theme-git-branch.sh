#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck disable=SC2034


# Some of these taken here...
# https://coderwall.com/p/pn8f0g/show-your-git-status-and-branch-in-color-at-the-command-prompt

is_git_repo() {
  git diff --quiet --ignore-submodules HEAD > /dev/null 2>&1
}


git_stats() {
  if is_git_repo; then
    setopt local_options BASH_REMATCH
    local total_insertions=0
    local total_deletions=0

    # shellcheck disable=SC2030
    while read -r value; do
      if [[ ${value} =~ ([[:digit:]]+)\ insertions.*\ ([[:digit:]]+)\ deletions ]]; then
        (( total_insertions = total_insertions + ${BASH_REMATCH[2]:-0} ))
        (( total_deletions  = total_deletions  + ${BASH_REMATCH[3]:-0} ))
      fi
    done < <(git diff --shortstat --cached; git diff --shortstat)

    # shellcheck disable=SC2031
    [[ $total_insertions -eq 0 ]] && total_insertions="" || total_insertions="%F{yellow}+$total_insertions%F{clear}"

    # shellcheck disable=SC2031
    [[ $total_deletions  -eq 0 ]] && total_deletions=""  || total_deletions="%F{red}-$total_deletions%F{clear}"

    echo "$total_insertions $total_deletions"
  fi
}

custom_git_branch() {
  local branch;
  branch=$(git symbolic-ref --short HEAD 2> /dev/null)
  if git diff-index --quiet HEAD > /dev/null 2>&1; then
    echo -n "%F{green}"
  else
    echo -n "%F{red}"
  fi
  echo "$branch%F{clear}"
}
POWERLEVEL9K_CUSTOM_GIT_BRANCH="custom_git_branch"
POWERLEVEL9K_CUSTOM_GIT_BRANCH_ICON=""
POWERLEVEL9K_CUSTOM_GIT_BRANCH_SEGMENT_ICON=""
POWERLEVEL9K_CUSTOM_GIT_BRANCH_BACKGROUND="clear"
POWERLEVEL9K_CUSTOM_GIT_BRANCH_FOREGROUND="008"
