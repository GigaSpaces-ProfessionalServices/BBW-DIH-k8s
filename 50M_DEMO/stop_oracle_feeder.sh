#!/bin/bash
source ./demoEnv.sh
INGRESS=$(kubectl get svc ingress-nginx-controller -o json | jq -r .status.loadBalancer.ingress[].ip)
table_name=BBW_DEMO.EMPLOYEES
MAX_COL=EMP_ID
REST=$INGRESS:8015
curl -X POST "http://$REST/table-feed/stop"
