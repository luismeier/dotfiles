#!/bin/bash

# Set wallpaper directory and get monitor names as an array.
directory="$HOME/Pictures/wallpapers"
readarray -t monitors < <(hyprctl monitors | awk '/Monitor/ {print $2}')

# Check if the directory exists.
if [ ! -d "$directory" ]; then
  echo "Directory $directory does not exist."
  exit 1
fi

# Find all jpg, jpeg, and png files (case insensitive) in the directory.
mapfile -t wallpapers < <(find "$directory" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' \))

# Exit if no wallpapers are found.
if [ ${#wallpapers[@]} -eq 0 ]; then
  echo "No wallpapers found in $directory"
  exit 1
fi

# Pick a random wallpaper.
# random_background="${wallpapers[RANDOM % ${#wallpapers[@]}]}"
random_background=$(printf "%s\n" "${wallpapers[@]}" | shuf -n 1)

echo "Selected wallpaper: $random_background"
echo "Monitors: ${monitors[*]}"

# Update symlink for the current wallpaper.
ln -sf "$random_background" "$HOME/.config/current_wallpaper"

echo -n 'Unloading old wallpaper: '
hyprctl hyprpaper unload all

echo -n 'Preloading new wallpaper: '
hyprctl hyprpaper preload "$random_background"

# Loop through each monitor and set the wallpaper.
for m in "${monitors[@]}"; do
  echo -n "Setting wallpaper for monitor $m: "
  hyprctl hyprpaper wallpaper "$m, $random_background"
done
