#!/bin/bash
# work_dir=~/BBW-DIH-k8s
# script_dir=$work_dir/scripts
# helm_dir=$work_dir/helm
# kafka_producer_dir=$work_dir/BBW-Kafka-Producer
# #########
source scripts/setEnv.sh
clear
echo "Welcome to DIH Builder on Azure!"
echo "--------------------------------"
echo
echo "1. Set a current AKS cluster"
echo "2. Create a new AKS cluster"
echo "3. Install the generic DIH umbrella on an existing AKS cluster"
echo "4. Install the bbw use-case-1 umbrella on an existing AKS cluster"
echo "5. Uninstall Menu"
echo "E. Exit"
echo 
read -p ">> " choice

case "$choice" in
    1) $script_dir/set-current-cluster.sh   
        ;;
    
    2) $script_dir/create-aks-cluster.sh        
        ;;

    3)  echo "Install the generic DIH umbrella on an existing AKS cluster"
        $script_dir/install-dih-umbrella-generic.sh
        ;;
    
    4)  echo "Install the bbw use-case-1 umbrella on an existing AKS cluster"
        $script_dir/install-bbw-uc-1.sh
        ;;
    
    5) $script_dir/uninstall-menu.sh
        ;;

    [eE]) exit
        ;;

    *) $work_dir/menu.sh
        ;;
esac