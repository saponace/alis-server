#!/bin/bash


CONFIG_FILE_PATH="./alis-server.config"

if [ ! -f "${CONFIG_FILE_PATH}" ]
then
  echo "Error: config file ${CONFIG_FILE_PATH} not found. Please create this file and try again"
  exit 1
fi
source ${CONFIG_FILE_PATH}


root_partition="${root_device}${root_partition_suffix}"
chroot_script_to_call="install-core-after-chroot.sh"


# Get the current directory
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null
    git_repo_dir_name=$(basename ${git_repo_path})


# Format swap partition
    mkswap ${swap_partition}


# Format root partition
    mkfs.btrfs ${root_partition}


# Mount root and create Btrfs subvolumes
    mount ${root_partition} /mnt
    cd /mnt
    btrfs subvolume create ROOT
    cd
    umount /mnt
    mount -o noatime,space_cache,autodefrag,subvol=ROOT ${root_partition} /mnt
    cd /mnt
    btrfs subvolume create root
    btrfs subvolume create home
    btrfs subvolume create etc
    btrfs subvolume create mnt
    btrfs subvolume create opt
    btrfs subvolume create var
    btrfs subvolume create tmp

# Enable swap
    swapon ${swap_partition}


# Refresh pacman gpg keys list
    pacman-key --refresh-key

# Install base components into new system
    pacstrap /mnt base base-devel btrfs-progs

# Generate fstab of new system to automatically mount all the devices at bootup
    genfstab -U -p /mnt >> /mnt/etc/fstab


# Move the git repo into the /root of the new system
    mv ${git_repo_path} /mnt/root/


# Chroot into the new system
    arch-chroot /mnt /root/${git_repo_dir_name}/${chroot_script_to_call}
