#-------------------------------------------------
# Torrenting client
#-------------------------------------------------

settings=${ADDITIONAL_CONFIG_FILES_DIR}/other/transmission-daemon/settings.json

declare -A  transmission_docker_compose_template_mappings=(
)
process_docker_compose_service torrenting-client/transmission "$(declare -p transmission_docker_compose_template_mappings)"

