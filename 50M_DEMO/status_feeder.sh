#!/bin/bash

# Function to check if the log line contains "100%"
check_log() {
    if [[ $1 == *"100%"* ]]; then
        echo "$1"
        exit 0
    fi
}

# Loop to continuously monitor logs
while true; do
    latest_log=$(kubectl logs oracle-feeder-xap-pu-0 --tail=1 | grep Progress)
    progress=$(echo "$latest_log" | awk '{print $3}')
    echo -ne "Progress: $progress\r"
    
    check_log "$latest_log"
    [[ $latest_log != *"%"* ]] && break
    sleep 1
done
kubectl logs oracle-feeder-xap-pu-0 --tail=8 | grep Finished
