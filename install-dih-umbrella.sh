#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
###############################
dih_version=16.3.0-m5
dih_helm_repo=https://s3.amazonaws.com/resources.gigaspaces.com/helm-charts-dih
dih_gs_ea=https://resources.gigaspaces.com/helm-charts-ea
ingress_helm_repo=https://kubernetes.github.io/ingress-nginx
###############################

echo "Clonning BBW-Kafka-Producer git project ..."
git clone https://github.com/GigaSpaces-ProfessionalServices/BBW-Kafka-Producer.git
cd BBW-Kafka-Producer
git pull origin main
cd ..

echo 
echo "Installing BBW-DIH umbrella on k8s cluster"
### Add helm repositories
helm repo add dih $dih_helm_repo
helm repo add ingress-nginx $ingress_helm_repo
helm repo add gigaspaces-repo-ea $dih_gs_ea
helm repo update

### Install the gs-dih umbrella
helm install bbw-dih dih/di-pipeline --version $dih_version -f helm/gigaspaces.yaml
#kubectl config set-context --current --namespace=$namespace


### Deploy BBW-kafka-producer
kubectl apply -f BBW-Kafka-Producer/configmap.yml
kubectl apply -f BBW-Kafka-Producer/kafka-producer-svc.yaml
kubectl apply -f BBW-Kafka-Producer/deployment.yaml

### Install k8s dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
kubectl apply -f helm/dashboard-adminuser.yaml
kubectl apply -f helm/clusterRoleBinding.yaml
kubectl apply -f helm/ingress-rule-dashbord.yaml

### Install ingress nginx
helm install ingress-nginx ingress-nginx/ingress-nginx -f helm/ingress-values.yaml
echo "Waiting for ingress Public IP ..."
sleep 5

### Deploy BBW space
clusteringress=$(kubectl get svc ingress-nginx-controller |awk '{print $4}'|tail -1)
while [ $(/usr//bin/curl -s -o /dev/null -w %{http_code} http://${clusteringress}:8090/) -eq 000 ] ; do
  echo -e $(date) " Ops Manager HTTP state: " $(/usr/bin/curl -s -o /dev/null -w %{http_code} http://${clusteringress}:8090/) " (waiting for 200)"
  sleep 3
done

helm install bbw-dih-space gigaspaces-repo-ea/xap-pu --version $dih_version

### Print ingress IP/Ports
./ingress-table.sh

### Create k8s token for dashboard
./generate-k8s-token.sh

