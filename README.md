# BBW - DIH on azure

## Goal:
* Installing the DIH BBW-Use-Case-1 umbrella.
# Prerequisites
* git clone this project https://github.com/GigaSpaces-ProfessionalServices/azure-aks-builder and follow the readme to install the full DIH 16.3-GA umbrella.

# Install BBW Use Case
git clone this project https://github.com/GigaSpaces-ProfessionalServices/BBW-DIH-k8s to install the bbw use-cases.

* Update the setEnv.sh

To provide credentials for azure and datadog please update the BBW-DIH-k8s/scripts/setEnv.sh with your environment details:

```
### Azure 
export resource_group_name=""
export ARM_CLIENT_ID=""
export ARM_CLIENT_SECRET=""
export ARM_SUBSCRIPTION_ID=""
export ARM_TENANT_ID=""
```
```
### datadog integration bbw-demo
export datadog_api_key=""
export datadog_app_key=""
```

# Update the ingress TCP list

* To expose the pluggable connector and kafka producer ports in ingress-controller, edit the ingress-tcp.yaml  
and add the following lines in the TCP section:
```
tcp:
   8081: "default/bbw-kafka-producer-svc:8081"
   6085: "default/bbw-dih-pc-pluggable-connector:6085" 
```   
Save the file and run this command:

```
helm upgrade ingress-nginx ingress-nginx/ingress-nginx -f <path-to-ingress-tcp.yaml>
```
For example:
```
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx -f ~/azure-aks-builder/DIH/helm/ingress-controller-tcp.yaml
```   

* To install the ingress-controller as an internal LB, you need to enable the appropriate annotation, depends on your vendor (aws, azure)
  
At the ingress-controller-tcp.yaml file, uncomment the relevant section:

```
### Azure ###

# controller:
#  service:
#    annotations:
#        service.beta.kubernetes.io/azure-load-balancer-internal: true
```
```
### AWS ###

# controller:
#     service:
#       external:
#         enabled: false
#       internal:
#         enabled: true
#         annotations:
#           service.beta.kubernetes.io/aws-load-balancer-internal: "true"
#           service.beta.kubernetes.io/aws-load-balancer-additional-resource-tags: Owner=owner,Project=project, Name=project-ingress-LB-internal

```

If you modified the ingress-controller-tcp.yaml after the ingress-controller deployed, you will have to reinstall the ingress-controller:
```
helm upgrade --install ingress-nginx ingress-nginx/ingress-nginx -f <path-to-ingress-tcp.yaml>
```

# Run the dih-builder for bbw

```
cd BBW-DIH-k8s
./dih-builder.sh
```
```
Login to azure ...
Login succeeded.
Fetching clusters ...
Name       Location    ResourceGroup    KubernetesVersion    CurrentKubernetesVersion    ProvisioningState    Fqdn
---------  ----------  ---------------  -------------------  --------------------------  -------------------  ------------------------------------------------------
bbw-demo1  eastus      csm-bbw          1.25.6               1.25.6                      Succeeded            bbw-demo1-csm-bbw-b5cedc-kmd4wn85.hcp.eastus.azmk8s.io
Nihar      eastus      csm-bbw          1.24.9               1.24.9                      Succeeded            nihar-bea48be6.hcp.eastus.azmk8s.io

Enter the cluster name to set as the current context: e/E to exit)
>> bbw-demo1
```
```
Updating kube config file for [ bbw-demo1 ] cluster ...
Merged "bbw-demo1" as current context in /home/centos/.kube/config
Current context: bbw-demo1
```
```
Welcome to DIH Builder on Azure!
--------------------------------
Subscription: support.gigaspaces.com
Client ID: 49664c5d-130b-4463-b538-506f85f3ba0d
Resource Group: csm-bbw

## To change the above details, edit setEnv.sh and restart the dih-builder.sh ##

DIH management [ bbw-demo1 ]
------------------------

1. Install use-case-1
2. Install datadog agent
------------------------
3. Uninstall use-case-1
4. Uninstall datadog

E. Exit

>>
```