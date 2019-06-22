#-------------------------------------------------
# Torrenting client
#-------------------------------------------------

declare -A  transmission_docker_compose_template_mappings=(
)
process_docker_compose_service torrenting-client/transmission "$(declare -p transmission_docker_compose_template_mappings)"


# Create transmission configuration file
    sudo mkdir -p ${CONTAINERS_CONFIG_DIR}/transmission/
    sudo cp ${COMPONENTS_DIR}/torrenting-client/config/settings.json ${CONTAINERS_CONFIG_DIR}/transmission/
