#!/bin/bash
source ./demoEnv.sh
echo "Waiting for xap-operator to be available before deploying the space ..."
while [[ $(kubectl get pods |grep xap-operator |grep -i running |wc -l) -ne 1 ]];do
  echo -ne '#'
  sleep 5
done
sleep 3

echo "Deploying $SPACE_NAME space ..."
echo
helm install ${SPACE_NAME} ${DIH_HELM_REPO_NAME}/xap-pu --version ${DIH_XAP_PU_VERSION} \
--set partitions=${SPACE_PARTITIONS},instances=0,ha=${SPACE_HA},antiAffinity.enabled=true,java.heap="${SPACE_JAVA_HEAP}g",resources.limits.memory="${SPACE_MEM_LIMITS}Gi"

echo "Waiting for $SPACE_NAME space to be available ..."
while true; do
    if [[ $(kubectl get pods | grep $SPACE_NAME | wc -l) -eq $(( $SPACE_PARTITIONS * 2 )) ]]; then
        echo "Space is ready"
        break
    fi
    sleep 5  # Adjust sleep duration as needed
done

