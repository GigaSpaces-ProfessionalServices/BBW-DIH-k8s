#!/bin/bash
clustername=$(kubectl config current-context)
clusteringress=$(kubectl get svc ingress-nginx-controller |awk '{print $4}'|tail -1)

echo "============================================="
echo "GUI url list for cluster [ $clustername ]"
echo "--------------------------------------------"
echo "ops-manager:     http://${clusteringress}:8090"
echo 
echo "grafana:         http://${clusteringress}:3000"
echo
echo "k8s dashboard:   https:/${clusteringress}"
echo "============================================="
