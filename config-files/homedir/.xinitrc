# UTF8 encoding (mostly for urxvt)
    export LANG="en_US.utf-8"
# Network manager with tray icon
    nm-applet 2>&1 /dev/null &
# Auto USB mounter
    /usr/bin/udiskie -s &
# Load Xterm config file
    xrdb .Xresources
# Window manager
    exec awesome 
# Start pulseaudio
    pulseaudio --start
