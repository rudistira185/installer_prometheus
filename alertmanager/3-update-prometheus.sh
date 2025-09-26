#!/bin/bash


#color 
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"


if sudo cp "$PWD/prometheus.yml" /etc/prometheus/prometheus.yml; then
echo -e "${GREEN} (INFO) success copy update prometheus ${RESET}"
else
echo -e "${RED} (ERR) failed copy update prometheus ${RESET}"
exit 1
fi
