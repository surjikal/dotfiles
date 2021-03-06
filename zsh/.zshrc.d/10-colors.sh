#!/usr/bin/env zsh
# shellcheck shell=bash


not is_installed grc && return
[[ "$TERM" == dumb ]] && return

alias colourify="grc -es --colour=auto"
alias ls='exa'
# alias diff='colourify diff'
alias as='colourify as'
alias blkid='colourify blkid'
alias df='colourify df'
alias dig='colourify dig'
alias docker-machine='colourify docker-machine'
alias docker='colourify docker'
alias du='colourify du'
alias env='colourify env'
alias fdisk='colourify fdisk'
alias findmnt='colourify findmnt'
alias free='colourify free'
alias g++='colourify g++'
alias gas='colourify gas'
alias gcc='colourify gcc'
alias getsebool='colourify getsebool'
alias head='colourify head'
alias id='colourify id'
alias ifconfig='colourify ifconfig'
alias ip='colourify ip'
alias iptables='colourify iptables'
alias ld='colourify ld'
alias lsblk='colourify lsblk'
alias lsof='colourify lsof'
alias lspci='colourify lspci'
alias make='colourify make'
alias mount='colourify mount'
alias mtr='colourify mtr'
alias netstat='colourify netstat'
alias ping='colourify ping'
alias ps='colourify ps'
alias semanage='colourify semanage'
alias tail='colourify tail'
alias traceroute='colourify traceroute'
alias traceroute6='colourify traceroute6'
