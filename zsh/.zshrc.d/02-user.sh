
export DOCKER_BUILDKIT=1

# Unsure why this is needed...
export PATH="/usr/local/sbin:$PATH"

# Overrides
extend_path "/Applications/CrossOver.app/Contents/SharedSupport/CrossOver/bin"

is_installed ccat && alias cat="ccat"

if is_installed exa; then
    alias ll=""
    alias ls="exa"
    alias la="exa -lah"
fi

alias sshconf="nano $HOME/.ssh/config"

function serve {
    python -m SimpleHTTPServer $@
}

function routes {
    netstat -nr
}

function sum {
    xargs | tr \  + | bc
}

alias map="xargs -n1"
alias matrix="cmatrix"
alias untar="tar xf"

# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $@"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias path='echo -e ${PATH//:/\\n}'
alias week='date +%V'
alias now="date +'%Y-%m-%d %H:%M:%S %Z'"
