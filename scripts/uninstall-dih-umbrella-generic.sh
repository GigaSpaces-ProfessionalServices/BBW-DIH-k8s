#!/bin/bash
work_dir=~/BBW-DIH-k8s
script_dir=$work_dir/scripts
helm_dir=$work_dir/helm
kafka_producer_dir=$work_dir/BBW-Kafka-Producer

kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
#kubectl delete -f $helm_dir/dashboard-adminuser.yaml
kubectl delete -f $helm_dir/clusterRoleBinding.yaml
#kubectl delete -f $helm_dir/ingress-rule-dashbord.yaml
helm uninstall bbw-dih
helm uninstall ingress-nginx 
kubectl delete pvc data-kafka-0
kubectl delete pvc data-zookeeper-0
kubectl delete pvc influxdb-data-influxdb-0
