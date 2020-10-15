#!/usr/bin/env zsh
# shellcheck shell=bash


if not is_installed antibody; then
    warn "${fg[cyan]}antibody${fg[default]} not installed"
    return
fi
source <(antibody init)

# powerlevel10k
PL10K_INSTANT_PROMPT_SCRIPT="${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
if [[ -r "$PL10K_INSTANT_PROMPT_SCRIPT" ]]; then source "$PL10K_INSTANT_PROMPT_SCRIPT"; fi
antibody bundle romkatv/powerlevel10k

# oh-my-zsh
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
antibody bundle robbyrussell/oh-my-zsh

# history / fzf
is_installed fzf && antibody bundle robbyrussell/oh-my-zsh path:plugins/fzf

# misc
antibody bundle zsh-users/zsh-syntax-highlighting
antibody bundle robbyrussell/oh-my-zsh path:plugins/command-not-found
antibody bundle robbyrussell/oh-my-zsh path:plugins/node
antibody bundle robbyrussell/oh-my-zsh path:plugins/github
antibody bundle robbyrussell/oh-my-zsh path:plugins/httpie
antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
antibody bundle robbyrussell/oh-my-zsh path:plugins/brew
antibody bundle robbyrussell/oh-my-zsh path:plugins/aws
antibody bundle robbyrussell/oh-my-zsh path:plugins/gcloud
antibody bundle robbyrussell/oh-my-zsh path:plugins/pyenv

# terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# python
antibody bundle robbyrussell/oh-my-zsh path:plugins/pipenv

# node
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD=true
antibody bundle lukechilds/zsh-nvm
antibody bundle lukechilds/zsh-better-npm-completion

# ssh-agent
(   zstyle :omz:plugins:ssh-agent agent-forwarding on
    antibody bundle robbyrussell/oh-my-zsh path:plugins/ssh-agent
) > /dev/null

# gpg-agent
# antibody bundle robbyrussell/oh-my-zsh path:plugins/gpg-agent
