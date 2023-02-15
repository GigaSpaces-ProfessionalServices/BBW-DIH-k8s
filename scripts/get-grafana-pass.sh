#!/bin/bash
grafanaPass=$(kubectl get secret  grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo)
echo "Grafana password:"
echo 
echo $grafanaPass