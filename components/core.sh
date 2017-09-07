#-------------------------------------------------
# Install core components, and configure core behaviours
#-------------------------------------------------


# Linux C headers, used by some programs
    ${INSTALL} linux-headers
# Set locale and keyboard layout in the terminal and X
    sudo localectl set-keymap ${keymap}
# Disable terminal bell (actually totally disable internal speaker)
    sudo su -c "echo 'blacklist pcspkr' > /etc/modprobe.d/nobeep.conf"
# Network Time Protocl Daemon synchronization(synchronize time with internet)
    ${INSTALL} ntp
    sudo systemctl enable ntpd.service
# Hard drives management
    ${INSTALL} hdparm

# RAM and swap
    # Set RAM split (allocate 256MB of RAM to the GPU)
        sudo sed -i 's/gpu_mem=.*/gpu_mem=256/g' /boot/config.txt
    # Zswap and swap (can do zram too)
        ${INSTALL} systemd-swap
        sudo systemctl enable systemd-swap
        create_link "${ADDITIONAL_CONFIG_FILES_DIR}/other/systemd-swap/1.conf" "/etc/systemd/swap.conf.d/"
