#-------------------------------------------------
# Configure Docker
#-------------------------------------------------


# Portainer: Docker containers management via Web UI
    process_docker_compose_service docker/portainer ""


# Watchtower: Auto-update docker containers
    declare -A  watchtower_docker_compose_template_mappings=(
       ["GOTIFY_WATCHTOWER_API_TOKEN"]="${gotify_watchtower_api_token}"
    )
    process_docker_compose_service docker/watchtower "$(declare -p watchtower_docker_compose_template_mappings)"


# Create a dashboard entry for Portainer
   add_dashboard_entry "Portainer admin interface" portainer portainer "Docker admin dashboard" iframe Maintenance
