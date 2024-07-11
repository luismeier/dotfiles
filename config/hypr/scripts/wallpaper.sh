#!/bin/bash

directory=~/Pictures/wallpapers
monitor=$(hyprctl monitors | grep Monitor | awk '{print $2}')

if [ -d "$directory" ]; then
  random_background=$(ls $directory/*.{jpg,png} | shuf -n 1)
  echo $random_background
  echo $monitor
  echo -n 'unloading old: '
  hyprctl hyprpaper unload all
  echo -n 'loading new: '
  hyprctl hyprpaper preload $random_background
  for m in ''${monitor[@]}; do
    echo -n "setting $m: "
    hyprctl hyprpaper wallpaper "$m, $random_background"
  done
fi
