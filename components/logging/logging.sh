#-------------------------------------------------
# Configure containers centralised logging solution
#-------------------------------------------------



# Increase vm allocated memory. Required by elasticsearch (actually does not seem required when elasticsearch is in
# single-node mode)
# sudo sysctl -w vm.max_map_count=262144

elasticsearch_data_dir=${SERVICES_DATA_DIR}/elasticsearch
sudo mkdir -p ${elasticsearch_data_dir}

add_docker_network "  elk:"
add_docker_volume "  elasticsearch:
    driver: local
    driver_opts:
      type: 'none'
      o: 'bind'
      device: '${elasticsearch_data_dir}'"


elk_version=7.7.0

# Logspout: Send docker containers logs to logstash
    process_docker_compose_service logging/logspout ""


# Logstash: Centralise logs and send them to elasticsearch
    declare -A  logstash_docker_compose_template_mappings=(
        ["VERSION"]=${elk_version}
    )
    process_docker_compose_service logging/logstash "$(declare -p logstash_docker_compose_template_mappings)"


# Elasticsearch: Search engine
    declare -A  elasticsearch_docker_compose_template_mappings=(
        ["DATA_DIR"]=${elasticsearch_data_dir}
        ["VERSION"]=${elk_version}
    )
    process_docker_compose_service logging/elasticsearch "$(declare -p elasticsearch_docker_compose_template_mappings)"


# Kibana: Web UI for analysing elastic search content
    declare -A  kibana_docker_compose_template_mappings=(
        ["VERSION"]=${elk_version}
    )
    process_docker_compose_service logging/kibana "$(declare -p kibana_docker_compose_template_mappings)"


# Create a dashboard entry for Kibana
    add_dashboard_entry Kibana kibana kibana "Visualize apps logs and extract statistics and reports" iframe "Maintenance / monitoring"
