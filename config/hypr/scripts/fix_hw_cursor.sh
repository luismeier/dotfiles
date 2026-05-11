#!/bin/bash

current_value=$(hyprctl getoption cursor:no_hardware_cursors -j | jq -r '.int')

# Disaple it temporarily
hyprctl keyword cursor:no_hardware_cursors 0
sleep 1s
# Reaply old value
hyprctl keyword cursor:no_hardware_cursors "$current_value"
