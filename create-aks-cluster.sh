#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

default_subscription_id="b5cedc24-5bf7-4266-a3c8-c8ab9149b4fe"
resource_group_name="csm-bbw"

echo 
echo "Welcome to the DIH-azure-k8s provisioner"
echo "----------------------------------------"
echo
#read -p "azure subscription-id [$default_subscription_id]: " newsubid
read -p "Cluster name: " clustername
read -p "Project: " project
read -p "Owner: " owner
read -p "Would like to install the dih umbrella? (y to install or any key to skip) " umbrella

if [[ -z $newsubid ]]
then 
    subscription_id=$default_subscription_id
else
    subscription_id=$newsubid
fi

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
terraform init
terraform plan -out ${clustername}.out
terraform apply ${clustername}.out

#config kubectl
az account set --subscription $subscription_id
az aks get-credentials --resource-group $resource_group_name --name $clustername

if [[ $install_unbrella = 0 ]]
then
    ../install-dih-umbrella.sh
fi

