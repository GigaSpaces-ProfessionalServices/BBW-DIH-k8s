#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
echo 
echo "Installing DIH umbrella on k8s cluster"

### Add helm repositories
helm repo add gigaspaces https://resources.gigaspaces.com/helm-charts
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

### Install the gs-dih umbrella
helm install xap gigaspaces/xap --version 16.2.1 -f helm/gigaspaces.yaml

### Install k8s dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl apply -f helm/dashboard-adminuser.yaml
kubectl apply -f helm/clusterRoleBinding.yaml
kubectl apply -f helm/ingress-rule-dashbord.yaml

### Install ingress nginx
helm install ingress-nginx ingress-nginx/ingress-nginx -f helm/ingress-values.yaml

### Create k8s token for dashboard
./create-k8s-token.sh

### To find out your ingress public IP
kubectl get svc ingress-nginx-controller |awk '{print $4}'|tail -1 > k8s-ingress-ip.txt
echo =========================================
echo "GUI url list:"
echo "-------------
ops-manager:     http://$(cat k8s-ingress-ip.txt):8090
grafana:         http://$(cat k8s-ingress-ip.txt):3000
k8s dashboard:   https://$(cat k8s-ingress-ip.txt)
=========================================

You can find the k8s token at: k8s-token.txt

"
echo "To login to k8s dashboard use this token:"
echo
cat k8s-token.txt


