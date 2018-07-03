#-------------------------------------------------
# Configure VPN
#-------------------------------------------------




# Building docker image
    docker build -t openvpn-client components/vpn/

# Create credentials file on host machine that will be passed to container
# TODO: choose location of vpn credentials file and change reference in docker-compose.yml
    # sudo su -c "echo \"${vpn_login}\n${vpn_password}\" > /vpn-credentials"
    # chmod 600 /vpn-credentials

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
    process_docker_compose_service vpn/vpn "$(declare -p docker_compose_template_mappings)"