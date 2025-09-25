#!/bin/bash

sudo mkdir -p /etc/grafana
sudo tee /etc/grafana/grafana.ini <<EOF
[server]
http_port = 3000
EOF

