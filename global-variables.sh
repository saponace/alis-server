#-------------------------------------------------
# Global variables
#-------------------------------------------------

DOCKER_SHARED_DIR="/docker-shared"
TEMP_DOCKER_COMPOSE_PARTS_DIR="/tmp/docker-compose-parts"
CONTAINERS_CONFIG_DIR="/mnt/persistent-configs"
CONTAINERS_DATA_DIR="/mnt/data"
COMPONENTS_DIR="components"
mkdir -p ${TEMP_DOCKER_COMPOSE_PARTS_DIR}

declare -A COMMON_TEMPLATES_MAPPING=(
    ["USER_DIR"]="/home/${USER}"
    ["DOCKER_USER_ID"]="$(id -u ${USER})"
    ["DOCKER_GROUP_ID"]="$(id -g ${USER})"
    ["TIMEZONE"]="\\\"Europe/Paris\\\""
    ["DOMAIN_NAME"]="${domain_name}"
    ["MOVIES_DIR"]="/mnt/media/movies"
    ["TV_DIR"]="/mnt/media/tv"
    ["MEDIA_DIR"]="/mnt/media"
    ["CONTAINERS_CONFIG_DIR"]="${CONTAINERS_CONFIG_DIR}"
    ["DOCKER_SHARED_DIR"]="${DOCKER_SHARED_DIR}"
    ["DOWNLOADS_COMPLETE_DIR"]="/mnt/torrents/torrents-complete"
    ["TORRENTS_BLACKHOLE"]="/torrents-blackhole"
)
