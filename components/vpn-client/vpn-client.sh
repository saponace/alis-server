#-------------------------------------------------
# Configure VPN
#-------------------------------------------------




# Building docker image
    docker build -t openvpn-client components/vpn-client/

# Create credentials file on host machine that will be passed to container
    sudo su -c "echo \"${vpn_login}\n${vpn_password}\" > /pia-credentials"
    sudo chmod 600 /pia-credentials

# Build docker-compose definition
    source components/pvr/variables.sh
    source components/torrent-client/variables.sh
    declare -A  docker_compose_template_mappings=(
        ["TRANSMISSION_PORT_INTERNAL"]="${TORRENT_CLIENT_PORT_INTERNAL}"
        ["TRANSMISSION_PORT_EXTERNAL"]="${TORRENT_CLIENT_PORT_EXTERNAL}"
        ["SONARR_PORT_INTERNAL"]="${SONARR_PORT_INTERNAL}"
        ["SONARR_PORT_EXTERNAL"]="${SONARR_PORT_EXTERNAL}"
        ["RADARR_PORT_INTERNAL"]="${RADARR_PORT_INTERNAL}"
        ["RADARR_PORT_EXTERNAL"]="${RADARR_PORT_EXTERNAL}"
        ["JACKETT_PORT_INTERNAL"]="${JACKETT_PORT_INTERNAL}"
        ["JACKETT_PORT_EXTERNAL"]="${JACKETT_PORT_EXTERNAL}"
    )
    process_docker_compose_service vpn-client/pia-client "$(declare -p docker_compose_template_mappings)"
