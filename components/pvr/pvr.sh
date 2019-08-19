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

# Youtube video archiver: daily download of all videos in the selected channels
    sudo mkdir -p ${CONTAINERS_DATA_DIR}/yt-dl-archive-channels/
    sudo touch ${CONTAINERS_DATA_DIR}/yt-dl-archive-channels/archive.txt
    sudo chown -R ${username}:${username} ${CONTAINERS_DATA_DIR}/yt-dl-archive-channels/

    sudo mkdir -p ${CONTAINERS_CONFIG_DIR}/yt-dl-archive-channels/
    sudo_create_link ${COMPONENTS_DIR}/pvr/config/yt-dl-archive-channels.conf ${CONTAINERS_CONFIG_DIR}/yt-dl-archive-channels/
    sudo chown -R ${username}:${username} ${CONTAINERS_CONFIG_DIR}/yt-dl-archive-channels/

    sudo mkdir -p /mnt/media/youtube-videos
    sudo chown -R ${username}:${username} /mnt/media/youtube-videos

    declare -A  yt_dl_archive_channels_compose_template_mappings=(
        ["DOWNLOADS_DIR"]=/mnt/media/youtube-videos
    )
    process_docker_compose_service pvr/yt-dl-archive-channels "$(declare -p yt_dl_archive_channels_compose_template_mappings)"
