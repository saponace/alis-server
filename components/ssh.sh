#-------------------------------------------------
# Configure ssh settings
# Has to be called after user creation
#-------------------------------------------------

sshd_config_file="/etc/ssh/sshd_config"

# Install SSH client and daemon
    ${INSTALL} openssh


# Enable SSH daemon
    sudo systemctl enable sshd.service
# Quicker SSH login
    sudo echo 'UseDNS no' > ${sshd_config_file}
# Enable SSHFS
    sudo echo "Subsystem sftp /usr/lib/sftp-server" >> ${sshd_config_file}

# Security
    # Whitelist SSH port on the firewall
        sudo ufw allow 22
    # Disable ssh connection to root account
        sudo echo "PermitRootLogin no" >> ${sshd_config_file}
    # Disable authentication via password, require ssh key
        sudo echo "PasswordAuthentication no" >> ${sshd_config_file}

    # Add known_hosts file to user's ssh configuration
    if [ -f "${AUTHORIZED_KEYS_FILE}" ]
    then
        mkdir -p /home/${USERNAME}/.ssh/
        cp ${AUTHORIZED_KEYS_FILE} /home/${USERNAME}/.ssh/authorized_keys
        chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh
    else
        start_red_text="\e[00;31m"
        stop_red_text="\e[00m"
        echo -e "${start_red_text}"
        echo "Authorized_keys file \"${AUTHORIZED_KEYS_FILE}\" not found. You won't be able to connect via SSH"
        echo -e "${start_red_text}"
    fi




