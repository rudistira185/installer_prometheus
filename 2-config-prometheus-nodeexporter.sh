#!/bin/bash

#variable
FILE_PROMETHEUS_FROM="/home/carlos/grafana/prometheus-result"
FILE_NODEEXPORTER_FROM="/home/carlos/grafana/nodeexporter-result"

#create folder
sudo mkdir -p /etc/prometheus
sudo mkdir -p /var/lib/prometheus

#permission
sudo chown -R prometheus:prometheus /var/lib/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus

#move file
sudo cp "$FILE_PROMETHEUS_FROM/prometheus" /usr/local/bin
sudo cp "$FILE_PROMETHEUS_FROM/promtool" /usr/local/bin
sudo cp "$FILE_NODEEXPORTER_FROM/node_exporter" /usr/local/bin

#permission
sudo chmod +x /usr/local/bin/prometheus
sudo chmod +x /usr/local/bin/promtool
sudo chmod +x /usr/local/bin/node_exporter

# buat file prometheus.yml dengan isi konfigurasi
sudo tee /etc/prometheus/prometheus.yml > /dev/null <<'EOF'
global:
  scrape_interval: 15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
  evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.

scrape_configs:
  - job_name: "prometheus"
    static_configs:
      - targets: ["localhost:9090"]
EOF

echo "(INFO) prometheus.yml generate success"
