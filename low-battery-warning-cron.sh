#!/bin/bash                                                          

# Battery level warning script

battery_level=`acpi -b | grep -oP '[0-9]+(?=%)'`

if [[ $battery_level -le 25 && $battery_level -gt 5 ]]; then
    notify-send "Battery very low warning"  "
    Battery level is ${battery_level}%
    Use ac power now,
    or shutdown is imminent - close applications" --urgency=critical --expire-time=10000
elif [[ $battery_level -le 10 ]]; then
    # our custom actions for critical battery level
    notify-send "Battery critical warning"  "
    Battery level is ${battery_level}%
    Shutting system down now" --urgency=critical --expire-time=10000
fi
