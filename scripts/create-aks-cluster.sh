#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
#######
resource_group_name="csm-bbw"
#######
# work_dir=~/BBW-DIH-k8s
# script_dir=$work_dir/scripts
# helm_dir=$work_dir/helm
# kafka_producer_dir=$work_dir/BBW-Kafka-Producer
source ./setEnv.sh
#######

clear
echo "Create a new AKS cluster:"
echo "========================="
echo "Testing azure login status ..."
[[ $(az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID) ]] && (echo "Login successful.") || (echo "Unable to log in to azure. Please validate ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_SUBSCRIPTION_ID, ARM_TENANT_ID.";exit)
echo

echo
read -p "Cluster name: " clustername
read -p "Project: " project
read -p "Owner: " owner
echo
read -p "Are you sure you want to create a new AKS cluster named [$clustername] ? [y/n]" confirm
case "$confirm" in
    [yY]) echo "Creating a new AKS cluster [$clustername]."
          sleep 1        
        ;;

    *) echo "Creating AKS cluster aborted"
       exit
        ;;
esac

cp $work_dir/Terraform/variables.tmp $work_dir/Terraform/variables.tf
sed -i "s/_resource_group_name/$resource_group_name/g" $work_dir/Terraform/variables.tf
sed -i "s/_cluster_name/$clustername/g" $work_dir/Terraform/variables.tf
sed -i "s/_dns_prefix/$clustername/g" $work_dir/Terraform/variables.tf
sed -i "s/_log_analytcs_name/$clustername/g" $work_dir/Terraform/variables.tf
sed -i "s/_Owner/$owner/g" $work_dir/Terraform/variables.tf
sed -i "s/_Project/$project/g" $work_dir/Terraform/variables.tf

cd $work_dir/Terraform
terraform workspace new ws-$clustername
terraform init
terraform plan -out ${clustername}.out
terraform apply ${clustername}.out
rm ${clustername}.out

$work_dir/menu.sh

