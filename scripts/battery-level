#!/bin/bash                                                          

# Battery level warning script only work with a two-batteries laptop 
# Does only work for user whose personal directory is in /home/, and only works if there is only one user which personal directory is in /home/

battery1_level=`acpi -b | grep -oP '[0-9]+(?=%)' | cut -d $'\n' -f1`
battery2_level=`acpi -b | grep -oP '[0-9]+(?=%)' | cut -d $'\n' -f2`
battery1_capacity=`acpi -V | grep -oP '[0-9]+(?= mAh,)' | cut -d $'\n' -f1`
battery2_capacity=`acpi -V | grep -oP '[0-9]+(?= mAh,)' | cut -d $'\n' -f2`

total_battery_level=$((($battery1_level * $battery1_capacity + $battery2_level * $battery2_capacity)/($battery1_capacity + $battery2_capacity)))

is_ac_plugged_in=`acpi -a | grep "on-line" | wc -l`




users=`w -h | cut -d' ' -f1`
IFS=$' '
users_array=($(printf "%s\n" "${users[@]}" | sort -u | tr '\n' ' '))
unset IFS




low_level=10
very_low_level=6
critical_level=3







# Send a notification to the specified user
# @param $1 The user to whom the notification should be sent
# @param $2 The title of the notification
# @param $3 The text notification
# @param $4 The urgency of the notification. Can be low, normal or critical
send_notification(){
    sudo -u "$1" notify-send "$2" "$3" --urgency="$4" --expire-time=10000
}







for current_user in "${users_array[@]}"
do
    if [[ $is_ac_plugged_in -eq 0 ]]; then
        if [[ $total_battery_level -le $low_level && $total_battery_level -gt $very_low_level ]]; then
        send_notification "$current_user" "Low battery" "Battery level is ${total_battery_level}% (Which is low)" "normal"
            
        elif [[ $total_battery_level -le $very_low_level && $total_battery_level -gt $critical_level ]]; then
        send_notification $current_user "Critical battery level" "Battery level is ${total_battery_level}%.\nYou should really consider plugging an AC power source\nor shutting your system down now" "critical"

        elif [[ $total_battery_level -le $critical_level ]]; then
        send_notification $current_user "Suspending system now" "The system is currently hybrid-suspending\nGo plug an AC power source now\n(I know, it's hard to get off the couch)" "normal"
            pm-suspend-hybrid
        fi
    fi
done












echo -e $total_battery_level'%\n('$battery1_level'% of '$battery1_capacity'mAh and '$battery2_level'% of '$battery2_capacity'mAh)'
