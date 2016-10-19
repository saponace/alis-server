#!/bin/bash

hostname=$1
username=$2
swap_part=$3
root_part=$4



# Set the hostname
    echo  ${hostname} > /etc/hostname

# Set le locales and the keymap
    # Configure locales
        echo -e "\nfr_FR.UTF-8 UTF-8\nfr_FR ISO-8859-1\nfr_FR@euro ISO-8859-15\n" >> /etc/locale.gen
        echo -e "en_US.UTF-8 UTF-8\nen_US ISO-8859-1" >> /etc/locale.gen
        locale-gen
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime
    echo "KEYMAP=fr-latin1.map.gz" > /etc/vconsole.conf

# Set the clock
    hwclock --systohc --localtime


# Create ramdisk
    # Configure mkinitcpio
    sed -i 's/^BINARIES=""/BINARIES="\/usr\/bin\/btrfsck"/' /etc/mkinitcpio.conf
    sed -i 's/^HOOKS=".*"/HOOKS="base udev resume autodetect mdconf block encrypt filesystems keyboard keymap image btrfs"/' /etc/mkinitcpio.conf
    mkinitcpio -p linux


# Install and configure boot manager
    pacman -S efibootmgr
    # mount ${uefi_part} /boot
        bootctl --path=/boot install
    # Create menu entry
        echo -e "timeout=3\ndefault=arch" > /boot/loader/loader.conf
    # Configure entry
        root_part_uuid=$(blkid ${root_part} | cut -f2 -d\")
        swap_part_uuid=$(blkid ${swap_part} | cut -f2 -d\")
        echo -e "title  arch\nlinux /vmlinuz-linux\ninitrd /initramfs-linux.img\n" > /boot/loader/entries/arch.conf
        # TODO: Check that mess
        echo -e "options cryptdevice=UUID=${root_part_uuid}:root root=/dev/mapper/root rootflags=subvol=ROOT resume=UUID=${swap_part_uuid} quiet rw" >> /boot/loader/entries/arch.conf


# Set root password
    echo Enter root password:
    passwd root


# Create the user and add him to wheel group (sudoers)
    useradd -m -G wheel -s /bin/bash ${username}
    sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g" /etc/sudoers
    # Set user password
        echo Enter ${username} password:
        passwd ${username}


# Move the git repo into the user's home directory
    pushd `dirname $0` > /dev/null
    git_repo_path=`pwd`
    popd > /dev/null
    mv ${git_repo_path} /home/${username}
    chown -R ${username}:${username} /home/${username}/

