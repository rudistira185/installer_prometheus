#!/bin/bash

#color 
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

SERVICE=("prometheus" "node_exporter" "dbus" "grafana-server" "snmp-exporter" "alertmanager")

for SERVICE in "${SERVICE[@]}"; do

   # Cek apakah service ada
    if ! systemctl list-unit-files | grep -q "^$SERVICE.service"; then
        echo -e "${RED}$SERVICE service not found${RESET}"
        continue
    fi

    STATUS=$(systemctl is-active "$SERVICE" 2>/dev/null)

    if [ "$STATUS" = "active" ]; then
        echo -e "${GREEN}$SERVICE is running${RESET}"
    elif [ "$STATUS" = "inactive" ]; then
        echo -e "${RED}$SERVICE is inactive${RESET}"
    elif [ "$STATUS" = "failed" ]; then
        echo -e "${RED}$SERVICE failed to start${RESET}"
    else
        echo -e "${YELLOW}$SERVICE status: $STATUS${RESET}"
    fi
done

