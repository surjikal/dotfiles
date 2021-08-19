#!/usr/bin/env zsh
# shellcheck shell=bash
# shellcheck disable=SC2120

function __vpn_is_reachable() {
    local host="${1:-$VPN_TEST_HOST}"
    if [[ -z "$host" ]]; then
        true
        return
    fi
    ping -c1 -t1 "$host" >/dev/null 2>&1
    local ping_status=$?
    if [ "$ping_status" -ne 0 ]; then
        false
        return
    fi
    true
}

function __vpn_is_connected() {
    local vpn="${1:-$VPN_NAME}"
    local vpn_status
    vpn_status=$(networksetup -showpppoestatus "$vpn")
    [[ "$vpn_status" != "connected" ]] && return 1
    return 0
}

function __vpn_connect() {
    local vpn="$1"
    networksetup -connectpppoeservice "$vpn"
}

function vpn_active() {
    local vpn="${1:-$VPN_NAME}"
    __vpn_is_connected "$vpn" && __vpn_is_reachable
}

function vpn_start() {
    local vpn="${1:-$VPN_NAME}"
    local i=0
    __vpn_connect "$vpn"
    while [ $i -le 100 ]; do
        vpn_active "$vpn" && break
        sleep 0.42
        i=$((i + 1))
    done
}

function vpn_stop() {
    local vpn="${1:-$VPN_NAME}"
    networksetup -disconnectpppoeservice "$vpn"
}

function vpn_ssh_wrapper {
    vpn_active "$1" || vpn_start
    ssh "$@"
}

alias vs="vpn_start"
