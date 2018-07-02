#-------------------------------------------------
# Configure VPN
#-------------------------------------------------




# Building docker image
    docker build -t openvpn-client components/vpn/

# Create credentials file on host machine that will be passed to container
    # sudo su -c "echo \"${vpn_login}\n${vpn_password}\" > /vpn-credentials"
    # chmod 600 /vpn-credentials

# Build docker-compose definition
    source components/pvr/variables.sh
    source components/torrent-client/variables.sh
    declare -A  docker_compose_template_mappings=(
        ["TRANSMISSION_PORT"]="${TORRENT_CLIENT_PORT}"
        ["SONARR_PORT"]="${SONARR_PORT}"
        ["RADARR_PORT"]="${RADARR_PORT}"
        ["JACKETT_PORT"]="${JACKETT_PORT}"
    )
    process_docker_compose_service vpn/vpn "$(declare -p docker_compose_template_mappings)"
