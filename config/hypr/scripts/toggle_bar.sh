#!/bin/bash
if [ "$(hyprctl getoption decoration:screen_shader | grep -o 'success')" ]; then
    # Currently hidden → show
    hyprctl keyword general:resize_on_border false
    killall -SIGUSR1 waybar
else
    # Currently shown → hide
    killall -SIGUSR1 waybar
fi