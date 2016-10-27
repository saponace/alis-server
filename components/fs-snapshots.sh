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

# Prevent /home/${USER}/.cache from being snapshotted
# Directory may already exist, so we need to make sure
# it is renamed if it exists before creating the subvolume
    mv /home/${USER}/.cache /home/${USER}/.cache_tmp
    sudo btrfs subvolume create /home/${USER}/.cache
    sudo chown -R ${USER}:${USER} /home/${USER}/.cache
    mv /home/${USER}/.cache_tmp{*,.*} /home/${USER}/.cache/
    rmdir /home/${USER}/.cache_tmp
