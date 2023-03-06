#-------------------------------------------------
# Install core components, and configure core behaviours
#-------------------------------------------------


# Linux C headers, used by some programs
    install_package linux-headers
# Set locale and keyboard layout in the terminal and X
    sudo localectl set-keymap ${keymap}
# Disable terminal bell (actually totally disable internal speaker)
    sudo su -c "echo 'blacklist pcspkr' > /etc/modprobe.d/nobeep.conf"
# Network Time Protocl Daemon synchronization(synchronize time with internet)
    install_package ntp
    sudo systemctl enable ntpd.service
# Hard drives management
    install_package hdparm
# Hard drives management
    install_package btrfs-progs
