#!/bin/bash

hostname=$1
username=$2
boot_part=$3
swap_part=$4
root_part=$5



# Format boot partition
    mkfs.vfat -F 32 ${boot_part}
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

# Mount boot partition
    mkdir /mnt/boot
    mount ${boot_part} /mnt/boot
# Enable swap
    swapon ${swap_part}


# Install base components into new system
    pacstrap /mnt base base-devel btrfs-progs

# Generate fstab of new system to automatically mount all the devices at bootup
    genfstab -U -p /mnt >> /mnt/etc/fstab


# Move the git repo into the /root of the new system
    git_repo_path=/root/alis-server
    mv ${git_repo_path} /mnt/root/


# Chroot into the new system
    arch-chroot /mnt /root/alis/install-core-after-chroot.sh ${hostname} ${username} ${swap_part} ${root_part}
