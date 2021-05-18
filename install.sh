#!/bin/bash
var_path="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

printf "Creating symlinks:\n"

printf "i3:\t"
if [ -d "/home/$USER/.config/i3" ]; then
	printf "Directory already exits. Skipping\n"
else
	ln -s $var_path/i3 /home/$USER/.config/
	printf "Symlink created!\n"
fi

printf "i3Blocks:\t"
if [ -d "/home/$USER/.config/i3blocks" ]; then
	printf "Directory already exits. Skipping\n"
else
	ln -s $var_path/i3blocks /home/$USER/.config/
	printf "Symlink created!\n"
fi

printf "Nano:\t"
if [ -d "/home/$USER/.config/nano" ]; then
	printf "Directory already exits. Skipping\n"
else
	ln -s $var_path/nano /home/$USER/.config/
	printf "Symlink created!\n"
fi

printf "Dunst:\t"
if [ -d "/home/$USER/.config/dunst" ]; then
	printf "Directory already exits. Skipping\n"
else
	ln -s $var_path/dunst /home/$USER/.config/
	printf "Symlink created!\n"
fi

printf "Alacritty:\t"
if [ -d "/home/$USER/.config/alacritty" ]; then
	printf "Directory already exits. Skipping\n"
else
	ln -s $var_path/alacritty /home/$USER/.config/
	printf "Symlink created!\n"
fi

printf "Rofi:\t"
if [ -d "/home/$USER/.config/rofi" ]; then
	printf "Directory already exits. Skipping\n"
else
	ln -s $var_path/rofi /home/$USER/.config/
	printf "Symlink created!\n"
fi
