#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
source ./setEnv.sh


bbwDihMenu () {
  clear
  echo "Welcome to DIH Builder on Azure!"
  echo "--------------------------------"
  echo Subscription: $SUBSCRIPTION_NAME
  echo Client ID: $LOGGEDIN_USER
  echo Resource Group: $REASOURCE_GROUP
  echo
  echo "## To change the above details, edit setEnv.sh and restart the dih-builder.sh ##"
  echo
  echo "DIH management [ $CLUSTER_NAME ]"
  echo "------------------------"
  echo
  echo "1. Install use-case-1"
  echo "2. Install datadog agent"
  echo "------------------------"
  echo "3. Uninstall use-case-1"
  echo "4. Uninstall datadog"
  echo
  echo "E. Exit"
  echo 
  read -p ">> " choice

  case "$choice" in
      1) installUC1
         bbwDihMenu  
          ;;

      2) installDataDog  
         bbwDihMenu  
          ;;
      
      3) unInstallUC1
         bbwDihMenu  
          ;;
      
      4) unInstallDatadog
         bbwDihMenu  
          ;;
            
      [eE]) exit
          ;;

      *) bbwDihMenu
          ;;
  esac

}

chooseExistingAKS () {
  echo "Fetching clusters ..."
  az aks list --resource-group $REASOURCE_GROUP -o table
  echo 
  echo  "Enter the cluster name to set as the current context: e/E to exit)"
  read -p ">> " CLUSTER_NAME
  if [[ $CLUSTER_NAME = "E" ]] || [[ $CLUSTER_NAME = "e" ]]
  then 
    exit 
  fi
  if [[ $(az aks list -g $REASOURCE_GROUP -o json --query "[?name=='$CLUSTER_NAME'] | length(@)") = 1 ]]
    then 
      updateKubeConfig
    else
      echo "$CLUSTER_NAME cluster does not exist"
      chooseExistingAKS
  fi
}

updateKubeConfig () {
  echo "Updating kube config file for [ $CLUSTER_NAME ] cluster ..."
  az account set --subscription $ARM_SUBSCRIPTION_ID
  az aks get-credentials --resource-group $REASOURCE_GROUP --name $CLUSTER_NAME --overwrite-existing
  echo "Current context: $(kubectl config current-context)"
}

loginAzureAccount () {
    echo "Login to azure ..."
  if [[ $(az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID) ]]
  then
    echo "Login succeeded."
    LOGGEDIN_USER=$(az account list --query "[?isDefault].user.name" -o tsv)
    SUBSCRIPTION_NAME=$(az account list --query "[?isDefault].name" -o tsv)
    
  else
    echo "Login failed, please make sure you set the correct ARM_CLIENT_ID ARM_CLIENT_SECRET ARM_TENANT_ID variables and try again."
    exit;
  fi
}

installDataDog () {
  ### Add datadog helm repo
  helm repo add datadog https://helm.datadoghq.com
  helm repo update datadog

  ### Create k8s secret for bbw-demo datadog account
  kubectl create secret generic datadog-secret --from-literal api-key=$datadog_api_key --from-literal app-key=$datadog_app_key

  ### Install datadog agent
  helm install bbw-datadog-agent datadog/datadog -f helm/datadog.yaml

  echo
  read -p "Enter any key to back to the menu..." key
  echo
  bbwDihMenu
}

installUC1 () {
  echo "Clonning BBW-Kafka-Producer git project ..."
  git clone https://github.com/GigaSpaces-ProfessionalServices/BBW-Kafka-Producer.git
  cd BBW-Kafka-Producer
  git pull origin main
  cd ..

  ### Deploy BBW space
  echo "Waiting for the managers being available..."
  clusteringress=$(kubectl get svc ingress-nginx-controller -o json | jq -r .status.loadBalancer.ingress[].ip)
  until $(curl --output /dev/null --silent --head --fail http://${clusteringress}:8090); do
      printf '.'
      sleep 2
  done
  
  helm repo add dih $DIH_HELM_REPO
  helm repo update dih
  echo "Deploying bbw-dih-space ..."
  helm install bbw-dih-space dih/xap-pu --version $DIH_HELM_CHART -f helm/bbw-dih-space.yaml
  
  ### Deploy BBW-kafka-producer
  kubectl apply -f BBW-Kafka-Producer/configmap.yml
  kubectl apply -f BBW-Kafka-Producer/kafka-producer-svc.yaml
  kubectl apply -f BBW-Kafka-Producer/deployment.yaml

  ### Deploy BBW Pluggable connector
  helm install bbw-dih-pc BBW-Kafka-Producer/helm-chart/pluggable-connector
  
  echo
  printIngressTCP

  read -p "Enter any key to back to the menu >> " key
}

installKapacitor () {
  helm repo add influxdb-kapacitor https://helm.influxdata.com
  echo "Deploying influxDB Kapacitor ..."
  helm install influxdb-kapacitor influxdb-kapacitor/kapacitor -f helm/kapacitor.yaml
  bbwDihMenu
}

printIngressTCP () {
  echo "Ingress exposed TCP ports:"
  echo ----------------------------------------------------------------------
  cat ~/azure-aks-builder/DIH/helm/ingress-controller-tcp.yaml  |grep default |tr -d '"' |tr -d ' '|sed 's/:default\// --> /' |cut -d':' -f1 |sed -e "s/^/$clusteringress:/"
  echo ----------------------------------------------------------------------
  echo
}

unInstallUC1 () {
  
  kubectl delete -f BBW-Kafka-Producer/configmap.yml
  kubectl delete -f BBW-Kafka-Producer/kafka-producer-svc.yaml
  kubectl delete -f BBW-Kafka-Producer/deployment.yaml

  helm uninstall bbw-dih-space
  helm uninstall bbw-dih-pc
  read -p "Enter any key to back to the menu >> " key
}

unInstallDatadog () {
  ### Delete k8s secret for bbw-demo datadog account
  kubectl delete secret datadog-secret

  ### Delete datadog agent
  helm uninstall bbw-datadog-agent
  read -p "Enter any key to back to the menu >> " key
}

##### Main #####
clear
loginAzureAccount
chooseExistingAKS
bbwDihMenu





