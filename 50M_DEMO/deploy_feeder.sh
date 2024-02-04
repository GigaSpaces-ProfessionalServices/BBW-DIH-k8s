#!/bin/bash
source ./demoEnv.sh
#INGRESS=$(kubectl get svc ingress-nginx-controller -o json | jq -r .status.loadBalancer.ingress[].ip)
#OBJECT_NAME=BBW.ORDER

# Create an object space
#curl -X GET --header 'Accept: application/json' \
#"http://${INGRESS}:8090/v2/internal/spaces/${SPACE_NAME}/expressionquery?expression=CREATE%20TABLE%20%22${OBJECT_NAME}%22%20(%20%20%20%20%20EMP_ID%20INT%20PRIMARY%20KEY%2C%20%20%20%20%20FIRST_NAME%20VARCHAR(50)%2C%20%20%20%20%20LAST_NAME%20VARCHAR(50)%2C%20%20%20%20%20PHONE_NUMBER%20VARCHAR(40)%2C%20%20%20%20%20ADDRESS%20VARCHAR(100)%2C%20%20%20%20%20IS_MANAGER%20CHAR(1)%2C%20%20%20%20%20DEPARTMENT_CODE%20CHAR(1)%2C%20%20%20%20%20COMMENTS%20CHAR(30)%20)&withExplainPlan=false&ramOnly=true"

# Install feeder xap-pu
kubectl create configmap oracle-feeder-cm --from-file oracle-feeder-configmap.yaml 
kubectl apply -f ./oracle-feeder-service.yaml
helm upgrade --install oracle-feeder dihrepo/xap-pu --version 16.4.0 -f helm_feeder.yaml

