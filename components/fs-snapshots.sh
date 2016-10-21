#-------------------------------------------------
# Setup filesystem snapshots (Btrfs)
#-------------------------------------------------

# Btrfs snapshots manager
    ${INSTALL} snapper
# Call snapper before and after each pacman/yaourt call
    ${INSTALL} snap-pac

# Setup all the snapper configs (snapshots triggered every hour by default)
    sudo snapper -c root create-config /
    sudo snapper -c root-home create-config /root
    sudo snapper -c home create-config /home
    sudo snapper -c etc create-config /etc
    sudo snapper -c opt create-config /opt
