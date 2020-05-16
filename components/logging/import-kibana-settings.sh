# Import settings into kibana and overwrite existing settings
# reference: https://www.elastic.co/guide/en/kibana/7.x/saved-objects-api-import.html

# You need access to the docker daemon to execute this script
# This script does not have any error handling. We just gotta hope that it will work in all situations

script_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

elasticsearch_docker_network=server-apps-suite_elk


kibana_container_name=kibana
kibana_port=5601
not_ready_response="Kibana server is not ready yet"
settings_file=${script_dir}/config/kibana-settings.ndjson

elasticsearch_container_name=elasticsearch
elasticsearch_port=9200
elastic_index_policy_logstash_file=${script_dir}/config/elasticsearch-index-policy-logstash.json


max_attempts=20
retry_interval=5  # in seconds

num_attempts=0
ip_addr_query='{{ $network := index .NetworkSettings.Networks "'${elasticsearch_docker_network}'" }}{{$network.IPAddress}}'


# Prevent sudo timeout
sudo -v
while true; do
  sudo -nv; sleep 1m
  kill -0 $$ 2>/dev/null || exit   # Exit when the parent process is not running any more
done &

# Execute Kibana settings import
while ([ -z ${kibana_ip} ] || [ ${status} != 0 ] || [ "${response}" = "${not_ready_response}" ]) && [ ${num_attempts} -lt ${max_attempts} ]
do
    echo "Waiting for Kibana to be ready to accept connections ..."
    sleep ${retry_interval}

    kibana_ip=$( sudo docker inspect -f "${ip_addr_query}" ${kibana_container_name} )
    elasticsearch_ip=$( sudo docker inspect -f "${ip_addr_query}" ${elasticsearch_container_name} )

    response=$( curl -X POST "${kibana_ip}:${kibana_port}/api/saved_objects/_import?overwrite=true" -H "kbn-xsrf: true" --form file=@${settings_file} )
    status=$?

    ((num_attempts++))
done

echo -e "\n"

if [ ${num_attempts} -ge ${max_attempts} ]; then
    echo -e "Too many attemps: aborting"
    exit 1;
else
    # If Kibana settings import succeeded, it means elasticsearch is up and running. We can then execute Elasticsearch
    # queries

    echo "Elasticsearch index policies import result:"
    curl -X PUT "${elasticsearch_ip}:${elasticsearch_port}/_ilm/policy/logstash-policy" -H 'Content-Type: application/json' -d @${elastic_index_policy_logstash_file}

    echo -e "\n"
    echo "Kibana settings imported in ${num_attempts} attempts !"
    exit 0;
fi;
