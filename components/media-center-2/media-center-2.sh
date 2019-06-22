#-------------------------------------------------
# Media center
#-------------------------------------------------


declare -A jellyfin_2_docker_compose_template_mappings=(
  ["ALTERNATE_MEDIA_DIR"]=/mnt/media/alternate
)
process_docker_compose_service media-center-2/jellyfin "$(declare -p jellyfin_2_docker_compose_template_mappings)"
