#-------------------------------------------------
# Password manager
#-------------------------------------------------


process_docker_compose_service password-manager/bitwardenrs ""


# Create a dashboard entry
    add_dashboard_entry Bitwarden bitwarden bitwarden "Password manager" new_tab "Misc apps / tools"
