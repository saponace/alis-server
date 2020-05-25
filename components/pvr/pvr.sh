#-------------------------------------------------
# Personal video recording
#-------------------------------------------------

# Ombi: PVR frontend
    process_docker_compose_service pvr/ombi ""

# Sonarr: automated TV shows download
    process_docker_compose_service pvr/sonarr ""

# Radarr: automated movies download
    process_docker_compose_service pvr/radarr ""

# Bazarr: automated TV and movies subtitles download
    process_docker_compose_service pvr/bazarr ""

# Lidarr: automated music download
# I know, music is not video (as in PVR), but I thought it fits well here
    process_docker_compose_service pvr/lidarr ""

# Youtube-dl: Download Youtube videos/channels/playlists (can extract audio)
    process_docker_compose_service pvr/youtube-dl ""


# Create a dashboard entries
    add_dashboard_entry Ombi ombi ombi "Media content requests handler" iframe "PVR"
    add_dashboard_entry Sonarr sonarr sonarr "TV shows PVR" iframe "PVR"
    add_dashboard_entry Radarr radarr radarr "Movies PVR" iframe "PVR"
    add_dashboard_entry Lidarr lidarr lidarr "Music PVR" iframe "PVR"
    add_dashboard_entry Bazarr bazarr bazarr "Automaticall download subtitles for movies and TV shows" iframe "PVR"
    add_dashboard_entry "Youtube-DL" youtubedl "youtubedl-material" "Download Youtube videos, channels and playlists" iframe "PVR"
