#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="yay -S --noconfirm"
COMPONENTS_PATH="./components"
CONFIG_FILE_PATH="./alis-server.config"
LOG_FILE="./alis-server.log"
ADDITIONAL_CONFIG_FILES_DIR="files-to-deploy/additional-config-files"


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


# Execute a component file
# The name of the component (without the ending ".sh")
function install_component (){
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "Starting installation of component $1" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  source "${COMPONENTS_PATH}/$1.sh" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "Finished installing component $1" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "========================================" 2>&1 | tee -a ${LOG_FILE}
  echo "" 2>&1 | tee -a ${LOG_FILE}
}

function enable_networking (){
  echo "Enabling networking ..."
  sudo dhcpcd
  while [ "$var1" != "end" ]
  do
      pingtime=$(ping -w 1 google.com | grep ttl)
      if [ "$pingtime" = "" ]
      then
          sleep 2
      else
          break
      fi
  done
  echo "Done !"
}



enable_networking
source common-functions.sh
install_component networking
install_component aur-helper
install_component common-dependencies
install_component vpn
install_component utils
install_component security
install_component core
install_component file-manager
install_component shell-and-term-related
install_component ssh
install_component transmission
install_component web-server
install_component kodi
install_component sonarr-radarr
install_component hyperion
${COMPONENTS_PATH}/link-files.sh ${username}

sync
sudo reboot
