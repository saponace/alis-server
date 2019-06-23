#-------------------------------------------------
# Alternate media server
#-------------------------------------------------


declare -A pjellyfin_docker_compose_template_mappings=(
  ["ALTERNATE_MEDIA_DIR"]=/mnt/media/alternate
)
process_docker_compose_service media-server-2/pjellyfin "$(declare -p pjellyfin_docker_compose_template_mappings)"
