#-------------------------------------------------
# Global variables
#-------------------------------------------------

TEMP_DOCKER_COMPOSE_PARTS_DIR="/tmp/docker-compose-parts"
TEMP_DOCKER_PART_NETWORKS="/tmp/docker-networks"
TEMP_DOCKER_PART_VOLUMES="/tmp/docker-volumes"
TEMP_DOCKER_PART_SECRETS="/tmp/docker-secrets"

SERVICES_GENERATED_CONFIG_DIR="/mnt/services/generated-configs"
SERVICES_DATA_DIR="/mnt/services/data"

COMPONENTS_DIR="components"

declare -A COMMON_TEMPLATES_MAPPING=(
    ["USER_DIR"]="/home/${USER}"
    ["DOCKER_USER_ID"]="$(id -u ${USER})"
    ["DOCKER_GROUP_ID"]="$(id -g ${USER})"
    ["TIMEZONE"]="${timezone}"
    ["DOMAIN_NAME"]="${domain_name}"
    ["TV_DIR"]="/mnt/media/tv"
    ["MOVIES_DIR"]="/mnt/media/movies"
    ["MUSIC_DIR"]="/mnt/media/music"
    ["MEDIA_DIR"]="/mnt/media"
    ["SERVICES_GENERATED_CONFIG_DIR"]="${SERVICES_GENERATED_CONFIG_DIR}"
    ["SERVICES_DATA_DIR"]="${SERVICES_DATA_DIR}"
    ["TORRENTS_DOWNLOADS_DIR"]="/mnt/torrents"
    ["TORRENTS_BLACKHOLE_DIR"]="/torrents-blackhole"
)
