#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
source ./setEnv.sh

### Create a token for k8s (used for k8s dashboard login)
echo
echo "Use this token to login k8s dashboard:"
echo "======================================"
echo
clustername=$(kubectl config current-context)
kubectl -n kubernetes-dashboard create token admin-user --duration=0s |tee $work_dir/k8s-dashboard-token-$clustername.txt
echo |tee -a $work_dir/k8s-dashboard-token-$clustername.txt
echo
echo
echo "The token can be found at: $work_dir/k8s-dashboard-token-$clustername.txt"