#-------------------------------------------------
# Torrenting
#-------------------------------------------------

# Transmission: torrenting client
    process_docker_compose_service torrenting/transmission ""

    # Create transmission configuration file
        sudo mkdir -p ${CONTAINERS_CONFIG_DIR}/transmission/
        sudo cp ${COMPONENTS_DIR}/torrenting/config/transmission/settings.json ${CONTAINERS_CONFIG_DIR}/transmission/


# Jackett: tracker proxy for sonarr and radarr
    process_docker_compose_service torrenting/jackett ""
