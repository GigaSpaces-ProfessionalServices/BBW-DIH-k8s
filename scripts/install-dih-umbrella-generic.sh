#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
###############################
dih_version=16.3.0-m5
helm_chart="dih/di-pipeline"
work_dir=~/BBW-DIH-k8s
script_dir=$work_dir/scripts
helm_dir=$work_dir/helm
kafka_producer_dir=$work_dir/BBW-Kafka-Producer

dih_helm_repo=https://s3.amazonaws.com/resources.gigaspaces.com/helm-charts-dih
dih_gs_ea=https://resources.gigaspaces.com/helm-charts-ea
ingress_helm_repo=https://kubernetes.github.io/ingress-nginx

resource_group_name=csm-bbw
###############################
echo "Fetching clusters ..."
az aks list -o table
echo
read -p "Please provide a Cluster Name: " clustername
#config kubectl
az account set --subscription $ARM_SUBSCRIPTION_ID
az aks get-credentials --resource-group $resource_group_name --name $clustername --overwrite-existing
echo
kubectl config current-context

echo 
echo "Installing BBW-DIH umbrella on k8s cluster"
### Add helm repositories
helm repo add dih $dih_helm_repo
helm repo add ingress-nginx $ingress_helm_repo
helm repo add gigaspaces-repo-ea $dih_gs_ea
helm repo update

### Install the gs-dih umbrella
helm install bbw-dih $helm_chart --version $dih_version -f $helm_dir/gigaspaces.yaml

### Install k8s dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl apply -f $helm_dir/dashboard-adminuser.yaml
kubectl apply -f $helm_dir/clusterRoleBinding.yaml
kubectl apply -f $helm_dir/ingress-rule-dashbord.yaml

### Install ingress nginx
helm install ingress-nginx ingress-nginx/ingress-nginx #-f $helm_dir/ingress-values.yaml
echo "Waiting for ingress Public IP ..."
sleep 5

### Print ingress IP/Ports
$script_dir/ingress-table-generic.sh

### Create k8s token for dashboard
$script_dir/generate-k8s-token.sh

### Get grafana admin password
$script_dir/get-grafana-pass.sh

echo
read -p "Enter any key to back to the menu..." key
echo
$work_dir/menu.sh
