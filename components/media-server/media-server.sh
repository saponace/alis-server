#-------------------------------------------------
# Media server
#-------------------------------------------------

# Media center
  process_docker_compose_service media-server/jellyfin ""

# Private media center
  declare -A pellyfin_docker_compose_template_mappings=(
    ["PRIVATE_MEDIA_DIR"]=/mnt/media/private
  )
  process_docker_compose_service media-server/pellyfin "$(declare -p pellyfin_docker_compose_template_mappings)"
