#-------------------------------------------------
# Push notification server
#-------------------------------------------------


add_docker_network "  notifications:"

process_docker_compose_service notifications/gotify ""

# Create a dashboard entry
    add_dashboard_entry Notifications notifications gotify "A simple server for sending and receiving messages" iframe "Technical services"
