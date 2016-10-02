#-------------------------------------------------
# Install Sound servers, and DAW
#-------------------------------------------------


# Sound server
    ${INSTALL} pulseaudio pulseaudio-alsa alsa-utils pavucontrol pasystray
    # Use bluetooth headphones with pulseaudio
        ${INSTALL} pulseaudio-bluetooth bluez bluez-utils bluez-firmware

# DAW
    ${INSTALL} bitwig-studio
    # Jack2, other sound server
        ${INSTALL} jack2
        # Jack2 GUI
            ${INSTALL} qjackctl
        # Jack sink for pulseaudio
            ${INSTALL} pulseaudio-jack
