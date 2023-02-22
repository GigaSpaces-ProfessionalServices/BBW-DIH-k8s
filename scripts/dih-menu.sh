#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
#########
clear
echo "DIH Management"
echo "--------------"
echo "Fetching clusters ..."
az aks list -o table
echo
read -p "Please provide a Cluster Name: " clustername
#config kubectl
az account set --subscription $ARM_SUBSCRIPTION_ID
az aks get-credentials --resource-group $resource_group_name --name $clustername --overwrite-existing
currenrCluster=$(kubectl config current-context)
source ./setEnv.sh

clear
echo "DIH Management"
echo "--------------"
echo "Cluster: [ $currenrCluster ]"
echo
echo "1. Install the generic DIH umbrella"
echo "2. Install the bbw use-case-1 umbrella"
echo "3. Install datadog agent"
echo "-----------------------------------------------------------------"
echo "4. Uninstall the generic DIH umbrella" 
echo "5. Uninstall the bbw use-case-1 umbrella"
echo "6. Uninstall datadog agent"
echo "7. Uninstall ALL"
echo "-----------------------------------------------------------------"
echo "B. Back to Main menu."
echo "E. Exit"
echo 
read -p ">> " choice

case "$choice" in
 
    1)  # Install the generic DIH umbrella
        $scripts_dir/install-dih-umbrella-generic.sh
        ;;
    
        # Install the bbw use-case-1 umbrella
    2)  $scripts_dir/install-bbw-uc-1.sh
        ;;
    
        # Install datadog agent
    3)  $scripts_dir/install-datadog.sh
        ;;

        # 
    4)  $scripts_dir/uninstall-dih-umbrella-generic.sh
        echo
        read -p "Enter any key to back to the menu..." key
        echo
        $work_dir/menu.sh
        ;;
    
    5)  $scripts_dir/uninstall-bbw-uc1.sh
        echo
        read -p "Enter any key to back to the menu..." key
        echo
        $work_dir/menu.sh
        ;;

    6)  $scripts_dir/uninstall-datadog.sh
        echo
        read -p "Enter any key to back to the menu..." key
        echo
        $work_dir/menu.sh
        ;;
    7)  $scripts_dir/uninstall-all-umbrellas.sh
        echo
        read -p "Enter any key to back to the menu..." key
        echo
        $work_dir/menu.sh
        ;;

    [Bb]) $work_dir/menu.sh
        ;;
    [eE]) exit
        ;;

    *)  $scripts_dir/dih-menu.sh
        ;;
esac