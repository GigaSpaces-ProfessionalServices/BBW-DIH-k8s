#!/bin/bash
### Create a token for k8s (used for k8s dashboard login)
kubectl -n kubernetes-dashboard create token admin-user --duration=0s > k8s-token.txt
echo "" >> k8s-token.txt
cat k8s-token.txt