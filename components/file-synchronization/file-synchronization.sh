#-------------------------------------------------
# File synchronization server
# (actually peer2peer, so technically not a server)
#-------------------------------------------------


# Create configuration and sync folders
    sudo mkdir -p /mnt/misc-data/syncthing
    sudo chown ${username}:${username} /mnt/misc-data/syncthing

    sudo mkdir -p ${SERVICES_DATA_DIR}/syncthing
    sudo chown ${username}:${username} ${SERVICES_DATA_DIR}/syncthing


process_docker_compose_service file-synchronization/syncthing ""

# Create a dashboard entry
    add_dashboard_entry Syncthing syncthing Syncthing "Continuous File Synchronization" iframe "Misc apps / tools"
