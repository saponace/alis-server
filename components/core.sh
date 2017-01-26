#-------------------------------------------------
# Install core components, and configure core behaviours
#-------------------------------------------------


# Linux C headers, used by some programs
    ${INSTALL} linux-headers
# Set locale and keyboard layout in the terminal and X
    sudo localectl set-keymap fr-latin9
# Disable terminal bell (actually totally disable internal speaker)
    su -c "echo 'blacklist pcspkr' > /etc/modprobe.d/nobeep.conf"
# Network Time Protocl Daemon synchronization(synchronize time with internet)
    ${INSTALL} ntp
    sudo systemctl enable ntpd.service
