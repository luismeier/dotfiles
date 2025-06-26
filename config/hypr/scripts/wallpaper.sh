#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded)

echo -e "$CURRENT_WALL"
# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)
echo -e "$WALLPAPER"
# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"

ln -sf "$WALLPAPER" "$HOME/.config/current_wallpaper"
