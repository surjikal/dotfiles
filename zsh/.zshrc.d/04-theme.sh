#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck disable=SC2034


# Some of these taken here...
# https://coderwall.com/p/pn8f0g/show-your-git-status-and-branch-in-color-at-the-command-prompt

is_git_repo() {
  git diff --quiet --ignore-submodules HEAD >/dev/null 2>&1
}

git_stats() {
  if is_git_repo; then
    setopt local_options BASH_REMATCH
    local total_insertions=0
    local total_deletions=0

    # shellcheck disable=SC2030
    while read -r value; do
      if [[ ${value} =~ ([[:digit:]]+)\ insertions.*\ ([[:digit:]]+)\ deletions ]]; then
        ((total_insertions = total_insertions + ${BASH_REMATCH[2]:-0}))
        ((total_deletions = total_deletions + ${BASH_REMATCH[3]:-0}))
      fi
    done < <(
      git diff --shortstat --cached
      git diff --shortstat
    )

    # shellcheck disable=SC2031
    [[ $total_insertions -eq 0 ]] && total_insertions="" || total_insertions="%F{yellow}+$total_insertions%F{clear}"

    # shellcheck disable=SC2031
    [[ $total_deletions -eq 0 ]] && total_deletions="" || total_deletions="%F{red}-$total_deletions%F{clear}"

    echo "$total_insertions $total_deletions"
  fi
}

custom_git_branch() {
  local branch
  echo -n "%F{237}%F{clear}"
  git diff-index --quiet HEAD >/dev/null 2>&1
  ret=$?
  [[ $ret -eq 128 ]] && return

  if [[ $ret -eq 0 ]]; then
    echo -n "%F{green}"
  else
    echo -n "%F{magenta}"
  fi

  branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  echo -n "$branch"

  if [[ -n "$branch" ]]; then
    tracking=$(git status -b --porcelain=v2 | grep "^# branch.upstream " | cut -d " " -f 3- | head -n1)
    if [[ -n "$tracking" ]]; then
      echo -n "%F{008}:%F{cyan}$tracking"
    fi
  fi

  echo -n "%F{clear}"
}

POWERLEVEL9K_CUSTOM_GIT_BRANCH="custom_git_branch"
POWERLEVEL9K_CUSTOM_GIT_BRANCH_ICON=""
POWERLEVEL9K_CUSTOM_GIT_BRANCH_SEGMENT_ICON=""
POWERLEVEL9K_CUSTOM_GIT_BRANCH_BACKGROUND="clear"
POWERLEVEL9K_CUSTOM_GIT_BRANCH_FOREGROUND="008"

custom_node_version() {
  local version;
  version="$(nvm current)"
  # echo -n "%F{237} - %F{clear}"
  echo -e "%F{008}[node ${version//\%/%%}]"
}
POWERLEVEL9K_CUSTOM_NODE="custom_node_version"
POWERLEVEL9K_CUSTOM_NODE_BACKGROUND='clear'


custom_poetry_python_version() {
    local py_version;
    py_version="$(poetry env info -n --no-ansi --no-plugins | grep Python | head -n1 | awk '{print $2}')"
    if [[ "${py_version}" != "global" ]]; then
        # echo -n "%F{237} - %F{clear}"
        echo -e "%F{008}[poetry ${py_version//\%/%%}]"
    fi
}

custom_pyenv() {
    local py_version;
    py_version="$(pyenv version-name)"
    if [[ "${py_version}" != "global" ]]; then
        # echo -n "%F{237} - %F{clear}"
        echo -e "%F{008}[pyenv ${py_version//\%/%%}]"
    fi
}
POWERLEVEL9K_CUSTOM_PYENV="custom_pyenv"
POWERLEVEL9K_CUSTOM_PYENV_BACKGROUND='clear'

custom_virtualenv() {
  local name="${VIRTUAL_ENV:t}"
  if [[ -z "${name}" ]]; then return; fi
  if [[ "${name}" == ".venv" ]]; then
    name="$(dirname "${VIRTUAL_ENV:a}")"
    name="${name:t}"
  fi
  echo -e "%F{008}(${name//\%/%%})"
}
POWERLEVEL9K_CUSTOM_VIRTUALENV="custom_virtualenv"
POWERLEVEL9K_CUSTOM_VIRTUALENV_BACKGROUND='clear'
export VIRTUAL_ENV_DISABLE_PROMPT=


# custom_git_chain() {
#    git chain list --short | grep '^\*'
# }
# if is_installed git-chain; then
#   POWERLEVEL9K_CUSTOM_GIT_CHAIN="custom_git_chain"
#   POWERLEVEL9K_CUSTOM_GIT_CHAIN_BACKGROUND="clear"
#   POWERLEVEL9K_CUSTOM_GIT_CHAIN_FOREGROUND="008"
#   POWERLEVEL9K_CUSTOM_GIT_CHAIN_ICON=""
#   POWERLEVEL9K_CUSTOM_GIT_CHAIN_SEGMENT_ICON=""
# fi


custom_segment() {
  echo -e "%F{237}::%F{clear}"
}
POWERLEVEL9K_CUSTOM_SEGMENT="custom_segment"
POWERLEVEL9K_CUSTOM_SEGMENT_BACKGROUND="clear"
POWERLEVEL9K_CUSTOM_SEGMENT_FOREGROUND="237"
POWERLEVEL9K_CUSTOM_SEGMENT_ICON=""
POWERLEVEL9K_CUSTOM_SEGMENT_SEGMENT_ICON=""


custom_newline() {
  echo -e "\n%F{237}│%F{clear}"
}
POWERLEVEL9K_CUSTOM_NEWLINE="custom_newline"
POWERLEVEL9K_CUSTOM_NEWLINE_BACKGROUND="clear"
POWERLEVEL9K_CUSTOM_NEWLINE_FOREGROUND="008"
POWERLEVEL9K_CUSTOM_NEWLINE_ICON=""
POWERLEVEL9K_CUSTOM_NEWLINE_SEGMENT_ICON=""

custom_time() {
  local now
  now="$(date +%H:%M:%S)"
  echo -e "%F{008}$now"
}
POWERLEVEL9K_CUSTOM_TIME="custom_time"
POWERLEVEL9K_CUSTOM_TIME_BACKGROUND="clear"
POWERLEVEL9K_CUSTOM_TIME_FOREGROUND="008"
POWERLEVEL9K_CUSTOM_TIME_ICON=""
POWERLEVEL9K_CUSTOM_TIME_SEGMENT_ICON=""

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  custom_time
  custom_pyenv_joined
  # custom_node_joined
  # custom_virtualenv_joined
  custom_newline
  dir_joined
  custom_git_branch_joined
  # custom_pyenv_joined
)

# ╭─
# ╰─
# ┌─
# └─
# ┏━
# ┗━
# ╔═
# ╚═
# ▛▀
# ▙▄

POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{237}╭%F{clear}"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{237}╰%F{clear} "

typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=''

POWERLEVEL9K_DISABLE_RPROMPT=true
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()

icons=()
POWERLEVEL9K_MODE='nerdfont-complete'

typeset -g POWERLEVEL9K_VCS_{GIT,GITHUB,BITBUCKET}_ICON=""
POWERLEVEL9K_HIDE_BRANCH_ICON=true
POWERLEVEL9K_VCS_STAGED_ICON="\b"
POWERLEVEL9K_VCS_HIDE_TAGS=true
POWERLEVEL9K_VCS_SHOW_SUBMODULE_DIRTY=false
POWERLEVEL9K_VCS_UNSTAGED_ICON="\b"
POWERLEVEL9K_VCS_GIT_HOOKS=()
POWERLEVEL9K_SHOW_CHANGESET=false

POWERLEVEL9K_VIRTUALENV_PYTHON_ICON=
POWERLEVEL9K_VIRTUALENV_BACKGROUND='clear'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='008'

POWERLEVEL9K_HOST_FOREGROUND="grey"
POWERLEVEL9K_HOST_BACKGROUND="clear"
POWERLEVEL9K_HOST_ICON=""
POWERLEVEL9K_USER_ICON=""

POWERLEVEL9K_USER_BACKGROUND="clear"

POWERLEVEL9K_DIR_BACKGROUND='237'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="008"
POWERLEVEL9K_DIR_FOREGROUND='010'
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_FOREGROUND="012"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="012"

POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{008}/%F{cyan}"

POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''

POWERLEVEL9K_HOME_ICON=""
POWERLEVEL9K_HOME_SUB_ICON=""
POWERLEVEL9K_DIR_ETC_BACKGROUND="clear"
POWERLEVEL9K_ETC_ICON=""

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="red"
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="clear"

POWERLEVEL9K_GO_ICON="\uf7b7"
POWERLEVEL9K_GO_VERSION_BACKGROUND='clear'
POWERLEVEL9K_GO_VERSION_FOREGROUND='081'

POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%F{clear}\u0008'
# POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%F{008}\u2e2b%F{008}'
# POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="%F{237}〉%F{clear}"
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

POWERLEVEL9K_NVM_BACKGROUND='clear'
POWERLEVEL9K_NVM_FOREGROUND='green'

POWERLEVEL9K_OS_ICON_BACKGROUND='clear'
POWERLEVEL9K_OS_ICON_FOREGROUND='cyan'

POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true


typeset -g POWERLEVEL9K_STATUS_{,OK_,ERROR_}BACKGROUND="clear"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="001"
POWERLEVEL9K_CARRIAGE_RETURN_ICON="\uf071"

POWERLEVEL9K_TIME_FORMAT="%D{%H:%M \uE868  %d.%m}"

typeset -g POWERLEVEL9K_VCS_{CLEAN,MODIFIED,UNTRACKED}_BACKGROUND='clear'
typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED}_FOREGROUND='green'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
