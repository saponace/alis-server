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



# Set the hostname
    echo  ${hostname} > /etc/hostname

# Set le locales and the keymap
    # Configure locales
        echo -e "\n${locales_to_enable}" >> /etc/locale.gen
        locale-gen
        ln -sf ${locale_zone_path} /etc/localtime
        echo "KEYMAP=${keymap}" > /etc/vconsole.conf


# Install sudo
    pacman -S --noconfirm sudo


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
    mv ${git_repo_path} /home/${username}/
    chown -R ${username}:${username} /home/${username}/

