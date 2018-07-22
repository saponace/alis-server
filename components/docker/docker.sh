#-------------------------------------------------
# Configure Docker
#-------------------------------------------------

mkdir -p ${DOCKER_SHARED_DIR}
${INSTALL} docker docker-compose
sudo systemctl enable docker


# Watchtower: Watch containers for new versions and seamlessly update
    declare -A  watchtower_docker_compose_template_mappings=(
    )
    process_docker_compose_service docker/watchtower "$(declare -p watchtower_docker_compose_template_mappings)"

# Portainer: Docker containers management via Web UI
    declare -A  portainer_docker_compose_template_mappings=(
    )
    process_docker_compose_service docker/portainer "$(declare -p portainer_docker_compose_template_mappings)"


docker_compose_file="/tmp/docker-compose.yml"

cat components/docker/base.yml >> ${docker_compose_file}

for part in ${TEMP_DOCKER_COMPOSE_PARTS_DIR}/*; do
    cat ${part} >> ${docker_compose_file}
done

