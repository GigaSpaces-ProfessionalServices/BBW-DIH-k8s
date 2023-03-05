#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
###############################
source ./setEnv.sh
###############################

cd $work_dir
echo "Clonning BBW-Kafka-Producer git project ..."
git clone https://github.com/GigaSpaces-ProfessionalServices/BBW-Kafka-Producer.git
cd $kafka_producer_dir
git pull origin main
cd ..

### Deploy BBW space
echo "Waiting for the managers being available..."
# clusteringress=$(kubectl get svc ingress-nginx-controller |awk '{print $4}'|tail -1)
# until $(curl --output /dev/null --silent --head --fail http://${clusteringress}:8090); do
#     printf '.'
#     sleep 2
# done
helm install bbw-dih-space gigaspaces-repo-ea/xap-pu --version $dih_version -f $helm_dir/bbw-dih-space.yaml 

### Deploy the space with Mirror support
# helm install bbw-dih-space gigaspaces-repo-ea/xap-pu --version 16.3.0-m5 --set resourceUrl="https://aa-nihar-test.s3.us-east-2.amazonaws.com/bbw-dih/bbw-dih-space-0.1.jar",partitions=2,ha=true


### Deploy mirror pu (bbw-dih-mirror) 
#helm install bbw-dih-mirror gigaspaces-repo-ea/xap-pu --version 16.3.0-m5 --set resourceUrl="https://aa-nihar-test.s3.us-east-2.amazonaws.com/bbw-dih/bbw-dih-mirror-0.1.jar",instances=1,partitions=0

### Deploy BBW-kafka-producer
kubectl apply -f $kafka_producer_dir/configmap.yml
kubectl apply -f $kafka_producer_dir/kafka-producer-svc.yaml
kubectl apply -f $kafka_producer_dir/deployment.yaml

### Deploy BBW Pluggable connector
helm install bbw-dih-pc $kafka_producer_dir/helm-chart/pluggable-connector

$scripts_dir/ingress-table-uc-1.sh
echo
read -p "Enter any key to back to the menu..." key
echo
$work_dir/menu.sh