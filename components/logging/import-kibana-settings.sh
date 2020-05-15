# Import settings into kibana and overwrite existing settings
# reference: https://www.elastic.co/guide/en/kibana/7.x/saved-objects-api-import.html

# You need access to the docker daemon to execute this script
# This script does not have any error handling. We just gotta hope that it will work in all situations

script_dir=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

container_name=kibana
docker_network=web
kibana_port=5601
not_ready_response="Kibana server is not ready yet"
settings_file=${script_dir}/config/settings.ndjson

max_attempts=20
retry_interval=5  # in seconds

num_attempts=0


# Prevent sudo timeout
sudo -v
while true; do
  sudo -nv; sleep 1m
  kill -0 $$ 2>/dev/null || exit   # Exit when the parent process is not running any more
done &

while ([ -z ${kibana_ip} ] || [ ${status} != 0 ] || [ "${response}" = "${not_ready_response}" ]) && [ ${num_attempts} -lt ${max_attempts} ]
do
    echo "Waiting for Kibana to be ready to accept connections ..."
    sleep ${retry_interval}

    kibana_ip=$( sudo docker inspect -f "{{.NetworkSettings.Networks.${docker_network}.IPAddress}}" ${container_name} )
    response=$( curl -X POST "${kibana_ip}:${kibana_port}/api/saved_objects/_import?overwrite=true" -H "kbn-xsrf: true" --form file=@${settings_file} )
    status=$?

    ((num_attempts++))
done

echo -e "\n"


if [ ${num_attempts} -ge ${max_attempts} ]; then
    echo -e "Too many attemps: aborting"
    exit 1;
else
    echo -e "Settings imported in ${num_attempts} attempts !"
    exit 0;
fi;
