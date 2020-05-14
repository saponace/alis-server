#-------------------------------------------------
# Configure Docker
#-------------------------------------------------

# Append a line to the docker_compose file
# $1: The string
function append_to_docker_compose_file (){
   echo "$1" >> ${docker_compose_file}
}


sudo mkdir -p ${DOCKER_SHARED_DIR}
${INSTALL} docker docker-compose
sudo systemctl enable docker

docker_compose_version=3.8


# Portainer: Docker containers management via Web UI
    declare -A  portainer_docker_compose_template_mappings=(
    )
    process_docker_compose_service docker/portainer "$(declare -p portainer_docker_compose_template_mappings)"


# Watchtower: Auto-update docker containers
    declare -A  watchtower_docker_compose_template_mappings=(
       ["GOTIFY_WATCHTOWER_API_TOKEN"]="${gotify_watchtower_api_token}"
    )
    process_docker_compose_service docker/watchtower "$(declare -p watchtower_docker_compose_template_mappings)"





# Merge all docker-compose parts into final docker-compose.yml
    docker_compose_dir="/opt/server-apps-suite"
    docker_compose_file="${docker_compose_dir}/docker-compose.yml"
    sudo mkdir -p ${docker_compose_dir}
    sudo chown ${username}:${username} ${docker_compose_dir}


    add_docker_network "  default:
    driver: bridge"

    # Make sure destination compose file is empty
    : > ${docker_compose_file}

    append_to_docker_compose_file "version: \"${docker_compose_version}\""
    append_to_docker_compose_file ""

    if [ -f ${TEMP_DOCKER_PART_NETWORKS} ]; then
       append_to_docker_compose_file "networks:"
       cat ${TEMP_DOCKER_PART_NETWORKS} >> ${docker_compose_file}
       append_to_docker_compose_file ""
    fi

   if [ -f ${TEMP_DOCKER_PART_VOLUMES} ]; then
      append_to_docker_compose_file "volumes:"
      cat ${TEMP_DOCKER_PART_VOLUMES} >> ${docker_compose_file}
      append_to_docker_compose_file ""
   fi

    if [ -f ${TEMP_DOCKER_PART_SECRETS} ]; then
       append_to_docker_compose_file "secrets:"
       cat ${TEMP_DOCKER_PART_SECRETS} >> ${docker_compose_file}
       append_to_docker_compose_file ""
    fi

    append_to_docker_compose_file "services:"
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

