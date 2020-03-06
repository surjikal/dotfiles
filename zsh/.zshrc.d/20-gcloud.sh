
export GCLOUD_HOME=/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk

[[ ! -d $GCLOUD_HOME ]] && exit

source "$GCLOUD_HOME/path.zsh.inc"
source "$GCLOUD_HOME/completion.zsh.inc"
