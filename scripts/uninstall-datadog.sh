#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
###########
# work_dir=~/BBW-DIH-k8s
# script_dir=$work_dir/scripts
# helm_dir=$work_dir/helm
# kafka_producer_dir=$work_dir/BBW-Kafka-Producer
source ./setEnv.sh
###########
echo "Fetching clusters ..."
az aks list -o table
echo
read -p "Please provide the Cluster Name to remove the umbrellas: " clustername
#config kubectl
az account set --subscription $ARM_SUBSCRIPTION_ID
az aks get-credentials --resource-group $resource_group_name --name $clustername --overwrite-existing
echo
kubectl config current-context

### Create k8s secret for bbw-demo datadog account
kubectl delete secret datadog-secret

### Install datadog agent
helm uninstall bbw-datadog-agent

echo
read -p "Enter any key to back to the menu..." key
echo
$work_dir/menu.sh