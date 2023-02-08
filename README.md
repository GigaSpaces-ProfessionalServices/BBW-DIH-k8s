# BBW - DIH on azure

## Prerequisites
---------------
**You can create a predefined Jumper VM in azure, with all the required tools**

---------------
### Install jumper tools using a script (for centos/redhat)
```
./install-jumper-tools.sh
```
----------
## Export the ARM variables
```
export ARM_CLIENT_ID="xxxxxxxxxxxx" <will be provided separately>
export ARM_CLIENT_SECRET="xxxxxxxxxxxx" <will be provided separately>
export ARM_SUBSCRIPTION_ID="xxxxxxxxxxxx" <will be provided separately>
export ARM_TENANT_ID="xxxxxxxxxxxx" <will be provided separately>
```

## Create an AKS cluster (k8s on azure)

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
## Destroy (delete) the AKS cluster
You can destroy the AKS cluster from azure portal or using Terraform:
```
./destroy-aks-cluster.sh
```

