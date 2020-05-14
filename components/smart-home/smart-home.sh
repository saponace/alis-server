#-------------------------------------------------
# Home automation hub
#-------------------------------------------------


declare -A  docker_compose_template_mappings=(
)
process_docker_compose_service smart-home/home-assistant "$(declare -p docker_compose_template_mappings)"
