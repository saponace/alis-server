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
${SOURCE} ${COMPONENTS_PATH}/network-related.sh
${SOURCE} ${COMPONENTS_PATH}/core.sh
${SOURCE} ${COMPONENTS_PATH}/dev.sh
${SOURCE} ${COMPONENTS_PATH}/utils.sh
${SOURCE} ${COMPONENTS_PATH}/x-related.sh
${SOURCE} ${COMPONENTS_PATH}/hardware-drivers.sh
${SOURCE} ${COMPONENTS_PATH}/misc.sh
${SOURCE} ${COMPONENTS_PATH}/misc-gui.sh
${SOURCE} ${COMPONENTS_PATH}/virtualbox.sh
${SOURCE} ${COMPONENTS_PATH}/battery-management.sh
${SOURCE} ${COMPONENTS_PATH}/font-and-gtk-theme.sh
${SOURCE} ${COMPONENTS_PATH}/sound-related.sh
${SOURCE} ${COMPONENTS_PATH}/file-manager.sh
${SOURCE} ${COMPONENTS_PATH}/machine-specific.sh
${SOURCE} ${COMPONENTS_PATH}/shell-and-term-related.sh
${SOURCE} ${COMPONENTS_PATH}/cron-jobs.sh
${SOURCE} ${COMPONENTS_PATH}/lock-screen-script-dependencies.sh
${COMPONENTS_PATH}/link-files.sh
