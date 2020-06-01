#-------------------------------------------------
# Encrypted and versioned remote backups of the server
#-------------------------------------------------


process_docker_compose_service remote-backups/duplicati ""


# Create a dashboard entry
    add_dashboard_entry Duplicati duplicati duplicati "Admin interface for handling of encrypted and versioned remote
    backups of the server" iframe "Maintenance / monitoring"
