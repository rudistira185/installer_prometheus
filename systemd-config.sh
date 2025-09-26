#!/bin/bash

#color 
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"


FOLDER=$PWD

#prometheus
if sudo cp "$FOLDER/systemd/prometheus.service" /etc/systemd/system/prometheus.service; then 
echo "(INFO) prometheus systemd copy success"
else
echo "(ERR) promethes system copy failed"
fi

#snmp
if sudo cp "$FOLDER/systemd/snmp-exporter.service" /etc/systemd/system/snmp-exporter.service; then
echo -e "${GREEN} (INFO) success copy snmp systemd ${RESET}"
else
echo -e "${RED} (ERR)failed copy snmp systemd ${RESET}"
fi

#alertmanager
if sudo cp "$FOLDER/systemd/alertmanager.service" /etc/systemd/system/alertmanager.service; then
echo -e "${GREEN} (INFO) success copy alertmanager systemd ${RESET}"
else
echo -e "${RED} (ERR)failed copy alertmanager systemd ${RESET}"
fi

