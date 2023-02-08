#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
read -r -p "Do you want to destroy your EKS lab ?[y/n] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
        
        ;;
    *)
        echo "Aborted."
        exit
        ;;
esac
./uninstall-dih-umbrella.sh
cd Terraform
terraform plan -destroy -out destroy.out
terraform apply "destroy.out"