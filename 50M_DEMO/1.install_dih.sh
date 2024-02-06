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
helm upgrade --install ${DIH_HELM_CHART_NAME} ./${DIH_HELM_CHART_NAME} --version ${DIH_XAP_VERSION} --devel -f dih-values.yaml \
--set tags.iidr=${IIDR_ENABLED} \
--set manager.license=${DIH_LICENSE} \
--set operator.license=${DIH_LICENSE} \
--set manager.ha=${MANAGER_HA} \
--set global.security.enabled=${GLOBAL_SECURITY_ENABLED} \
--set global.password=${GLOBAL_SECURITY_PASS} \
--set global.s3.enabled=${GLOBAL_S3_ENABLED}  \
--set global.flink.highAvailability.enabled=${GLOBAL_FLINK_HA_ENABLED}


