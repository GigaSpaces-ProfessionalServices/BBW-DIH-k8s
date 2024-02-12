#!/bin/bash
source ./demoEnv.sh
INGRESS=$(kubectl get svc ingress-nginx-controller -o json | jq -r .status.loadBalancer.ingress[].ip)

#Create an object type
./createObjectEmployees.sh > /dev/null

# Install feeder xap-pu
kubectl create configmap oracle-feeder-cm --from-file oracle-feeder-configmap.yaml 
kubectl apply -f ./oracle-feeder-service.yaml
helm upgrade --install oracle-feeder dihrepo/xap-pu --version 16.4.0 -f helm_feeder.yaml

