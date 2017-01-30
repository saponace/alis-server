#-------------------------------------------------
# Setup filesystem snapshots (Btrfs)
#-------------------------------------------------

# Btrfs snapshots manager
    ${INSTALL} snapper


# Setup all the snapper configs (snapshots triggered every hour by default)
    sudo snapper -c root create-config /
    sudo snapper -c root-home create-config /root
    sudo snapper -c home create-config /home
    sudo snapper -c etc create-config /etc
    sudo snapper -c opt create-config /opt


    # Call snapper before and after each pacman/yaourt call
        ${INSTALL} snap-pac


# Reduce number of kept snapshots and increase cleanup
# frequency from all cleanup files
    for config_file in /etc/snapper/configs/*
    do
        sudo sed -i 's/NUMBER_LIMIT=".."/NUMBER_LIMIT="20"/' ${config_file}
    done


# Prevent a directory from being snapshotted if it is in a
# subvolume that is snapshotted with snapper.
# This function creates a Btrfs subvolume from a directory
# Directory may already exist, so we need to make sure
# it is renamed if it exists before creating the subvolume
# $1: The directory to convert to a subvolume
    function create_subvolume_from_dir () {
        dir=$1
        if [ -f "$dir" ]
        then
            owner_of_dir=$(ls -ld ${dir} | awk '{print $3}')
            group_of_dir=$(ls -ld ${dir} | awk '{print $4}')
            mv "${dir}" "${dir}_tmp"
            sudo btrfs subvolume create "${dir}"
            sudo chown -R ${owner_of_dir}:${group_of_dir} "${dir}"
            mv "${dir}_tmp"/{*,.*} "${dir}"
            rmdir "${dir}_tmp"
        else
            sudo btrfs subvolume create "${dir}"
        fi
    }

    create_subvolume_from_dir /home/${username}/.cache
