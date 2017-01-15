#-------------------------------------------------
# Configure ssh settings
# Has to be called after user creation
#-------------------------------------------------


# Quicker ssh login
    echo 'UseDNS no' > /etc/ssh/sshd_config
# Enable SSHFS
    echo "Subsystem sftp /usr/lib/sftp-server" >> /etc/ssh/sshd_config

# Security
    # Whitelist SSH port on the firewall
        ufw allow 22
    # Disable ssh connection to root account
        echo "PermitRootLogin no" >> /etc/ssh/sshd_config
    # Disable authentication via password, require ssh key
        echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
    # Add known_hosts file to user's ssh configuration
        mkdir -p /home/${USERNAME}/.ssh/
        cp ${AUTHORIZED_KEYS_FILE} /home/${USERNAME}/.ssh/authorized_keys
        chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.ssh




