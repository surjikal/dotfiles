#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck disable=SC1090

# Disable oh my zsh update check if running in vscode terminal
if [[ "$TERM_PROGRAM" == vscode ]]; then
    export DISABLE_AUTO_UPDATE=1
fi

if not is_installed antibody; then
    # shellcheck disable=SC2154
    warn "${fg[cyan]}antibody${fg[default]} not installed"
    return
fi
source <(antibody init)

# powerlevel10k
# shellcheck disable=SC2296
PL10K_INSTANT_PROMPT_SCRIPT="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
[[ -r "$PL10K_INSTANT_PROMPT_SCRIPT" ]] && source "$PL10K_INSTANT_PROMPT_SCRIPT"
antibody bundle romkatv/powerlevel10k

# oh-my-zsh
ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-ohmyzsh-SLASH-ohmyzsh"
export ZSH
antibody bundle ohmyzsh/ohmyzsh

# history / fzf
is_installed atuin && antibody bundle ellie/atuin
is_installed fzf   && antibody bundle ohmyzsh/ohmyzsh path:plugins/fzf

# quiet direnv...
export DIRENV_LOG_FORMAT=
antibody bundle ptavares/zsh-direnv

# misc
antibody bundle TamCore/autoupdate-oh-my-zsh-plugins
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle ohmyzsh/ohmyzsh path:plugins/command-not-found
antibody bundle ohmyzsh/ohmyzsh path:plugins/github
# antibody bundle ohmyzsh/ohmyzsh path:plugins/httpie
antibody bundle ohmyzsh/ohmyzsh path:plugins/brew

# devops
# antibody bundle ohmyzsh/ohmyzsh path:plugins/kubectl
antibody bundle ohmyzsh/ohmyzsh path:plugins/aws
antibody bundle ohmyzsh/ohmyzsh path:plugins/gcloud
antibody bundle ohmyzsh/ohmyzsh path:plugins/docker
is_installed tfenv && antibody bundle cda0/zsh-tfenv
# antibody bundle jsporna/terraform-zsh-plugin
# antibody bundle robbyrussell/oh-my-zsh path:plugins/terraform

# node
# antibody bundle ohmyzsh/ohmyzsh path:plugins/node
antibody bundle ohmyzsh/ohmyzsh path:plugins/yarn
antibody bundle lukechilds/zsh-better-npm-completion
# antibody bundle favware/zsh-lerna
antibody bundle cowboyd/zsh-volta

export NVM_COMPLETION=true
export NVM_AUTO_USE=false
export NVM_LAZY_LOAD=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=(lerna coffee ts-node tsc yarn jest ts-jest)
export NVM_NO_USE=true
antibody bundle lukechilds/zsh-nvm

# python
# antibody bundle "MichaelAquilina/zsh-autoswitch-virtualenv"

# AUTOSWITCH_MESSAGE_FORMAT="$(tput setaf 1)Switching to %venv_name 🐍 %py_version $(tput sgr0)"
AUTOSWITCH_MESSAGE_FORMAT=""
export AUTOSWITCH_MESSAGE_FORMAT
# antibody bundle ohmyzsh/ohmyzsh path:plugins/pyenv
# antibody bundle ohmyzsh/ohmyzsh path:plugins/poetry

# ruby
antibody bundle ohmyzsh/ohmyzsh path:plugins/ruby
antibody bundle ohmyzsh/ohmyzsh path:plugins/rbenv

# ssh-agent
(   zstyle :omz:plugins:ssh-agent agent-forwarding on
    antibody bundle ohmyzsh/ohmyzsh path:plugins/ssh-agent
    eval "$(ssh-agent -s)"
) &>/dev/null

# gpg-agent
# antibody bundle robbyrussell/oh-my-zsh path:plugins/gpg-agent
