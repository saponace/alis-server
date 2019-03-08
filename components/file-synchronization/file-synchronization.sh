#-------------------------------------------------
# File synchronization server
# (actually peer2peer, so not technically a server)
#-------------------------------------------------


# Create files and direcetories needed by pihole
syncthing_data_dir="${CONTAINERS_DATA_DIR}/syncthing"
sudo mkdir ${pihole_home}
sudo chown ${username}:${username} ${syncthing_data_dir}

# Create docker compose component
declare -A  docker_compose_template_mappings=(
    ["DATA_DIR"]=${syncthing_data_dir}
)
process_docker_compose_service file-synchronization/syncthing "$(declare -p docker_compose_template_mappings)"
