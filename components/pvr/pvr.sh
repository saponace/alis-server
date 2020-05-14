#-------------------------------------------------
# Personal video recording
#-------------------------------------------------

# Ombi: PVR frontend
    declare -A ombi_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/ombi "$(declare -p ombi_docker_compose_template_mappings)"

# Sonarr: automated TV shows download
    declare -A  sonarr_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/sonarr "$(declare -p sonarr_docker_compose_template_mappings)"

# Radarr: automated movies download
    declare -A  radarr_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/radarr "$(declare -p radarr_docker_compose_template_mappings)"

# Bazarr: automated TV and movies subtitles download
    declare -A  bazarr_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/bazarr "$(declare -p bazarr_docker_compose_template_mappings)"

# Lidarr: automated music download
# I know, music is not video (as in PVR), but I thought it fits well here
    declare -A  lidarr_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/lidarr "$(declare -p lidarr_docker_compose_template_mappings)"

# Jackett: tracker proxy for sonarr and radarr
    declare -A  jackett_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/jackett "$(declare -p jackett_docker_compose_template_mappings)"

# Youtube-dl: Download Youtube videos/channels/playlists (can extract audio)
    declare -A  youtube_dl_compose_template_mappings=(
    )
    process_docker_compose_service pvr/youtube-dl "$(declare -p youtube_dl_compose_template_mappings)"
