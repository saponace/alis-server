#-------------------------------------------------
# Personal video recording
#-------------------------------------------------

# Load ports variables
source components/pvr/variables.sh

# Sonarr: automated TV shows download
    declare -A  sonarr_docker_compose_template_mappings=(
        ["SONARR_PORT"]="${SONARR_PORT}"
    )
    process_docker_compose_service pvr/sonarr "$(declare -p sonarr_docker_compose_template_mappings)"

# Radarr: automated Movies download
    declare -A  radarr_docker_compose_template_mappings=(
        ["RADARR_PORT"]="${RADARR_PORT}"
    )
    process_docker_compose_service pvr/radarr "$(declare -p radarr_docker_compose_template_mappings)"

# Jackett: tracker proxy for sonarr and radarr
    declare -A  jackett_docker_compose_template_mappings=(
        ["JACKETT_PORT"]="${JACKETT_PORT}"
        ["TORRENTS_BLACKHOLE"]="/torrents-blackhole"
    )
    process_docker_compose_service pvr/jackett "$(declare -p jackett_docker_compose_template_mappings)"
#     ${INSTALL} jackett
#     jackett_config_dir="/usr/share/Jackett/.config/Jackett"

# # Create Jackett dynamic config dir
#     sudo mkdir "${jackett_config_dir}/.mono"
#     sudo chown jackett:jackett "${jackett_config_dir}/.mono/"
