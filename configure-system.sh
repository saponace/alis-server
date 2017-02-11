#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="packer -S --noconfirm"
SOURCE="source"
COMPONENTS_PATH="./components"
CONFIG_FILE_PATH="./alis-server.config"


# Prevent sudo timeout
sudo -v
while true; do
  sudo -nv; sleep 1m
  kill -0 $$ 2>/dev/null || exit   # Exit when the parent process is not running any more
done &



if [ ! -f "${CONFIG_FILE_PATH}" ]
then
  echo "Error: config file ${CONFIG_FILE_PATH} not found. Please create this file and try again"
  exit 1
fi
source ${CONFIG_FILE_PATH}

# Check if the user that calls this script is the same user as defined in the config file
if [[ ${username} != ${USER} ]];
then
  echo "Error: you are not ${username} as defined in the config file. Please execute this script as ${username}."
  exit 1
fi


${SOURCE} ${COMPONENTS_PATH}/networking.sh
${SOURCE} ${COMPONENTS_PATH}/aur-helper.sh
${SOURCE} ${COMPONENTS_PATH}/utils.sh
${SOURCE} ${COMPONENTS_PATH}/security.sh
${SOURCE} ${COMPONENTS_PATH}/core.sh
${SOURCE} ${COMPONENTS_PATH}/file-manager.sh
${SOURCE} ${COMPONENTS_PATH}/shell-and-term-related.sh
${SOURCE} ${COMPONENTS_PATH}/ssh.sh
${SOURCE} ${COMPONENTS_PATH}/transmission.sh
${SOURCE} ${COMPONENTS_PATH}/nextcloud.sh
${SOURCE} ${COMPONENTS_PATH}/web-server.sh
${COMPONENTS_PATH}/link-files.sh ${username}




