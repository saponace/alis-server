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
  # Create partition and filesystem for boot, SWAP, and root
    swap_end_position=$((${boot_partition_size}+${swap_partition_size}))
    if [ "${root_partition_size}" == "MAX" ]
    then
      root_end_position="100%"
    else
      root_end_position="$((${swap_end_position}+${root_partition_size}))M"
    fi
    # FIXME: parted does not add partitions after each other, but at a given position. Here for exemple, the swap
    # partition size will be ${swap_partition_size}-${boot_partition_size}
    parted ${install_disk} mklabel gpt
    parted --align optimal ${install_disk} unit mb mkpart primary fat32 0% ${boot_partition_size}
    parted ${install_disk} name 1 boot
    parted ${install_disk} set 1 boot on
    parted --align optimal ${install_disk} unit mb mkpart primary linux-swap $((${boot_partition_size}+1)) ${swap_end_position}
    parted ${install_disk} name 2 swap
    parted --align optimal ${install_disk} unit mb mkpart primary ext4 $((${swap_end_position}+1)) ${root_end_position}
    parted ${install_disk} name 3 root

  # Format partitions
    mkfs.vfat -F 32 ${boot_partition}
    mkswap ${swap_partition}
    mkfs.ext4 ${root_partition}


# Mount partitions and swapon
    swapon ${swap_partition}
    mount ${root_partition} /mnt
    mkdir /mnt/boot
    mount ${boot_partition} /mnt/boot


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
