#!/bin/bash
# bootstrap.sh - Install dotfiles using GNU Stow
# Usage: ./bootstrap.sh [package...]
# With no args, installs all packages.

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES=(bash fish git ghostty zellij zed alacritty gh claude)

if ! command -v stow &>/dev/null; then
    echo "GNU Stow not found. Install it first:"
    echo "  Arch:   sudo pacman -S stow"
    echo "  Debian: sudo apt install stow"
    echo "  Brew:   brew install stow"
    exit 1
fi

TARGET="${@:-${PACKAGES[*]}}"

cd "$DOTFILES_DIR"

for pkg in $TARGET; do
    echo "Stowing $pkg..."
    stow --restow --target="$HOME" "$pkg"
done

echo ""
echo "Done! Dotfiles linked."
