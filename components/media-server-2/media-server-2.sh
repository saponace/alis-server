#-------------------------------------------------
# Alternate media server
#-------------------------------------------------


declare -A pellyfin_docker_compose_template_mappings=(
  ["ALTERNATE_MEDIA_DIR"]=/mnt/media/alternate
)
process_docker_compose_service media-server-2/pellyfin "$(declare -p pellyfin_docker_compose_template_mappings)"
