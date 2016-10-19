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


# Set encryption on root partition and open encrypted partition
    echo "Encrypting root partition. Please enter passphrase when prompted."
    cryptsetup --verbose --cipher aes-xts-plain64 --key-size 512 --hash sha512 --iter-time 5000 luksFormat ${root_part}
    cryptsetup luksOpen ${root_part} root

# Format root partition
    mkfs.btrfs /dev/mapper/root


# Mount root and create Btrfs subvolumes
    mount /dev/mapper/root /mnt
    cd /mnt
    btrfs subvolume create ROOT
    cd
    umount /mnt
    mount -o noatime,space_cache,autodefrag,subvol=ROOT /dev/mapper/root /mnt
    cd /mnt
    btrfs subvolume create root
    btrfs subvolume create home
    btrfs subvolume create etc
    btrfs subvolume create mnt
    btrfs subvolume create opt
    btrfs subvolume create var
    btrfs subvolume create tmp
    # cd
    # umount /mnt
    # mount -o noatime,space_cache,subvol=ROOT ${root_part} /mnt
    # mkdir /mnt/{root,home,etc,mnt,opt,var,tmp}
    # mount -o noatime,space_cache,subvol=root ${root_part} /mnt/root
    # mount -o noatime,space_cache,subvol=home ${root_part} /mnt/home
    # mount -o noatime,space_cache,subvol=etc ${root_part} /mnt/etc
    # mount -o noatime,space_cache,subvol=mnt ${root_part} /mnt/mnt
    # mount -o noatime,space_cache,subvol=opt ${root_part} /mnt/opt
    # mount -o noatime,space_cache,subvol=var ${root_part} /mnt/var
    # mount -o noatime,space_cache,subvol=tmp ${root_part} /mnt/tmp

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
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null
    mv ${git_repo_path} /mnt/root


# Chroot into the new system
    arch-chroot /mnt /root/alis/install-core-after-chroot.sh ${hostname} ${username} ${swap_part} ${root_part}
