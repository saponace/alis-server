#-------------------------------------------------
# Configure centralized logging
#-------------------------------------------------



# Elastic stack
    source ${COMPONENTS_DIR}/logging/elastic-stack/install-elastic-stack.sh

# Dozzle: web interface to get docker containers logs
    process_docker_compose_service logging/dozzle ""
    # Create a dashboard entry
        add_dashboard_entry Dozzle dozzle dozzle "View docker containers logs in real time" iframe "Maintenance / monitoring"
