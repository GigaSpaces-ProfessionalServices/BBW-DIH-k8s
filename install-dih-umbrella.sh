#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

echo 
echo "Installing DIH umbrella on k8s cluster"

### Add helm repositories
helm repo add gigaspaces https://resources.gigaspaces.com/helm-charts
helm repo add gigaspaces-ea https://resources.gigaspaces.com/helm-charts-ea
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

### Install the gs-dih umbrella
helm install xap gigaspaces-ea/xap --version 16.3.0-m6 -f helm/gigaspaces.yaml --set spacedeck.image.tag=1.0.21
#kubectl config set-context --current --namespace=$namespace

### Install k8s dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl apply -f helm/dashboard-adminuser.yaml
kubectl apply -f helm/clusterRoleBinding.yaml
kubectl apply -f helm/ingress-rule-dashbord.yaml

### Install ingress nginx
helm install ingress-nginx ingress-nginx/ingress-nginx -f helm/ingress-values.yaml

### Create k8s token for dashboard
./generate-k8s-token.sh

### To find out your ingress public IP
./get-ui-url.sh

