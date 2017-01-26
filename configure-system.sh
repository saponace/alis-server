#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="yaourt -S --noconfirm"
SOURCE="source"
COMPONENTS_PATH="./components"


# Prevent sudo timeout
sudo -v
while true; do
  sudo -nv; sleep 1m
  kill -0 $$ 2>/dev/null || exit   # Exit when the parent process is not running any more
done &



${SOURCE} ${COMPONENTS_PATH}/enable-networking.sh
${SOURCE} ${COMPONENTS_PATH}/aur-helper.sh
${SOURCE} ${COMPONENTS_PATH}/utils.sh
${SOURCE} ${COMPONENTS_PATH}/security.sh
${SOURCE} ${COMPONENTS_PATH}/network-related.sh
${SOURCE} ${COMPONENTS_PATH}/core.sh
${SOURCE} ${COMPONENTS_PATH}/file-manager.sh
${SOURCE} ${COMPONENTS_PATH}/shell-and-term-related.sh
${SOURCE} ${COMPONENTS_PATH}/ssh.sh
${SOURCE} ${COMPONENTS_PATH}/transmission.sh
${SOURCE} ${COMPONENTS_PATH}/nextcloud.sh
${SOURCE} ${COMPONENTS_PATH}/web-server.sh
${SOURCE} ${COMPONENTS_PATH}/fs-snapshots.sh
${COMPONENTS_PATH}/link-files.sh




