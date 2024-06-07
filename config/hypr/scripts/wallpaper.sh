#!/bin/bash

directory=~/Pictures/wallpapers
monitor=$(hyprctl monitors | grep Monitor | awk '{print $2}')

if [ -d "$directory" ]; then
	random_background=$(ls $directory/*.{jpg,png} | shuf -n 1)
	echo $random_background
	echo $monitor
	hyprctl hyprpaper unload all
	hyprctl hyprpaper preload $random_background
	for m in ''${monitor[@]}; do
		hyprctl hyprpaper wallpaper "$m, $random_background"
	done
fi
