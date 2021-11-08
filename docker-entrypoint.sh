#!/bin/sh
# Lacework Agent: configure and start the data collector
sudo -E /var/lib/lacework-backup/lacework-sidecar.sh &

while true; do sleep 30; done;
