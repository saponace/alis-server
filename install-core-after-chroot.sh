#!/bin/bash


# Get the current directory
# Leave this block of code at the very beginning of the script (some
# commands may change the current directory later in this script)
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null


CONFIG_FILE_PATH="${git_repo_path}/alis-server.config"

if [ ! -f "${CONFIG_FILE_PATH}" ]
then
    echo "Error: config file ${CONFIG_FILE_PATH} not found. Please create this file and try again"
    exit 1
fi
source ${CONFIG_FILE_PATH}


root_partition="${install_disk}3"

# Set the hostname
    echo  ${hostname} > /etc/hostname

# COnfigure locales and keymap
        echo -e "\n${locales_to_enable}" >> /etc/locale.gen
        locale-gen
        locale_zone_path="/usr/share/zoneinfo/${timezone}"
        ln -sf ${locale_zone_path} /etc/localtime
        if [ -n keymap ]
        then
            echo "KEYMAP=${keymap}" > /etc/vconsole.conf
        fi

# Set the clock
    hwclock --systohc --localtime


# Create ramdisk
    mkinitcpio -p linux


# Install and configure boot loader
    # mount boot partition to /boot
        bootctl --path=/boot install
    # Create menu entry
        echo -e "timeout=3\ndefault=arch" > /boot/loader/loader.conf
    # Configure entry
    root_partition_uuid=$(blkid ${root_partition} | cut -f2 -d\")
        echo -e "title  arch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img" > /boot/loader/entries/arch.conf
        echo -e "options root=UUID=${root_partition_uuid} rw" >> /boot/loader/entries/arch.conf


# Set root password
    echo "root:${root_pwd}" | chpasswd


# Create the user and add him to wheel group (sudoers)
    useradd -m -G wheel -s /bin/bash ${username}
    sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
    # Set user password
        echo "${username}:${user_pwd}" | chpasswd


# Move the git repo into the user's home directory
    mv ${git_repo_path} /home/${username}
    chown -R ${username}:${username} /home/${username}/

