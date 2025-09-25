#!/bin/bash

#destination


#color
RED="\033[31m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

#download snmp and extraxt
rm -rf $PWD/snmp_result
sudo rm -rf /usr/local/bin/snmp_exporter
if wget -O "$PWD/snmp_exporter.tar.gz" "https://github.com/prometheus/snmp_exporter/releases/download/v0.28.0/snmp_exporter-0.28.0.linux-amd64.tar.gz"; then
echo -e "${GREEN} (INFO) success download snmp_exporter ${RESET}"
  mkdir -p "$PWD/snmp_result"
  if tar -xvzf "$PWD/snmp_exporter.tar.gz" -C "$PWD/snmp_result"; then
  echo -e "${GREEN} (INFO) success extract snmp ${RESET}"
  echo -e "${GREEN}  (INFO) copy to /usr/local/bin"
     sudo mkdir -p /etc/snmp_exporter
     if sudo cp -r "$PWD/snmp_result/snmp_exporter-0.28.0.linux-amd64/snmp_exporter" /usr/local/bin; then 
     echo -e "${GREEN} (INFO) copy to /usr/local/bin success ${RESET}"
          if sudo cp -r "$PWD/snmp_result/snmp_exporter-0.28.0.linux-amd64/snmp.yml" /etc/snmp_exporter; then
          echo -e "${GREEN} (INFO) success copy snmp.yml to /etc ${RESET}"
          else
          echo -e "${RED} (ERR) failed copy snmp.yml ${RESET}"
          fi
     else
     echo -e "${RED} (ERR) failed to copy to /usr/local/bin"
     fi
  else 
  echo -e "${RED} (ERR) failed to extract snmp ${RESET}"
  fi
else
echo -e "${RED} (ERR) failed download snmp exporter ${RESET}"
exit 1
fi


#overwrite prometheus config

sudo tee /etc/prometheus/prometheus.yml > /dev/null <<'EOF'
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:2000"]
  - job_name: "node_exporter"
    static_configs:
      - targets: ["localhost:2100"]
  - job_name: "mikrotik-snmp"
    static_configs:
      - targets:
          - 192.168.122.122   # R1 (one)
    metrics_path: /snmp
    params:
      module: [mikrotik]
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:2200


EOF

