#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Pictures/wallpapers/"

# Wait for hyprpaper to be ready (systemd managed)
echo "Waiting for hyprpaper to be ready..."
timeout=30
count=0
while ! pgrep -x hyprpaper >/dev/null && [ $count -lt $timeout ]; do
  sleep 1
  ((count++))
done

CURRENT_WALL=$(hyprctl hyprpaper listloaded)
echo -e "Current Wallpaper:\n $CURRENT_WALL"

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \) ! -name "$(basename "$CURRENT_WALL")" | shuf -n 1)

echo -e "New Wallpaper:\n $WALLPAPER"
# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"

ln -sf "$WALLPAPER" "$HOME/.config/current_wallpaper"
