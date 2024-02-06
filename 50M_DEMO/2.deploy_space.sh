#!/bin/bash
source ./demoEnv.sh
SPACE_MEM_LIMITS=$(printf "%.0f" $(echo "${SPACE_JAVA_HEAP} * 1.25" | bc))
echo "Deploying $SPACE_NAME space ..."
echo
helm install ${SPACE_NAME} ${DIH_HELM_REPO_NAME}/xap-pu --version ${DIH_XAP_PU_VERSION} \
--set partitions=${SPACE_PARTITIONS},instances=0,ha=${SPACE_HA},antiAffinity.enabled=true,java.heap="${SPACE_JAVA_HEAP}g",resources.limits.memory="${SPACE_MEM_LIMITS}Gi"
