#-------------------------------------------------
# Set cron jobs
#-------------------------------------------------


# Install cron scheduler
    ${INSTALL} cronie
# Enable cron
    sudo systemctl enable cronie.service

# Root cron jobs
    # Display notification or suspend when low battery (every minute)
        echo "*/1 * * * * env DISPLAY=:0 /bin/battery-level -n" > /tmp/root-crontab.txt
        sudo crontab -u root /tmp/root-crontab.txt

# User cron jobs
    # Set a random wallpaper every 15 minutes
        echo "*/15 * * * * env DISPLAY=:0.0 /bin/set-random-wallpaper" > /tmp/user-crontab.txt
        crontab /tmp/user-crontab.txt
