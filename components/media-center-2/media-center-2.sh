#-------------------------------------------------
# Media center
#-------------------------------------------------


declare -A plex_docker_compose_template_mappings=(
)
process_docker_compose_service media-center-2/plex "$(declare -p plex_docker_compose_template_mappings)"

declare -A emby_docker_compose_template_mappings=(
)
process_docker_compose_service media-center-2/emby "$(declare -p emby_docker_compose_template_mappings)"

declare -A ombi_docker_compose_template_mappings=(
)
process_docker_compose_service media-center-2/ombi "$(declare -p ombi_docker_compose_template_mappings)"

declare -A tautulli_docker_compose_template_mappings=(
)
process_docker_compose_service media-center-2/tautulli "$(declare -p tautulli_docker_compose_template_mappings)"
