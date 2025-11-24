#!/bin/bash

# Get the current volume as an integer (stripping '%' for calculation)
current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk -F'/' '{print $2}' | tr -d ' ' | sed 's/%//')

# Function to update the volume
update_volume() {
    # Get the volume action and percentage
    action=$1
    percentage=$2
   

    # Calculate the new volume based on the action
    if [[ "$action" == "up" ]]; then
        # Increase volume by the specified percentage
        new_volume=$(($current_volume + $percentage))
        
        # Ensure the volume doesn't exceed 100%
        if [ "$new_volume" -gt 100 ]; then
            new_volume=100
        fi

    elif [[ "$action" == "down" ]]; then
        # Decrease volume by the specified percentage
        new_volume=$(($current_volume - $percentage))
        
        # Ensure the volume doesn't go below 0%
        if [ "$new_volume" -lt 0 ]; then
            new_volume=0
        fi

    fi

    # Set the new volume
    pactl set-sink-volume @DEFAULT_SINK@ "$new_volume%"

    # Update the current volume after change
    current_volume=$new_volume
    notify_text="VOLUME $new_volume%"
    # Send a notification with the updated volume action and icon
    if [[ "$current_volume" == 0 ]]; then
        notify-send "MUTED" -i $HOME/.config/waybar/icons/volume-muted.svg -t 1000 -r 9999
    elif [[ "$current_volume" -lt 51 ]]; then
        notify-send "$notify_text" -i $HOME/.config/waybar/icons/volume-low.svg -t 1000 -r 9999
    elif [[ "$current_volume" -lt 100 ]]; then
        notify-send "$notify_text" -i $HOME/.config/waybar/icons/volume-medium.svg -t 1000 -r 9999
    else 
        notify-send "MAXED" -i $HOME/.config/waybar/icons/volume-high.svg -t 1000 -r 9999
   fi
}

# If no argument is passed, increase volume by 5%
if [[ -z "$1" ]]; then
    update_volume "up" 5
fi

# Action for increasing volume (if "up" argument passed)
if [[ "$1" == "up" ]]; then
    update_volume "up" 5
fi

# Action for decreasing volume (if "down" argument passed)
if [[ "$1" == "down" ]]; then
    update_volume "down" 5
fi