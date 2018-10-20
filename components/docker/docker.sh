#-------------------------------------------------
# Configure Docker
#-------------------------------------------------

sudo mkdir -p ${DOCKER_SHARED_DIR}
${INSTALL} docker docker-compose
sudo systemctl enable docker


# Docker-proxy-ACL: Access layer for docker.sock (used by netdata)
    declare -A  docker_proxy_acl_docker_compose_template_mappings=(
   )
    process_docker_compose_service docker/docker-proxy-acl "$(declare -p docker_proxy_acl_docker_compose_template_mappings)"

# Watchtower: Watch containers for new versions and seamlessly update
    declare -A  watchtower_docker_compose_template_mappings=(
    )
    process_docker_compose_service docker/watchtower "$(declare -p watchtower_docker_compose_template_mappings)"

# Portainer: Docker containers management via Web UI
    declare -A  portainer_docker_compose_template_mappings=(
    )
    process_docker_compose_service docker/portainer "$(declare -p portainer_docker_compose_template_mappings)"


# Merge all docker-compose parts into final docker-compose.yml
   mkdir -p /opt
   docker_compose_file="/opt/docker-compose.yml"

   cat components/docker/base.yml >> ${docker_compose_file}
   sudo chown ${username}:${username} ${docker_compose_file}

   for part in ${TEMP_DOCKER_COMPOSE_PARTS_DIR}/*; do
      cat ${part} >> ${docker_compose_file}
   done

