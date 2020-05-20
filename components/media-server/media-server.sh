#-------------------------------------------------
# Media server
#-------------------------------------------------

jellyfin_version="10.5.5"

# Media center
declare -A jellyfin_docker_compose_template_mappings=(
  ["VERSION"]=${jellyfin_version}
)
  process_docker_compose_service media-server/jellyfin "$(declare -p jellyfin_docker_compose_template_mappings)"

# Private media center
  declare -A pellyfin_docker_compose_template_mappings=(
    ["VERSION"]=${jellyfin_version}
    ["PRIVATE_MEDIA_DIR"]=/mnt/media/private
  )
  process_docker_compose_service media-server/pellyfin "$(declare -p pellyfin_docker_compose_template_mappings)"
