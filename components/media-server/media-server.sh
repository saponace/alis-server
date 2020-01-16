#-------------------------------------------------
# Media server
#-------------------------------------------------


declare -A jellyfin_docker_compose_template_mappings=(
)
process_docker_compose_service media-server/jellyfin "$(declare -p jellyfin_docker_compose_template_mappings)"

declare -A ombi_docker_compose_template_mappings=(
)
process_docker_compose_service media-server/ombi "$(declare -p ombi_docker_compose_template_mappings)"
