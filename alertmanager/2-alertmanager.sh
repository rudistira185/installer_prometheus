#!/bin/bash

#color 
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

sudo rm -rf /etc/alertmanager/alertmanager.yml
#copy file

if sudo cp "$PWD/alertmanager.yml" /etc/alertmanager/alertmanager.yml; then
echo -e "${GREEN} (INFO) success copy alertmanager.yml ${RESET}"
else 
echo -e "${RED} (ERR) failed copy alertmanager.yml ${RESET}"
fi
