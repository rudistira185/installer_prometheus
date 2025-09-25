#!/bin/bash

#service
SERVICE=("prometheus" "node_exporter" "snmp-exporter" "grafana-server")

for SERVICES in "${SERVICE[@]}"; do
if sudo systemctl restart $SERVICES; then
echo "(INFO) service "$SERVICE" started"
else
echo "(ERR) service "$SERVICE" failed start"
fi
done
