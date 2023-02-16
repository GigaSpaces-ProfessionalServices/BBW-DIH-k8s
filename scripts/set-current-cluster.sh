#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
###############################
source ./setEnv.sh

dih_helm_repo=https://s3.amazonaws.com/resources.gigaspaces.com/helm-charts-dih
dih_gs_ea=https://resources.gigaspaces.com/helm-charts-ea
ingress_helm_repo=https://kubernetes.github.io/ingress-nginx

resource_group_name=csm-bbw
###############################
echo "Testing azure login status ..."
[[ $(az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID) ]] && (echo "Login successful.") || (echo "Unable to log in to azure. Please validate ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID.";exit)
echo

echo "Fetching clusters ..."
az aks list -o table
echo 
echo  "To set the cluster as the current cluster, enter its name: (or enter E to exit)"
read -p ">> " clustername 

case "$clustername" in

    [eE])  $work_dir/menu.sh
           ;;

       *)  az account set --subscription $ARM_SUBSCRIPTION_ID
           az aks get-credentials --resource-group $resource_group_name --name $clustername --overwrite-existing
           echo
           echo "The cluster [ $clustername ] has been set as current cluster."
           echo
           read -p "Enter any key to back to the menu..." key
           $work_dir/menu.sh
           ;;
esac
