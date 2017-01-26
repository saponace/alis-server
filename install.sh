#!/bin/bash

hostname=$1
username=$2
disk_device=$3
swap_part_nb=$4
root_part_nb=$5

swap_part="${disk_device}${swap_part_nb}"
root_part="${disk_device}${root_part_nb}"
chroot_script_to_call="install-core-after-chroot.sh"


# Get the current directory
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null
    git_repo_dir_name=$(basename ${git_repo_path})


# Format swap partition
    mkswap ${swap_part}


# Format root partition
    mkfs.btrfs ${root_part}


# Mount root and create Btrfs subvolumes
    mount ${root_part} /mnt
    cd /mnt
    btrfs subvolume create ROOT
    cd
    umount /mnt
    mount -o noatime,space_cache,autodefrag,subvol=ROOT ${root_part} /mnt
    cd /mnt
    btrfs subvolume create root
    btrfs subvolume create home
    btrfs subvolume create etc
    btrfs subvolume create mnt
    btrfs subvolume create opt
    btrfs subvolume create var
    btrfs subvolume create tmp

# Enable swap
    swapon ${swap_part}


# Refresh pacman gpg keys list
    pacman-key --refresh-key

# Install base components into new system
    pacstrap /mnt base base-devel btrfs-progs

# Generate fstab of new system to automatically mount all the devices at bootup
    genfstab -U -p /mnt >> /mnt/etc/fstab


# Move the git repo into the /root of the new system
    mv ${git_repo_path} /mnt/root/


# Chroot into the new system
    arch-chroot /mnt /root/${git_repo_dir_name}/${chroot_script_to_call} ${hostname} ${username} ${disk_device}
