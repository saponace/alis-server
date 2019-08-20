#-------------------------------------------------
# Password manager
#-------------------------------------------------


# Create docker compose component
declare -A  docker_compose_template_mappings=(
)
process_docker_compose_service password-manager/bitwardenrs "$(declare -p docker_compose_template_mappings)"
