#-------------------------------------------------
# File browser with web interface ala Google drive
#-------------------------------------------------


# Create docker compose component
declare -A  docker_compose_template_mappings=(
)
process_docker_compose_service file-browser-web/filebrowser "$(declare -p docker_compose_template_mappings)"
