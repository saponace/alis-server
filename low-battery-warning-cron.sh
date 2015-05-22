#!/bin/bash                                                          

# Battery level warning script only work with a two-batteries laptop

battery1_level=`acpi -b | grep -oP '[0-9]+(?=%)' | cut -d $'\n' -f1`
battery2_level=`acpi -b | grep -oP '[0-9]+(?=%)' | cut -d $'\n' -f2`
battery1_capacity=`acpi -V | grep -oP '[0-9]+(?= mAh,)' | cut -d $'\n' -f1`
battery2_capacity=`acpi -V | grep -oP '[0-9]+(?= mAh,)' | cut -d $'\n' -f2`

total_battery_level=$((($battery1_level * $battery1_capacity + $battery2_level * $battery2_capacity)/($battery1_capacity + $battery2_capacity)))

echo $total_battery_level'%'



if [[ $total_battery_level -le 25 && $total_battery_level -gt 5 ]]; then
    notify-send "Battery very low warning"  "
    Battery level is ${battery_level}%
    Use ac power now,
    or shutdown is imminent - close applications" --urgency=critical --expire-time=10000
elif [[ $total_battery_level -le 10 ]]; then
    # our custom actions for critical battery level
    notify-send "Battery critical warning"  "
    Battery level is ${battery_level}%
    Shutting system down now" --urgency=critical --expire-time=10000
fi
