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

### Add datadog helm repo
helm repo add datadog $datadog_helm
helm repo update datadog

### Create k8s secret for bbw-demo datadog account
kubectl create secret datadog-secret --from-literal $datadog_api_key

### Install datadog agent
helm install bbw-datadog-agent datadog/datadog -f $helm_dir/datadog.yaml

echo
read -p "Enter any key to back to the menu..." key
echo
$work_dir/menu.sh