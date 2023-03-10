#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

source ./setEnv.sh

kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl delete -f $helm_dir/clusterRoleBinding.yaml
helm uninstall bbw-dih
helm uninstall ingress-nginx
helm uninstall kafka
helm uninstall influxdb-kapacitor
kubectl delete -f $helm_dir/kafka-ui-deployment.yaml
kubectl delete -f $helm_dir/kafka-ui-svc.yaml
kubectl delete pvc data-kafka-0
kubectl delete pvc data-kafka-zookeeper-0
