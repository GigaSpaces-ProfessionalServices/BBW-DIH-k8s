#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
source ./setEnv.sh

echo "Fetching clusters ..."
az aks list
echo
read -p "Please provide the Cluster Name to remove the umbrellas: " clustername
#config kubectl
az account set --subscription $ARM_SUBSCRIPTION_ID
az aks get-credentials --resource-group $resource_group_name --name $clustername --overwrite-existing
echo
kubectl config current-context

$script_dir/uninstall-dih-umbrella-generic.sh
$script_dir/uninstall-bbw-uc1.sh