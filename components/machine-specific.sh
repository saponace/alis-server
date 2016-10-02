#-------------------------------------------------
# Configure machine specific settings
# Here, a thinkpad T550
#-------------------------------------------------


# Start and stop charging batteries at given values (preserve batteries health on the long term)
    ${INSTALL} tp-battery-mode
    sudo systemctl enable tp-battery-mode

# FingerPrint scanner drivers
    ${INSTALL} fprintd
    # Register all the fingerprints
        echo "Registering all the fingers via the fingerprint scanner..."
        fprintd-enroll -f left-thumb
        fprintd-enroll -f left-index-finger
        fprintd-enroll -f left-middle-finger
        fprintd-enroll -f left-ring-finger
        fprintd-enroll -f left-little-finger
        fprintd-enroll -f right-thumb
        fprintd-enroll -f right-index-finger
        fprintd-enroll -f right-middle-finger
        fprintd-enroll -f right-ring-finger
        fprintd-enroll -f right-little-finger
    # Add fingerprint authentication to the list of login authentications
        su -c "echo 'auth sufficient pam_fprintd.so' >> /etc/pam.d/system-local-login"
