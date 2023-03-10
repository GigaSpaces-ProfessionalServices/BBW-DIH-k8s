#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
source ./setEnv.sh

###############################
echo 
echo "Installing BBW-DIH umbrella on k8s cluster"
### Add helm repositories
helm repo add dih                $dih_helm_repo
helm repo add ingress-nginx      $ingress_helm_repo
helm repo add gigaspaces-repo-ea $dih_gs_ea
helm repo add kafka              $kafka
helm repo add kafka-ui           $kafka_ui
helm repo add influxdb-kapacitor $influxdb_kapacitor_helm

### Upadte helm repo
helm repo update

### Install ingress nginx
helm install ingress-nginx ingress-nginx/ingress-nginx -f $helm_dir/ingress-values.yaml

### Install the gs-dih umbrella
helm install bbw-dih gigaspaces-repo-ea/xap --version $dih_version -f $helm_dir/bbw-dih-managers.yaml

### Install k8s dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl apply -f $helm_dir/dashboard-adminuser.yaml
kubectl apply -f $helm_dir/clusterRoleBinding.yaml

### Install influxdb Kapacitor
helm install influxdb-kapacitor influxdata/kapacitor -f $helm_dir/kapacitor.yaml

### Install Kafka
helm install kafka kafka/kafka

### Install Kafka-ui
kubectl apply -f $helm_dir/kafka-ui-deployment.yaml
kubectl apply -f $helm_dir/kafka-ui-svc.yaml

### Install influxdb Kapacitor
helm install influxdb-kapacitor influxdb-kapacitor/kapacitor -f $helm_dir/kapacitor.yaml

### Print ingress IP/Ports
$scripts_dir/ingress-table-generic.sh

### Create k8s token for dashboard
$scripts_dir/generate-k8s-token.sh

echo
read -p "Enter any key to back to the menu..." key
echo
$work_dir/menu.sh
