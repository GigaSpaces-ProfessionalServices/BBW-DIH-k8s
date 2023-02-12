#!/bin/bash
clustername=$(kubectl config current-context)
clusteringress=$(kubectl get svc ingress-nginx-controller |awk '{print $4}'|tail -1)

 
echo "============================================="
echo "GUI url list for cluster [ $clustername ]"
echo "--------------------------------------------"

if [[ $clusteringress = "pending" ]];then
    echo "Waiting for Public IP ..."
        while [[ $clusteringress = "pending" ]]; do
            printf '.' > /dev/tty
            sleep 1
        done;
fi
echo
echo "ops-manager:     http://${clusteringress}:8090"
echo 
echo "SpaceDeck        http://${clusteringress}:3000"
echo
echo "grafana:         http://${clusteringress}:3030"
echo
echo "k8s dashboard:   https:/${clusteringress}"
echo "============================================="
