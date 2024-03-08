#!/bin/bash

function ask_mount {
	read -p "What to mount? [P]ersonal, [T]eam, [A]ll, [Q]uit " type
	case $type in
	[Pp]*)
		echo "Mounting Personal"
		rclone mount OST-OneDrive: /home/luism/OST-OneDrive/personal/ --poll-interval 0m1s --vfs-cache-mode full --daemon
		;;
	[Tt]*)
		echo "Mounting Team"
		rclone mount OST-SharePoint: /home/luism/OST-OneDrive/TeamDejan --poll-interval 0m1s --ignore-checksum --ignore-size --vfs-cache-mode full --daemon
		;;
	[Aa]*)
		echo "Mounting both"
		rclone mount OST-SharePoint: /home/luism/OST-OneDrive/TeamDejan --poll-interval 0m1s --vfs-cache-mode full --ignore-checksum --ignore-size --daemon
		rclone mount OST-OneDrive: /home/luism/OST-OneDrive/personal --poll-interval 0m1s --vfs-cache-mode full --daemon
		exit
		;;
	[Qq]*) ;;
	*) echo "Not an option" ;;
	esac
}

function ask_umount {
	read -p "What to unmount? [P]ersonal, [T]eam, [A]ll, [Q]uit " type
	case $type in
	[Pp]*)
		echo "unmounting Personal"
		fusermount -u /home/luism/OST-OneDrive/personal
		;;
	[Tt]*)
		echo "unmounting Team"
		fusermount -u /home/luism/OST-OneDrive/TeamDejan
		;;
	[Aa]*)
		echo "unmounting all\n"
		fusermount -u /home/luism/OST-OneDrive/personal
		fusermount -u /home/luism/OST-OneDrive/TeamDejan
		exit
		;;
	[Qq]*) ;;
	*) echo "Not an option" ;;
	esac
}

while true; do
	read -p "[M]ount or [u]nmount?[Q]uit " mount_type
	case $mount_type in
	[Mm]*)
		echo "Mount selected"
		ask_mount
		;;
	[Uu]*)
		echo "Unmount selected"
		ask_umount
		;;
	[Qq]*)
		echo "Exiting"
		exit
		;;

	*) echo "Not an option" ;;
	esac
done
