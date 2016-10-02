#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------


INSTALL="yaourt -S --noconfirm"
SOURCE="source"
COMPONENTS_PATH="./components"

${SOURCE} ${COMPONENTS_PATH}/network.sh
${SOURCE} ${COMPONENTS_PATH}/aur-helper.sh
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
