#!/bin/bash

SERVICES=("prometheus" "node_exporter" "snmp-exporter" "grafana-server")


for SERVICE in "${SERVICES[@]}"; do
if sudo systemctl stop "$SERVICE"; then
echo "(INFO) service $SERVICE stopped"
else
echo "(ERR) service $SERVICE failed stop"
fi
done
