#-------------------------------------------------
# Personal video recording
#-------------------------------------------------

# Load ports variables
source components/pvr/variables.sh

# Sonarr: automated TV shows download
    declare -A  sonarr_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/sonarr "$(declare -p sonarr_docker_compose_template_mappings)"

# Radarr: automated Movies download
    declare -A  radarr_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/radarr "$(declare -p radarr_docker_compose_template_mappings)"

# Jackett: tracker proxy for sonarr and radarr
    declare -A  jackett_docker_compose_template_mappings=(
    )
    process_docker_compose_service pvr/jackett "$(declare -p jackett_docker_compose_template_mappings)"
