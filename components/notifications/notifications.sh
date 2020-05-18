#-------------------------------------------------
# Push notification server
#-------------------------------------------------


add_docker_network "  notifications:"

process_docker_compose_service notifications/gotify ""
