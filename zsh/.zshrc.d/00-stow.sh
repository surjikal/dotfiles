# Stuff that you want to stow / re-stow on login
STOWED=(
    zsh
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

# Restow
export STOW_DIR="$DOTFILES"
for pkg in "${STOWED[@]}"; do stow -R "$pkg"; done
