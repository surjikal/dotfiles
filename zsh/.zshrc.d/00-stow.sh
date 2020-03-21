# Stuff that you want to stow / re-stow on login
STOWED=(
    zsh
    git
    vscode
    spectacle
    neofetch
    nano
)

# Remove macOS turds, they can cause issues
for f in `find "$DOTFILES" -name ".DS_Store"`; do
    echo ${fg[yellow]}removing turd:${fg[default]} $f;
    rm "$f"
done

# Gitk just replaces the symlink with a file, so we fix that here
gitk=$HOME/.config/git/gitk
if [ ! -L $gitk ]; then
    mv $gitk $DOTFILES/git/.config/git/gitk || true
fi

# Restow
export STOW_DIR="$DOTFILES"
for pkg in "${STOWED[@]}"; do stow -R "$pkg"; done
