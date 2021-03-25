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

printf "Nano:\t"
if [ -d "/home/$USER/.config/nano" ]; then
	printf "Directory already exits. Skipping\n"
else
	ln -s $var_path/nano /home/$USER/.config/
	printf "Symlink created!\n"
fi


# printf "Setting bashrc: \n"
