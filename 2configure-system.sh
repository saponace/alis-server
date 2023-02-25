#!/bin/bash
#-------------------------------------------------
# Main script. Calls all the subscripts
#-------------------------------------------------

pwd
whoami
date
echo "pwd" | sudo --stdin --validate
sudo "echo $(date) >> /date"
