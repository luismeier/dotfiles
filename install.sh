#!/bin/bash
var_path=$PWD


printf "Creating symlinks\n"
printf "Kitty:\t"
if [ -d "/home/$USER/.config/kitty" ]; then
	printf "Directory already exits. Skipping\n"
else
	ln -s $var_path/kitty /home/$USER/.config/
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

# printf "Picom:\t"
# if [ -d "/home/$USER/.config/picom.conf" ]; then
# 	printf "Directory already exits. Skipping\n"
# else
# 	ln -s $var_path/picom.conf /home/$USER/.config/
# 	printf "Symlink created!\n"
# fi

printf "Rofi:\t"
if [ -d "/home/$USER/.config/rofi" ]; then
	printf "Directory already exits. Skipping\n"
else
	ln -s $var_path/rofi /home/$USER/.config/
	printf "Symlink created!\n"
fi
