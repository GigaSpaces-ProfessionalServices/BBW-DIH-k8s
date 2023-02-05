# BBW-DIH-k8s

## Install Configure azure cli
https://learn.microsoft.com/en-us/cli/azure/

## Install and configure Terraform
https://developer.hashicorp.com/terraform/downloads?product_intent=terraform


## Provision an AKS (Azure k8s cluster) 

```
cd Terraform
```
Edit the variables.tf file
```
terraform init

terraform plan -out tfplan.out

terraform apply "tfplan.out"
```

## Set your local kubeconfig to your AKS
Find your subscription-id (currently we are working with 'support.gigaspaces.com')
```
az account subscription list
```

``` az account set --subscription "your-subscription-id" ```
```
az account set --subscription b5cedc24-5bf7-4266-a3c8-c8ab9149b4fe
```
``` az aks get-credentials --resource-group <your-resource-group> --name <your-AKS-cluster-name> ```
```
az aks get-credentials --resource-group csm-bbw-shmulik --name csm-bbw-shmulik
```
Output: ```Merged "csm-bbw-shmulik" as current context in /home/centos/.kube/config```

###
Try to connect your AKS:
```
kubectl get all
```
To check the Availability Zones run:
```
kubectl get nodes -o custom-columns=NAME:'{.metadata.name}',REGION:'{.metadata.labels.topology\.kubernetes\.io/region}',ZONE:'{metadata.labels.topology\.kubernetes\.io/zone}'
```
```
NAME                                  REGION   ZONE
aks-bbwnodepool-33196474-vmss000000   eastus   eastus-2
aks-bbwnodepool-33196474-vmss000001   eastus   eastus-3
aks-bbwnodepool-33196474-vmss000002   eastus   eastus-1
```

---------------------------------------

## Destroy (delete) an AKS
```
cd Terraform

terraform plan -destroy -out tfplan-destroy.out

terraform apply "tfplan-destroy.out"
```


