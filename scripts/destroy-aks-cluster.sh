#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
###########
# work_dir=~/BBW-DIH-k8s
# script_dir=$work_dir/scripts
# helm_dir=$work_dir/helm
# kafka_producer_dir=$work_dir/BBW-Kafka-Producer
source ./setEnv.sh
###########

cd $work_dir/Terraform
terraform workspace list

read -p "Please enter your cluster workspace name: " clustername
read -r -p "Are sure you want to destroy [ $clustername ] AKS cluster? [y/n] " response

case "$response" in
    [yY][eE][sS]|[yY]) 
        
        ;;
    *)
        echo "Aborted."
        exit
        ;;
esac

terraform workspace select $clustername
terraform plan -destroy -out destroy-$clustername.out
terraform apply "destroy-$clustername.out"
terraform workspace select default
terraform workspace workspace delete $clustername
rm destroy-$clustername.out
mv $work_dir/Terraform/terraform.tfstate.d/$clustername ../old_states

echo
read -p "Enter any key to back to the menu..." key
echo
$work_dir/menu.sh