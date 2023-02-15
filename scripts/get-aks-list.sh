#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
###############################
dih_version=16.3.0-m5
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
az aks list
echo
read -p "Enter any key to back to the menu..." key
echo
$work_dir/menu.sh