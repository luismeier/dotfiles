#!/bin/bash

entries="⇠\tLogout\n⏾\tSuspend\n⭮\tReboot\n⏻\tShutdown"

selected=$(echo -e $entries | rofi -dmenu -i | awk '{print tolower($2)}')

case $selected in
logout)
  hyprctl dispatch exit && uwsm stop
  # hyprctl dispatch exit
  ;;
suspend)
  exec systemctl suspend
  ;;
reboot)
  exec systemctl reboot
  ;;
shutdown)
  exec systemctl poweroff
  ;;
esac
