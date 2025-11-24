#!/bin/bash
# ~/.config/waybar/scripts/brightness.sh

CACHE="/tmp/current-brightness"
[[ -f "$CACHE" ]] && current=$(cat "$CACHE") || current=50
step=5
icon="$HOME/.config/waybar/icons/brightness.svg"

case $1 in
    up)
        new=$((current + step))
        [[ $new -gt 100 ]] && new=100
        ;;
    down)
        new=$((current - step))
        [[ $new -lt 0 ]] && new=0
        ;;
    *) exit 1 ;;
esac

# Apply instantly
ddcutil setvcp 10 $new --bus 0 --noverify --async & >/dev/null 2>&1 &

# Cache new value
echo $new > "$CACHE"

# Super fast OSD
killall -q notify-osd 2>/dev/null  # optional: kill old ones
notify-send "BRIGHTNESS $new%" -i "$icon" -t 800 -r 9998 -u low &

exit 0