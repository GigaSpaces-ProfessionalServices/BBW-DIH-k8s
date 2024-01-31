#!/bin/bash
kubectl create secret docker-registry myregistrysecret --docker-server=https://index.docker.io/v1/ --docker-username=dihcustomers --docker-password=dckr_pat_NYcQySRyhRFZ6eUQAwLsYm314QA --docker-email=dih-customers@gigaspaces.com

helm repo add dihrepo https://s3.amazonaws.com/resources.gigaspaces.com/helm-charts-dih
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx -f ./ingress-controller-tcp.yaml

helm upgrade --install dih dihrepo/dih --version 16.4.0 --devel \
--set tags.iidr=false \
--set manager.license="Product=InsightEdge;Version=16.4;Type=ENTERPRISE;Customer=Gigaspaces_R&D_DI_DEV;Expiration=2025-Dec-31;Hash=QROtPGzkRIRPMV84YXOU" \
--set operator.license="Product=InsightEdge;Version=16.4;Type=ENTERPRISE;Customer=Gigaspaces_R&D_DI_DEV;Expiration=2025-Dec-31;Hash=QROtPGzkRIRPMV84YXOU" \
--set manager.ha=true \
--set global.security.enabled=false \
--set global.password=Shmulik1! \
--set global.s3.enabled=false 

kubectl apply -f ./feeder_service.yaml

