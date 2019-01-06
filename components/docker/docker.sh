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



# Create systemd unit file and start docker-compose at bootup
sudo su -c " echo '[Unit]
Description=Server apps suite (docker-compose) Service
Requires=docker.service
After=docker.service

[Service]
WorkingDirectory=${docker_compose_dir}
ExecStart=$(which docker-compose) up
ExecStop=$(which docker-compose) down
TimeoutStartSec=0
Restart=on-failure
StartLimitInterval=60
StartLimitBurst=3

[Install]
WantedBy=multi-user.target
' > /etc/systemd/system/server-apps-suite.service"
