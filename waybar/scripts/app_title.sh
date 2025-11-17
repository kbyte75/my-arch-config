#!/usr/bin/env bash
# ~/.config/waybar/scripts/upperCaseClass.sh

# Get Hyprland socket
INSTANCE_SIG="${HYPRLAND_INSTANCE_SIGNATURE}"
[[ -z "$INSTANCE_SIG" ]] && { echo '{"text": "NO HYPR"}'; exit 1; }

SOCKET="/tmp/hypr/$INSTANCE_SIG/.socket2.sock"

# Function to get uppercase class
get_class() {
    class=$(hyprctl activewindow -j | jq -r '.class // "DESKTOP"')
    echo "$class" | tr '[:lower:]' '[:upper:]'
}

# Initial output (Waybar needs this)
echo "{\"text\": \"$(get_class)\"}"

# Open socket for events
exec 3<"$SOCKET"

# Listen for window changes
while IFS= read -r event <&3; do
    case "$event" in
        openwindow*|closewindow*|windowtitle*|focusedmon*)
            echo "{\"text\": \"$(get_class)\"}"
            ;;
    esac
done