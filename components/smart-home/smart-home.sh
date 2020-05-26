#-------------------------------------------------
# Home automation hub
#-------------------------------------------------


process_docker_compose_service smart-home/home-assistant ""


# Create a dashboard entry
    add_dashboard_entry "Home assistant" homeassistant "home-assistant" "Home automation hub" iframe "Misc"
