# Stuff that will be re-stowed
STOWED=(
    zsh
    vscode
    spectacle
    neofetch
    nano
)
export STOW_DIR="$DOTFILES"
for pkg in "${STOWED[@]}"; do stow -R "$pkg"; done
