#!/bin/bash

# Get current Bluetooth state: 0 = unblocked, 1 = blocked
state=$(rfkill list bluetooth | grep -i "Soft blocked" | awk '{print $3}')

if [ "$state" = "no" ]; then
    # Bluetooth is currently on, so turn it off
    rfkill block bluetooth
else
    # Bluetooth is currently off, so turn it on
    rfkill unblock bluetooth
fi
