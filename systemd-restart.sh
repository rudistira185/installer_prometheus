#!/bin/bash
sudo systemctl daemon-reload
#service
SERVICE=("prometheus" "node_exporter" "snmp-exporter" "grafana-server" "alertmanager")

for SERVICES in "${SERVICE[@]}"; do
if sudo systemctl restart $SERVICES; then
echo "(INFO) service "$SERVICES" started"
else
echo "(ERR) service "$SERVICES" failed start"
fi
done
