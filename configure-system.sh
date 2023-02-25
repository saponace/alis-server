#!/bin/bash
#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="yay -S --noconfirm --needed"
COMPONENTS_PATH="./components"
CONFIG_FILE_PATH="./alis-server.config"
LOG_FILE="./alis-server.log"



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

HOMEDIR_DOTFILES_SOURCE="files-to-deploy/config-files/homedir"
USER_HOMEDIR_DOTFILES_DESTINATION="/home/${username}"
ROOT_HOMEDIR_DOTFILES_DESTINATION="/root"
SCRIPTS_DIR="files-to-deploy/scripts"



# Execute a component file
# $1: The name of the component (without the ending ".sh")
function install_component (){
  COLORED='\033[0;34m'
  UNDERLINE='\e[4m'
  NORMAL='\033[0m'

  echo -e "${COLORED}# Installing component \"${UNDERLINE}$1${NORMAL}${COLORED}\" ...${NORMAL}" 2>&1 | tee -a ${LOG_FILE}
  # Case components/xxx/xxx.sh
  if [ -f "${COMPONENTS_PATH}/$1/$1.sh" ]; then
      source "${COMPONENTS_PATH}/$1/$1.sh" 2>&1 | tee -a ${LOG_FILE}
  # Case components/xxx.sh
  elif [ -f "${COMPONENTS_PATH}/$1.sh" ]; then
    source "${COMPONENTS_PATH}/$1.sh" 2>&1 | tee -a ${LOG_FILE}
  else
    echo "Error: Component $1 not found"
  fi
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


source ./common-variables.sh
source ./common-functions.sh

# Create directory for temporary files during docker compose files build
  mkdir -p ${TEMP_DOCKER_COMPOSE_PARTS_DIR}

# Create services data and config dirs
    mkdir -p ${SERVICES_GENERATED_CONFIG_DIR}
    mkdir -p ${SERVICES_DATA_DIR}

enable_networking
install_component aur-helper
install_component networking
install_component utils
install_component security
install_component core
install_component file-manager
install_component shell-and-term-related
install_component ssh
####
install_component vpn-client
install_component reverse-proxy
install_component dns-updater
install_component torrenting
install_component media-server
# install_component smart-home  # Disabled because unused
install_component system-monitoring
install_component pvr
install_component dashboard
install_component finances-management
install_component dns-server
install_component file-server
install_component file-synchronization
install_component file-browser-web
install_component password-manager
install_component notifications
install_component logging
install_component auth
install_component data-manipulation
install_component docker
install_component search-engine
install_component remote-backups


# These scripts should be sourced after every call to "install_component"
  source "${COMPONENTS_PATH}/dashboard/configure-entries.sh" 2>&1 | tee -a ${LOG_FILE}
  source "${COMPONENTS_PATH}/docker/build-docker-compose-definition.sh" 2>&1 | tee -a ${LOG_FILE}

sudo ln -snf $(readlink -f ${SCRIPTS_DIR}/startup) /bin/startup
sudo ln -snf $(readlink -f ${SCRIPTS_DIR}/manage-disks) /bin/manage-disks


# Disable auto-exec of this script at startup
  # Remove no password exception for sudo calls
    sudo su -c "head -n -2 /etc/sudoers > /tmp/sudoers"
    sudo mv /tmp/sudoers /etc/sudoers
  # Un-deploy systemd unit file
    sudo systemctl disable configure-system.service
    sudo rm /etc/systemd/system/configure-system.service

sync
sudo reboot
