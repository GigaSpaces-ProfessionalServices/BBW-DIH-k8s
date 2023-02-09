#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH

cd Terraform
terraform workspace list

read -p "Please enter your cluster name: " clustername
read -r -p "Are sure you want to destroy [ $clustername ] AKS cluster?[y/n] " response

case "$response" in
    [yY][eE][sS]|[yY]) 
        
        ;;
    *)
        echo "Aborted."
        exit
        ;;
esac

../uninstall-dih-umbrella.sh

terraform workspace select $clustername
terraform plan -destroy -out destroy-$clustername.out
terraform apply "destroy-$clustername.out"
terraform workspace select default
terraform workspace workspace delete $clustername
rm destroy-$clustername.out