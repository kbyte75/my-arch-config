#!/bin/bash
if pgrep -x rofi > /dev/null; then
    pkill rofi
else
    rofi -show drun -themes ~/.config/rofi/config.rasi
fi