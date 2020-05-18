#-------------------------------------------------
# Torrenting
#-------------------------------------------------

# Transmission: torrenting client
    declare -A  transmission_docker_compose_template_mappings=(
    )
    process_docker_compose_service torrenting/transmission "$(declare -p transmission_docker_compose_template_mappings)"

    # Create transmission configuration file
        sudo mkdir -p ${CONTAINERS_CONFIG_DIR}/transmission/
        sudo cp ${COMPONENTS_DIR}/torrenting/config/transmission/settings.json ${CONTAINERS_CONFIG_DIR}/transmission/


# Jackett: tracker proxy for sonarr and radarr
    declare -A  jackett_docker_compose_template_mappings=(
    )
    process_docker_compose_service torrenting/jackett "$(declare -p jackett_docker_compose_template_mappings)"

