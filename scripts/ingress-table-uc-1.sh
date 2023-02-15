#!/bin/bash
clustername=$(kubectl config current-context)
clusteringress=$(kubectl get svc ingress-nginx-controller |awk '{print $4}'|tail -1)

 
echo "============================================="
echo "Ingress table for [ $clustername ]"
echo "--------------------------------------------"
echo
echo "kafka-producer         http://${clusteringress}:8081"
echo 
echo "Pluggable-Connector    http://${clusteringress}:6085"
echo
