
export DOCKER_BUILDKIT=1

# Silence some OSX warning about TK being deprecated
export TK_SILENCE_DEPRECATION=1
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"

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


function notify {
    local msg="\"$@\""
    osascript -e "display notification $msg"
}


# Get a random open port:
# https://unix.stackexchange.com/a/132524
function random_port {
    /usr/bin/python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()'
}

function serve {
    local port=${1:-`random_port`}
    # Using macOS python to avoid annoying security popup
    /usr/bin/python -m SimpleHTTPServer $port &
    open "http://localhost:$port"
    fg
}

function routes {
    netstat -nr
}

function sum {
    xargs | tr \  + | bc
}

function ramdisk {
    local size_in_mb=${1:-4096}
    local blocksize=$(( size_in_mb * 2048 ))
    diskutil partitionDisk $(hdiutil attach -nomount ram://${blocksize}) 1 GPTFormat APFS 'ramdisk' '100%'
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
