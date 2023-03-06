#-------------------------------------------------
# Configure security settings
# Has to be called before any component calling ufw
#-------------------------------------------------


# Firewall
   install_package ufw
   sudo ufw --force enable
   sudo systemctl enable ufw.service

# Fail2ban
   install_package fail2ban
   sudo cp -rT ${COMPONENTS_DIR}/security/config/fail2ban/ /etc/fail2ban/

   # Cloudflare connection configto update Cloudflare firewall
      # Fail2ban Cloudflare action dependency
         install_package curl
      # Not sure if /etc/fail2ban/action.d/ files are subject to modification by fail2ban ... If yes, then this could
      # break after a while
      sudo sed -i "s/cftoken =.*$/cftoken = ${cloudflare_api_key}/g" /etc/fail2ban/action.d/cloudflare.conf
      sudo sed -i "s/cfuser =.*$/cfuser = ${cloudflare_email}/g" /etc/fail2ban/action.d/cloudflare.conf

   sudo systemctl enable fail2ban
