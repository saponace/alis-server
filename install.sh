#!/bin/bash


# Get the current directory
# Leave this block of code at the very beginning of the script (some
# commands may change the current directory later in this script)
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null
    git_repo_dir_name=$(basename ${git_repo_path})


CONFIG_FILE_PATH="${git_repo_path}/alis-server.config"

if [ ! -f "${CONFIG_FILE_PATH}" ]
then
  echo "Error: config file ${CONFIG_FILE_PATH} not found. Please create this file and try again"
  exit 1
fi
source ${CONFIG_FILE_PATH}


boot_partition="${install_disk}1"
swap_partition="${install_disk}2"
root_partition="${install_disk}3"

chroot_script_to_call="install-core-after-chroot.sh"



# Create partition table
  # Delete existing partition table
    wipefs -a ${install_disk}
  # Create boot partition, then SWAP partition, then root partition
    fdisk_create_boot_partition="n\np\n1\n\n+${boot_partition_size}\nt\nef\n"
    fdisk_create_swap_partition="n\np\n2\n\n+${swap_partition_size}\nt\n2\n82\n"
    if [ "${root_partition_size}" == "MAX" ]
    then
      root_partition_end="\n"
    else
      root_partition_end="+${root_partition_size}\n"
    fi
    fdisk_create_root_partition="n\np\n3\n\n${root_partition_end}\nt\n2\n83\n"
    fdisk_set_bootable_partition_and_write_partition_table="a\n1\nw\n"

    echo -e "${fdisk_create_boot_partition}${fdisk_create_swap_partition}${fdisk_create_root_partition}" | fdisk ${install_disk}

# Format partitions
    mkfs.vfat -F 32 ${boot_partition}
    mkswap ${swap_partition}
    mkfs.ext4 ${root_partition}


# Mount partitions and swapon
    mount ${boot_partition} /mnt/boot
    swapon ${swap_partition}
    mount ${root_partition} /mnt


# Refresh pacman gpg keys list
    pacman-key --init
    pacman-key --refresh-key

# Install base components into new system
    pacstrap /mnt base base-devel

# Generate fstab of new system to automatically mount all the devices at bootup
    genfstab -U -p /mnt >> /mnt/etc/fstab


# Move the git repo into the /root of the new system
    mv ${git_repo_path} /mnt/root/


# Chroot into the new system
    arch-chroot /mnt /root/${git_repo_dir_name}/${chroot_script_to_call}
