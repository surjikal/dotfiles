#!/usr/bin/env zsh
# shellcheck shell=bash

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
if [[ -f "$STOWFILE" ]]; then
    while read -r package; do
        [[ -z "$package" ]] && continue

        # Gitk just replaces the symlink with a file, we fix that here before restow
        if [[ "$package" == git ]]; then
            gitk="$HOME/.config/git/gitk"
            if [ ! -L "$gitk" ]; then
                mv "$gitk" "$DOTFILES/git/.config/git/gitk" || true
            fi
        fi

        stow -R "$package"

    done < "$STOWFILE"
fi
