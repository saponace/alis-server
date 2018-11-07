#-------------------------------------------------
# Personal video recording
#-------------------------------------------------

# Sonarr: automated TV shows download
    declare -A  sonarr_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/sonarr "$(declare -p sonarr_docker_compose_template_mappings)"

# Radarr: automated movies download
    declare -A  radarr_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/radarr "$(declare -p radarr_docker_compose_template_mappings)"

# Lidarr: automated music download
# I know, music is not video (as in PVR), but I thought it fits well here
    declare -A  lidarr_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/lidarr "$(declare -p lidarr_docker_compose_template_mappings)"

# Jackett: tracker proxy for sonarr and radarr
    declare -A  jackett_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/jackett "$(declare -p jackett_docker_compose_template_mappings)"
