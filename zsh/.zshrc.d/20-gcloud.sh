#!/usr/bin/env zsh
# shellcheck shell=bash


export GCLOUD_HOME=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
[[ ! -d $GCLOUD_HOME ]] && return

# shellcheck source=/dev/null
source "$GCLOUD_HOME/path.zsh.inc"
# shellcheck source=/dev/null
source "$GCLOUD_HOME/completion.zsh.inc"

export CLOUDSDK_GSUTIL_PYTHON=${CLOUDSDK_GSUTIL_PYTHON:-$CLOUDSDK_PYTHON}
