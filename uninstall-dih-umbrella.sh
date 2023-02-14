#!/bin/bash
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl delete -f helm/dashboard-adminuser.yaml
kubectl delete -f helm/clusterRoleBinding.yaml
kubectl delete -f helm/ingress-rule-dashbord.yaml
kubectl delete -f BBW-Kafka-Producer/configmap.yml
kubectl delete -f BBW-Kafka-Producer/kafka-producer-svc.yaml
kubectl delete -f BBW-Kafka-Producer/deployment.yaml
helm uninstall bbw-dih 
helm uninstall bbw-dih-space 
helm uninstall ingress-nginx