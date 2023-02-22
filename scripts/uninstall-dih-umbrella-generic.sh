#!/bin/bash
source ./setEnv.sh

kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl delete -f $helm_dir/clusterRoleBinding.yaml
helm uninstall bbw-dih
helm uninstall ingress-nginx
helm uninstall kafka
kubectl delete -f $helm_dir/kafka-ui-deployment.yaml
kubectl delete -f $helm_dir/kafka-ui-svc.yaml
