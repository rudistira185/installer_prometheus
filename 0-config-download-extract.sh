#!/bin/bash

#variable link
DESTINATION=~/grafana
URL_PROMETHEUS="https://github.com/prometheus/prometheus/releases/download/v3.5.0/prometheus-3.5.0.linux-amd64.tar.gz"
OUTPUT_PROMETHEUS="prometheus.tar.gz"
URL_NODEEXPORTER="https://github.com/prometheus/node_exporter/releases/download/v1.9.1/node_exporter-1.9.1.linux-amd64.tar.gz"
OUTPUT_NODEEXPORTER="node_exporter.tar.gz"

#create config
mkdir -p ~/grafana

#download and extraxt prometheus
echo "(INFO) check file prometheus"
if [ -f "$DESTINATION/$OUTPUT_PROMETHEUS" ]; then
echo "(SKIP) file prometheus $OUTPUT_PROMETHEUS already in $DESTINATION"
else
sleep 2
echo "Downloading prometheus"
  if wget -O "$OUTPUT_PROMETHEUS" "$URL_PROMETHEUS"; then
   echo "download prometheus success"
   sleep 2
   echo "move to ~/grafana"
   sleep 1
   if mv "$OUTPUT_PROMETHEUS" "$DESTINATION"; then
   echo "(INFO)succes move prometheus file to ~/grafana"
   sleep 1
   if tar -xvf "$DESTINATION/$OUTPUT_PROMETHEUS" -C "$DESTINATION"; then
   echo "(INFO) extraxt prometheus success"
   mv "$DESTINATION/prometheus-3.5.0.linux-amd64" "$DESTINATION/prometheus-result"
   echo "(INFO) rename folder prometheus success"
   else 
   echo "(ERR) extraxt prometheus failed"
   fi
   else
   echo "(ERR) failed move prometheus to grafana"
   exit 1
   fi
   else
   echo "download failed"
   exit 1
  fi
fi

#download nodeexporter & extraxt 
echo "(INFO) check file node exporter"
if [ -f "$DESTINATION/$OUTPUT_NODEEXPORTER" ]; then 
   echo "(INFO) node exporter already exist"
  else
   echo "(INFO) Downloading file nodeexporter"
  if wget -O "$OUTPUT_NODEEXPORTER" "$URL_NODEEXPORTER"; then
   echo "(INFO) node exporter sucess download"
   else
   echo "(ERR) failed download nodeexporter"
   exit 1
   fi
  if mv "$OUTPUT_NODEEXPORTER" "$DESTINATION"; then
   echo "(INFO) move file to ~/grafana"
   if tar -xvf "$DESTINATION/$OUTPUT_NODEEXPORTER" -C "$DESTINATION"; then
   echo "(INFO) extraxt file nodeexporter success"
   mv "$DESTINATION/node_exporter-1.9.1.linux-amd64" "$DESTINATION/nodeexporter-result"
  echo "(INFO) rename folder nodeexporter success"
   else 
   echo "(ERR) extraxt file nodeexporter failed"
   exit 1
   fi
   else 
   echo "(ERR) move nodeexporter failed"
  fi
 fi

  
