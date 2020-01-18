#-------------------------------------------------
# Configure security settings
# Has to be called before any component calling ufw
#-------------------------------------------------


# Firewall
   ${INSTALL} ufw
   sudo ufw enable
   sudo systemctl enable ufw.service

# Fail2ban
   ${INSTALL} fail2ban
   sudo_create_link ${COMPONENTS_DIR}/security/config/fail2ban/jail.local /etc/fail2ban/
   sudo_create_link ${COMPONENTS_DIR}/security/config/fail2ban/filter.d/traefik.conf /etc/fail2ban/filter.d
   sudo_create_link ${COMPONENTS_DIR}/security/config/fail2ban/filter.d/traefik-auth.conf /etc/fail2ban/filter.d
   sudo_create_link ${COMPONENTS_DIR}/security/config/fail2ban/filter.d/traefik-botsearch.conf /etc/fail2ban/filter.d
   sudo_create_link ${COMPONENTS_DIR}/security/config/fail2ban/jail.d/traefik.conf /etc/fail2ban/jail.d

   # Cloudflare connection configto update Cloudflare firewall
      # Fail2ban Cloudflare action dependency
         ${INSTALL} curl
      # Not sure if /etc/fail2ban/action.d/ files are subject to modification by fail2ban ... If yes, then this will
      # break after a while
      sudo sed -i "s/cftoken =/cftoken = ${cloudflare_api_key}/g" /etc/fail2ban/action.d/cloudflare.conf
      sudo sed -i "s/cfuser =/cfuser = ${cloudflare_email}/g" /etc/fail2ban/action.d/cloudflare.conf

   sudo systemctl enable fail2ban
