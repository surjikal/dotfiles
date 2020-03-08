#!/usr/bin/env zsh

if not is_installed antibody; then
    warn "${fg[cyan]}antibody${fg[default]} not installed"
    return
fi

source <(antibody init)

# powerlevel10k
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
antibody bundle romkatv/powerlevel10k

# oh-my-zsh
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
antibody bundle robbyrussell/oh-my-zsh

# completions
antibody bundle robbyrussell/oh-my-zsh path:plugins/github
antibody bundle robbyrussell/oh-my-zsh path:plugins/gitfast
antibody bundle robbyrussell/oh-my-zsh path:plugins/httpie

is_installed docker && antibody bundle robbyrussell/oh-my-zsh path:plugins/docker
is_installed brew   && antibody bundle robbyrussell/oh-my-zsh path:plugins/brew

# history / fzf
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
export HIST_IGNORE_ALL_DUPS=1
is_installed fzf && antibody bundle robbyrussell/oh-my-zsh path:plugins/fzf

# misc
antibody bundle robbyrussell/oh-my-zsh path:plugins/command-not-found
antibody bundle zsh-users/zsh-syntax-highlighting

# python
antibody bundle robbyrussell/oh-my-zsh path:plugins/pipenv

# node
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD=true
antibody bundle lukechilds/zsh-nvm

# ssh-agent
(   zstyle :omz:plugins:ssh-agent agent-forwarding on
    antibody bundle robbyrussell/oh-my-zsh path:plugins/ssh-agent
) > /dev/null
