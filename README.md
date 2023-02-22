# BBW - DIH on azure

## Goal:
* Provision a k8s cluster in azure (AKS)
* Update kubeconfig with the new cluster
* Install the DIH umbrella + ingress and k8s dashboard
-----------
# Prerequisites
---------------
**You should use a predefined Jumper for azure**

----------
## Export the ARM variables
```
export ARM_CLIENT_ID="xxxxxxxxxxxx" <will be provided separately>
export ARM_CLIENT_SECRET="xxxxxxxxxxxx" <will be provided separately>
export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxx" <will be provided separately>
export ARM_TENANT_ID="xxxxxxxxxxxx" <will be provided separately>
```

# Create an AKS cluster (k8s on azure)

```
./create-aks-cluster.sh
```
###
Try to connect your AKS:
```
kubectl get all
```
To check the Availability Zones run:
```
./display_az.sh
```
```
    NAME                                  REGION   ZONE
    aks-bbwnodepool-33196474-vmss000000   eastus   eastus-2
    aks-bbwnodepool-33196474-vmss000001   eastus   eastus-3
    aks-bbwnodepool-33196474-vmss000002   eastus   eastus-1
```

---------------------------------------

# Deploy dih the umbrella

```
./install-dih-umbrella.sh
```

------------
# Undeply dih the umbrella
```
./uninstall-dih-umbrella.sh
```
-----------
# Destroy (delete) the AKS cluster
You can destroy the AKS cluster from azure portal or using Terraform:
```
./destroy-aks-cluster.sh
```

# Appendix: ingress-tcp ports

  |ingress port|namespace|serviceName|servicePort|
  |----|-------|-------------------|-----|
  |8090|default|xap-manager-service|8090|
  |3030|default|grafana|3000|
  |3000|default|bbw-dih-spacedeck|3000|
  |8080|default|kafka-ui|8080|
  |8081|default|bbw-kafka-producer-svc|8081|
  |6085|default|bbw-dih-pc-pluggable-connector|6085|
  |9000|kubernetes-dashboard|kubernetes-dashboard|443|
  |9092|default|influxdb-kapacitor-kapacitor|9092|
  |8086|default|influxdb|8086|
