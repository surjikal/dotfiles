#!/usr/bin/env zsh

export GOPATH=$HOME/dev/go
export PATH=$PATH:$GOPATH/bin

mkdir -p $GOPATH/{bin,pkg,src}
