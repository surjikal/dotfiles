#!/usr/bin/env zsh
# shellcheck shell=bash

GCLOUD_HOME="${GCLOUD_HOME:-/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk}"
[[ ! -d "$GCLOUD_HOME" ]] && return

CLOUDSDK_PYTHON_VERSION="3.8.12"
export CLOUDSDK_PYTHON="${PYENV_ROOT}/versions/${CLOUDSDK_PYTHON_VERSION}/bin/python"
export CLOUDSDK_GSUTIL_PYTHON="$CLOUDSDK_PYTHON"
export GCLOUD_HOME

[[ ! -f "$CLOUDSDK_PYTHON" ]] && echo "python not found for CLOUDSDK_PYTHON: $CLOUDSDK_PYTHON"

# shellcheck source=/dev/null
source "$GCLOUD_HOME/path.zsh.inc"

# shellcheck source=/dev/null
source "$GCLOUD_HOME/completion.zsh.inc"
