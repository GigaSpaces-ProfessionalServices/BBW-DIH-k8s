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
az aks list -o table
echo
read -p "Please provide a Cluster Name: " clustername
#config kubectl
az account set --subscription $ARM_SUBSCRIPTION_ID
az aks get-credentials --resource-group $resource_group_name --name $clustername --overwrite-existing
echo
kubectl config current-context

cd $work_dir
echo "Clonning BBW-Kafka-Producer git project ..."
git clone https://github.com/GigaSpaces-ProfessionalServices/BBW-Kafka-Producer.git
cd $kafka_producer_dir
git pull origin main
cd ..

### Deploy BBW space
clusteringress=$(kubectl get svc ingress-nginx-controller |awk '{print $4}'|tail -1)
until $(curl --output /dev/null --silent --head --fail http://${clusteringress}:8090); do
    printf '.'
    sleep 2
done
helm install bbw-dih-space gigaspaces-repo-ea/xap-pu --version $dih_version #-f $helm_dir/bbw-dih-space.yaml

### Deploy BBW-kafka-producer
kubectl apply -f $kafka_producer_dir/configmap.yml
kubectl apply -f $kafka_producer_dir/kafka-producer-svc.yaml
kubectl apply -f $kafka_producer_dir/deployment.yaml

### Deploy BBW Pluggable connector
helm install bbw-dih-pc $kafka_producer_dir/helm-chart/pluggable-connector

$script_dir/ingress-table-uc-1.sh
echo
read -p "Enter any key to back to the menu..." key
echo
$work_dir/menu.sh