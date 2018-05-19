#-------------------------------------------------
# Configure Docker
#-------------------------------------------------

# mkdir -p ${DOCKER_SHARED_DIR}

declare -A  mappings=(
["PORTAINER_PORT"]="9000"
["ORGANIZR_PORT"]="9001"
["HOME_ASSISTANT_PORT"]="9002"
["PIA_CREDENTIALS_FILE"]=""
# [""]=""
# [""]=""
# [""]=""
)

docker_file="/tmp/dockerfile.yml"

cp ${DOCKER_COMPOSE_PARTS_TEMPLATES_DIRNAME_RELATIVE_TO_REPO_ROOT}"/base.yml" ${docker_file}

for part in ${TEMP_DOCKER_COMPOSE_PARTS_DIR}/*; do
    cat ${part} >> ${docker_file}
done

