#!/usr/bin/env zsh
# shellcheck shell=bash

export PATH="/usr/local/sbin:${PATH}" # Unsure why this is needed...
export PATH="${DOTFILES}/bin:${PATH}"
export PATH="${HOME}/bin:${PATH}"

# privary stuff...
export SHOPIFY_CLI_NO_ANALYTICS=1

# is_installed ccat && alias cat="ccat"
is_installed icdiff && alias diff="icdiff"

# Show open ports
function ports {
    netstat -anvp tcp | awk 'NR<3 || /LISTEN/'
}

# Create volume using RAM
function ramdisk {
    # If it already exists, then cd to it
    [ -d /Volumes/ramdisk ] && cd /Volumes/ramdisk && return 0
    # Otherwise create it
    local size_in_mb=${1:-8192}
    local blocksize=$((size_in_mb * 2048))

    # diskutil erasevolume HFS+ 'RAM Disk' $(hdiutil attach -nomount ram://${blocksize})
    # diskutil partitionDisk "$(hdiutil attach -nomount ram://${blocksize})" 1 GPTFormat APFS 'ramdisk' '100%'
}

function cdram {
    ramdisk "$@"
    cd /Volumes/ramdisk || exit 1
}

# OSX Notification Popup
function notify {
    osascript -e "display notification \"$*\""
}

# HTTP Server
function serve {
    local port=${1:-$(random_port)}
    # Using macOS python to avoid annoying security popup
    /usr/bin/python -m SimpleHTTPServer "$port" &
    open "http://localhost:$port"
    fg
}

# Get a random open port:
# https://unix.stackexchange.com/a/132524
function random_port {
    /usr/bin/python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()'
}

function routes {
    netstat -nr
}

function route-add {
    sudo route -n add -net "$@"
}

function flushdns {
    sudo killall -HUP mDNSResponder
}

# Random

function sum {
    xargs | tr \  + | bc
}

function tojson {
    dsq "$1" | jq --sort-keys -c '.[]'
}

function screenshot {
    echo
    neofetch
    sleep 15
}

alias map="xargs -n1"
alias untar="tar xf"
alias matrix="cmatrix"

# https://github.com/mathiasbynens/dotfiles/blob/master/.aliases
alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $@"
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias path='echo -e ${PATH//:/\\n}'
alias week='date +%V'
alias now_unix="date +'%s'"
alias now="date +'%Y-%m-%d %H:%M:%S %Z'"

function screenshots {
    open "$HOME"/Screenshots
}

function openai-audio {
    local prompt="${*}"
    curl https://api.openai.com/v1/audio/speech \
        -s \
        -H "Authorization: Bearer ${OPENAI_API_KEY}" \
        -H "Content-Type: application/json" \
        -d "$(node -p 'JSON.stringify({model: "tts-1", input: process.argv[1], voice: "alloy"})' "${prompt}")"
}

function openai-say {
    local tmpfile=$(mktemp /tmp/abc-script.XXXXXX)
    openai-audio "${@}" > "${tmpfile}"
    echo "playing: ${tmpfile}" >&2
    ffplay -autoexit -nodisp -hide_banner -loglevel error -i "${tmpfile}"
}

function openai-gen {
    local prompt="${*}"
    curl https://api.openai.com/v1/chat/completions \
        -s \
        -H "Authorization: Bearer ${OPENAI_API_KEY}" \
        -H "Content-Type: application/json" \
        -d "$(node -p 'JSON.stringify({model: "gpt-3.5-turbo", messages:[{"role":"user", "content":process.argv[1]}]})' "${prompt}")" \
    | jq -r '.choices[0].message.content'
}

function openai-gen-say {
    local result
    result=$(openai-gen "${@}")
    echo "" >&2
    echo "${result}" >&2
    openai-say "${result}"
}
