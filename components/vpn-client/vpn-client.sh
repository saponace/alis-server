#-------------------------------------------------
# Configure VPN
#-------------------------------------------------


# Build docker-compose definition
    process_docker_compose_service vpn-client/pia-client ""

# Create credentials file on host machine that will be passed to container
    sudo su -c "echo \"${vpn_login}\n${vpn_password}\" > /pia-credentials"
    sudo chmod 600 /pia-credentials
