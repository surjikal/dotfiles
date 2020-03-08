
export DOCKER_BUILDKIT=1

alias sshconf="nano $HOME/.ssh/config"

# Overrides
is_installed ccat && alias cat="ccat"

if is_installed exa; then
    alias ls="exa"
    alias la="exa -lah"
fi

# Utils
alias map="xargs -n1"

# Helpers
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $@"

alias matrix="cmatrix"
alias untar="tar xf"
