#-------------------------------------------------
# Configure VPN
#-------------------------------------------------


# Building docker image
    docker build -t openvpn-client components/vpn-client/docker-build

# Create credentials file on host machine that will be passed to container
    sudo su -c "echo \"${vpn_login}\n${vpn_password}\" > /pia-credentials"
    sudo chmod 600 /pia-credentials

# Build docker-compose definition
    declare -A  docker_compose_template_mappings=(
    )
    process_docker_compose_service vpn-client/pia-client "$(declare -p docker_compose_template_mappings)"
