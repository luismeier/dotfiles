#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

link() {
    local src="$1"
    local dst="$2"

    if [[ -L "$dst" ]]; then
        rm "$dst"
    elif [[ -e "$dst" ]]; then
        echo "  SKIP $dst (exists, not a symlink — remove manually to link)"
        return
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "  $dst -> $src"
}

echo "Dotfiles: $DOTFILES_DIR"
echo ""

echo "[config]"
for src in "$DOTFILES_DIR/config"/*/; do
    link "$src" "$HOME/.config/$(basename "$src")"
done

echo ""
echo "[local/bin]"
for src in "$DOTFILES_DIR/local/bin"/*; do
    link "$src" "$HOME/.local/bin/$(basename "$src")"
done

echo ""
echo "[home]"
for src in "$DOTFILES_DIR/home"/.*; do
    name="$(basename "$src")"
    [[ "$name" == "." || "$name" == ".." ]] && continue
    link "$src" "$HOME/$name"
done

echo ""
echo "Done."
