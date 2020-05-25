#-------------------------------------------------
# Bookmarks manager
#-------------------------------------------------


# Copy config file
    mkdir -p ${SERVICES_GENERATED_CONFIG_DIR}/dashmachine
    cp ${COMPONENTS_DIR}/dashboard/config/config.ini ${SERVICES_GENERATED_CONFIG_DIR}/dashmachine/config.ini

# Docker compose service
process_docker_compose_service dashboard/dashmachine ""
