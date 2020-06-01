#-------------------------------------------------
# Search engine
#-------------------------------------------------


process_docker_compose_service search-engine/whoogle-search ""


# Create a dashboard entry
    add_dashboard_entry Whoogle-search whoogle whoogle-search "Privacy friendly Google metasearch engine" iframe "Misc apps / tools"
