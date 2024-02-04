#!/bin/bash
source ./demoEnv.sh
# Create secrets for dockerhub
kubectl create secret docker-registry myregistrysecret --docker-server=${GS_REGISTRY_SERVER} --docker-username=${GS_REGISTRY_USER} --docker-password=${GS_REGISTRY_PASS} --docker-email=${GS_REGISTRY_EMAIL}

# Create and update helm repositories
helm repo add ${DIH_HELM_REPO_NAME} ${DIH_HELM_REPO_URL}
helm repo add ${INGRESS_CNTRL_HELM_REPO_NAME} ${INGRESS_CNTRL_HELM_REPO_URL}
helm repo update

# Install ingress controller and configure TCP services ports
helm upgrade --install ${INGRESS_CNTRL_HELM_CHART_NAME} ${INGRESS_CNTRL_HELM_REPO_NAME}/${INGRESS_CNTRL_HELM_CHART_NAME} -f ./ingress-controller-tcp.yaml

# Install dih-umbrella
helm upgrade --install ${DIH_HELM_CHART_NAME} ${DIH_HELM_REPO_NAME}/${DIH_HELM_CHART_NAME} --version ${DIH__XAP_VERSION} --devel \
--set tags.iidr=${IIDR_ENABLED} \
--set manager.license=${DIH_LICENSE} \
--set operator.license=${DIH_LICENSE} \
--set manager.ha=${MANAGER_HA} \
--set global.security.enabled=${GLOBAL_SECURITY_ENABLED} \
--set global.password=${GLOBAL_SECURITY_PASS} \
--set global.s3.enabled=${GLOBAL_S3_ENABLED}


# Deploy a space

while [[ $(kubectl get pods |grep xap-operator |wc -l) -ne 1 ]];do
  echo -ne '#'
  sleep 5
done
sleep 5
./deploy_space.sh
