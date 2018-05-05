#-------------------------------------------------
# Configure Hyperion
#-------------------------------------------------


# Save current working directory
    pushd `dirname $0` > /dev/null
    initial_location=`pwd`
    popd > /dev/null

# Install required dependencies
    ${INSTALL} make cmake base-devel qt4 libusb libxrender icu

# Compile hyperion from sources
    export HYPERION_BUILD_DIR="/tmp/hyperion-build"
    git clone --recursive https://github.com/tvdzwan/hyperion.git "${HYPERION_BUILD_DIR}"

    mkdir "${HYPERION_BUILD_DIR}/build"
    cd "${HYPERION_BUILD_DIR}/build"

    cmake -DCMAKE_BUILD_TYPE=Release -DPLATFORM="rpi" -Wno-dev ..
    make -j $(nproc)

    strip bin/*


# Copy binaries and resources
    sudo mv ./bin/hyperion-remote /usr/bin/
    sudo mv ./bin/hyperiond /usr/bin/
    sudo mkdir -p /usr/share/hyperion/effects && sudo mv ../effects/ /usr/share/hyperion/

# Restore working directory before compilation
    cd ${initial_location}

# Custom Hyperion service
    create_link "${ADDITIONAL_CONFIG_FILES_DIR}/other/systemd-units/hyperion.service" "/etc/systemd/system/"
    sudo systemctl enable hyperion

# Link config file config file
    create_link ${ADDITIONAL_CONFIG_FILES_DIR}/other/hyperion.config.json /usr/share/hyperion

# Allow REST API port through firewall
    sudo ufw allow 19444
