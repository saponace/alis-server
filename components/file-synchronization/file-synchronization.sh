#-------------------------------------------------
# File synchronization server
# (actually peer2peer, so technically not a server)
#-------------------------------------------------


process_docker_compose_service file-synchronization/syncthing ""


# Create a dashboard entry
    add_dashboard_entry Syncthing syncthing Syncthing "Continuous File Synchronization" iframe Misc
