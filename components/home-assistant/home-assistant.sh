#-------------------------------------------------
# Home automation hub
#-------------------------------------------------


declare -A  docker_compose_template_mappings=(
)
process_docker_compose_service home-assistant/home-assistant "$(declare -p docker_compose_template_mappings)"
