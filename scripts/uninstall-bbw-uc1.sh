#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
source ./setEnv.sh

kubectl delete -f $kafka_producer_dir/configmap.yml
kubectl delete -f $kafka_producer_dir/kafka-producer-svc.yaml
kubectl delete -f $kafka_producer_dir/deployment.yaml

helm uninstall bbw-dih-space
helm uninstall bbw-dih-pc

