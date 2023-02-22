#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
###########
source ./setEnv.sh
###########

### Delete k8s secret for bbw-demo datadog account
kubectl delete secret datadog-secret

### Delete datadog agent
helm uninstall bbw-datadog-agent
