#-------------------------------------------------
# File browser with web interface ala Google drive
#-------------------------------------------------


# Create docker compose component
declare -A  docker_compose_template_mappings=(
)
process_docker_compose_service file-browser-web/filebrowser "$(declare -p docker_compose_template_mappings)"

# Create and empty file to prevent docker from creating a directory instead
    sudo mkdir -p ${CONTAINERS_DATA_DIR}/filebrowser
    sudo touch ${CONTAINERS_DATA_DIR}/filebrowser/database.db
