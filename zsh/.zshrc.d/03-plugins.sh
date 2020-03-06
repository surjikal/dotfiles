#!/usr/bin/env zsh

if not is_installed antibody; then
    warn "install $fg[cyan]antibody$fg[default] to enable theming"
    exit
fi

source <(antibody init)
export ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
alias plugins="$EDITOR $DOTFILES/zsh/.zshrc.d/`basename $0`; reload"


PLUGINS=(
    "romkatv/powerlevel10k"
    "robbyrussell/oh-my-zsh"
    "robbyrussell/oh-my-zsh path:plugins/fzf"
    "robbyrussell/oh-my-zsh path:plugins/osx"
    "robbyrussell/oh-my-zsh path:plugins/brew"
    "robbyrussell/oh-my-zsh path:plugins/docker"
    "robbyrussell/oh-my-zsh path:plugins/git"
    "robbyrussell/oh-my-zsh path:plugins/github"
    "robbyrussell/oh-my-zsh path:plugins/pipenv"
    "robbyrussell/oh-my-zsh path:plugins/redis-cli"
    "robbyrussell/oh-my-zsh path:plugins/command-not-found"
    "zsh-users/zsh-syntax-highlighting"
    "supercrabtree/k"
)
for plugin in "${PLUGINS[@]}"; do antibody bundle "$plugin"; done

# NVM
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD=true
antibody bundle lukechilds/zsh-nvm

# ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding on
antibody bundle robbyrussell/oh-my-zsh path:plugins/ssh-agent
