#!/usr/bin/env zsh
# shellcheck shell=bash

if ! is_installed stow; then
    fatal "stow not installed"
    return
fi

export STOW_DIR="$DOTFILES"

# This is where the list of dirs to stow are specified
export STOWFILE="${STOWFILE:-$STOW_DIR/Stowfile}"

# Remove macOS turds, they can cause issues
# for f in **/.DS_STORE; do
#     # shellcheck disable=SC2154
#     echo "${fg[yellow]}removing turd:${fg[default]} $f";
#     rm "$f"
# done 2> /dev/null

# Restow
if [[ ! -f "$STOWFILE" ]]; then
    fatal "Stowfile not found at $STOWFILE" >&2
    return
fi

# Gitk just replaces the symlink with a file, we fix this here
# function fix_gitk() {
#     gitk="$HOME/.config/git/gitk"
#     if [ ! -L "$gitk" ]; then
#         mv "$gitk" "$DOTFILES/git/.config/git/gitk" || true
#     fi
# }

function restow() {
    setopt local_options no_monitor
    while read -r package; do
        [[ -z "$package" ]] && continue
        [[ $package = $'#'* ]] && continue
        # [[ "$package" == git ]] && fix_gitk
        # https://github.com/aspiers/stow/issues/65
        (stow -R "$package" 2>&1 | grep -v "BUG in find_stowed_path") &
    done <"$STOWFILE"
    wait
}

restow
