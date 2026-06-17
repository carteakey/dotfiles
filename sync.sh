#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backups/$(date +%Y%m%d-%H%M%S)"
PULL=true
PUSH=true

for arg in "$@"; do
  case "$arg" in
    --no-pull) PULL=false ;;
    --no-push) PUSH=false ;;
    *) echo "Unknown argument: $arg" >&2; exit 2 ;;
  esac
done

link_file() {
  local src="$1"
  local dest="$2"

  mkdir -p "$(dirname "$dest")"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    return
  fi

  if [[ -e "$dest" || -L "$dest" ]]; then
    mkdir -p "$BACKUP_DIR/$(dirname "${dest#$HOME/}")"
    mv "$dest" "$BACKUP_DIR/${dest#$HOME/}"
  fi

  ln -s "$src" "$dest"
}

"$PULL" && git -C "$DOTFILES_DIR" pull --rebase --autostash

while IFS= read -r file; do
  [[ "$file" == ".gitignore" || "$file" == "bootstrap.sh" || "$file" == "sync.sh" || "$file" == scripts/* ]] && continue

  package="${file%%/*}"
  relative="${file#*/}"
  [[ "$package" == "$relative" ]] && continue

  link_file "$DOTFILES_DIR/$file" "$HOME/$relative"
done < <(git -C "$DOTFILES_DIR" ls-files)

if ! git -C "$DOTFILES_DIR" diff --quiet || ! git -C "$DOTFILES_DIR" diff --cached --quiet; then
  git -C "$DOTFILES_DIR" status --short
  echo "Dotfiles have local changes. Commit them before pushing."
  exit 1
fi

if "$PUSH"; then
  git -C "$DOTFILES_DIR" push
  echo "Dotfiles synced both ways."
else
  echo "Dotfiles applied locally."
fi
