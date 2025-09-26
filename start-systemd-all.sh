#!/bin/bash

#service
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
#prometheus
sudo systemctl enable --now prometheus.service
