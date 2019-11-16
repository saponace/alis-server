#-------------------------------------------------
# Configure Docker
#-------------------------------------------------

sudo mkdir -p ${DOCKER_SHARED_DIR}
${INSTALL} docker docker-compose
sudo systemctl enable docker



# Portainer: Docker containers management via Web UI
    declare -A  portainer_docker_compose_template_mappings=(
    )
    process_docker_compose_service docker/portainer "$(declare -p portainer_docker_compose_template_mappings)"



# Merge all docker-compose parts into final docker-compose.yml
   mkdir -p /opt
   docker_compose_dir="/opt/server-apps-suite"
   docker_compose_file="${docker_compose_dir}/docker-compose.yml"
   sudo mkdir ${docker_compose_dir}
   sudo chown ${username}:${username} ${docker_compose_dir}

   cat components/docker/base.yml > ${docker_compose_file}
   for part in ${TEMP_DOCKER_COMPOSE_PARTS_DIR}/*; do
      cat ${part} >> ${docker_compose_file}
   done

# Pull docker images
   sudo systemctl start docker
   sudo su -c "cd ${docker_compose_dir}; docker-compose pull"



# Create systemd unit file and start docker-compose at bootup
   input_service_file=${COMPONENTS_DIR}/docker/server-apps-suite.service
   temp_output_service_file=/tmp/server-apps-suite.service
   output_service_file=/etc/systemd/system/server-apps-suite.service

   declare -A  service_mappings=(
      ["DOCKER_COMPOSE_BIN_PATH"]="$(which docker-compose)"
      ["DOCKER_COMPOSE_DIR"]="${docker_compose_dir}"
   )

   fill_template_file ${input_service_file} ${temp_output_service_file} "$(declare -p service_mappings)"
   sudo mv ${temp_output_service_file} ${output_service_file}
