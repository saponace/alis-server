#-------------------------------------------------
# Media center
#-------------------------------------------------


declare -A plex_docker_compose_template_mappings=(
)
process_docker_compose_service media-center/plex "$(declare -p plex_docker_compose_template_mappings)"

declare -A emby_docker_compose_template_mappings=(
)
process_docker_compose_service media-center/emby "$(declare -p emby_docker_compose_template_mappings)"

declare -A ombi_docker_compose_template_mappings=(
)
process_docker_compose_service media-center/ombi "$(declare -p ombi_docker_compose_template_mappings)"

declare -A tautulli_docker_compose_template_mappings=(
)
process_docker_compose_service media-center/tautulli "$(declare -p tautulli_docker_compose_template_mappings)"
