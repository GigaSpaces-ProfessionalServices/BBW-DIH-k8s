#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

resource_group_name="csm-bbw"
clear
echo 
echo "Welcome to the DIH-azure-k8s provisioner"
echo "----------------------------------------"
echo
echo "Testing azure login status ..."
[[ $(az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID) ]] && (echo "logged in to azure.") || (echo "Unable to log in to azure.";exit)
echo
echo "Create a new AKS cluster:"
echo "========================="
echo
read -p "Cluster name: " clustername
read -p "Project: " project
read -p "Owner: " owner
read -p "Would like to install the dih umbrella? (y to install or any key to skip) " umbrella

if [[ "$umbrella" == [Yy]* ]]
then
    install_unbrella=0 # install umbrella
    echo "The dih umbrella will be installed."
else
    install_unbrella=1 # don't install umbrella
    echo "Skipping dih umbrella instalation."
fi

cp Terraform/variables.tmp Terraform/variables.tf
sed -i "s/_resource_group_name/$resource_group_name/g" Terraform/variables.tf
sed -i "s/_cluster_name/$clustername/g" Terraform/variables.tf
sed -i "s/_dns_prefix/$clustername/g" Terraform/variables.tf
sed -i "s/_log_analytcs_name/$clustername/g" Terraform/variables.tf
sed -i "s/_Owner/$owner/g" Terraform/variables.tf
sed -i "s/_Project/$project/g" Terraform/variables.tf

cd Terraform
terraform workspace new $clustername
terraform init
terraform plan -out ${clustername}.out
terraform apply ${clustername}.out
rm ${clustername}.out

#config kubectl
az account set --subscription $ARM_SUBSCRIPTION_ID
az aks get-credentials --resource-group $resource_group_name --name $clustername --overwrite-existing

if [[ $install_unbrella = 0 ]]
then
    ../install-dih-umbrella.sh
fi

