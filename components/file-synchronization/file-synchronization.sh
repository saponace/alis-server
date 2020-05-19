#-------------------------------------------------
# File synchronization server
# (actually peer2peer, so not technically a server)
#-------------------------------------------------


# Create files and direcetories needed by syncthing
syncthing_data_dir="${SERVICES_DATA_DIR}/syncthing/data"
sudo mkdir -p ${syncthing_data_dir}
sudo chown ${username}:${username} ${syncthing_data_dir}

# Create docker compose component
process_docker_compose_service file-synchronization/syncthing ""
