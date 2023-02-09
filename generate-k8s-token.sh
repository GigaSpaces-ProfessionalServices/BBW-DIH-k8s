#!/bin/bash
### Create a token for k8s (used for k8s dashboard login)
echo
echo "Use this token to login k8s dashboard:"
echo "======================================"
echo
kubectl -n kubernetes-dashboard create token admin-user --duration=0s
echo
