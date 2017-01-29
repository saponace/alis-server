#-------------------------------------------------
# Configure ssh settings
# Has to be called after user creation
#-------------------------------------------------

sshd_config_file="/etc/ssh/sshd_config"


# Add a configuration to the file /etc/ssh/sshd_config
# $1: The configuration to add
function add_sshd_config(){
    sudo su -c "echo $1 >> ${sshd_config_file}"
}



# Install SSH client and daemon
    ${INSTALL} openssh

# Enable SSH daemon
    sudo systemctl enable sshd.service

# Initialize sshd_config file
    sudo su -c "echo '' > ${sshd_config_file}"
# Quicker SSH login
    add_sshd_config "UseDNS no"
# Enable SSHFS
    add_sshd_config "Subsystem sftp /usr/lib/sftp-server"

# Security
    # Whitelist SSH port on the firewall
        sudo ufw allow 22
    # Disable ssh connection to root account
        add_sshd_config "PermitRootLogin no"
    # Disable authentication via password, require ssh key
        add_sshd_config "PasswordAuthentication no"

    # Add known_hosts file to user's ssh configuration
    if [ -f "${AUTHORIZED_KEYS_FILE}" ]
    then
        mkdir -p /home/${USER}/.ssh/
        cp ${AUTHORIZED_KEYS_FILE} /home/${USER}/.ssh/authorized_keys
        chown -R ${USER}:${USER} /home/${USER}/.ssh
    else
        start_red_text="\e[00;31m"
        stop_red_text="\e[00m"
        echo -e "${start_red_text}"
        echo "Authorized_keys file \"${AUTHORIZED_KEYS_FILE}\" not found. You won't be able to connect via SSH"
        echo -e "${start_red_text}"
    fi




