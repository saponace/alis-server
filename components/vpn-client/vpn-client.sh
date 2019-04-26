#-------------------------------------------------
# Configure VPN
#-------------------------------------------------


# Build docker-compose definition
    declare -A  docker_compose_template_mappings=(
    )
    process_docker_compose_service vpn-client/pia-client "$(declare -p docker_compose_template_mappings)"
