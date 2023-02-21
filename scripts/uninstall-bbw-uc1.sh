#!/bin/bash
# work_dir=~/BBW-DIH-k8s
# script_dir=$work_dir/scripts
# helm_dir=$work_dir/helm
# kafka_producer_dir=$work_dir/BBW-Kafka-Producer
source ./setEnv.sh

kubectl delete -f $kafka_producer_dir/configmap.yml
kubectl delete -f $kafka_producer_dir/kafka-producer-svc.yaml
kubectl delete -f $kafka_producer_dir/deployment.yaml
helm uninstall bbw-dih 
helm uninstall bbw-dih-space
helm uninstall bbw-dih-pc

