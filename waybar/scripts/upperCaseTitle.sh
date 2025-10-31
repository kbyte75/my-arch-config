#!/bin/bash

# Get the active window class name
window_class=$(hyprctl activewindow | grep 'class' | awk '{print $NF}')

# Convert to uppercase
window_class_upper=$(echo "$window_class" | tr '[:lower:]' '[:upper:]')

# Output as JSON for Waybar
# Note: "text" is the key Waybar expects for display
echo $window_class_upper
