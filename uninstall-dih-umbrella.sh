#!/bin/bash
kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl delete -f helm/dashboard-adminuser.yaml
kubectl delete -f helm/clusterRoleBinding.yaml
kubectl delete -f helm/ingress-rule-dashbord.yaml
helm uninstall xap ingress-nginx
