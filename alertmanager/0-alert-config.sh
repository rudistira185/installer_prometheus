#!/bin/bash

ALERT_LINK="https://github.com/prometheus/alertmanager/releases/download/v0.28.1/alertmanager-0.28.1.linux-amd64.tar.gz"
ALERT_OUTPUT="alert.tar.gz"
ALERT_OUTPUT_FOLDER="alertfolder-result"

rm -rf alert.tar.gz
rm -rf alertfolder-result

if wget -O "$PWD/$ALERT_OUTPUT" "$ALERT_LINK"; then
echo "Downloading alertmanager"
   mkdir -p "$ALERT_OUTPUT_FOLDER"
   if tar -xvzf "$ALERT_OUTPUT" -C "$ALERT_OUTPUT_FOLDER"; then
   echo "succes extract alertmanager"
      if sudo cp "$PWD/$ALERT_OUTPUT_FOLDER/alertmanager-0.28.1.linux-amd64/alertmanager" /usr/local/bin; then
      echo "success copy alertmanager to /usr/local/bin"
          if sudo cp "$PWD/$ALERT_OUTPUT_FOLDER/alertmanager-0.28.1.linux-amd64/amtool" /usr/local/bin; then
          echo "succes copy amtool to /usr/local/bin"
          else 
          echo "failed copy amtool to /usr/local/bin" 
          exit 1
         fi
   fi
   else
   echo "failed extraxt alertmanager"
  fi
else
echo "failed download alermanager"
exit 1
fi


