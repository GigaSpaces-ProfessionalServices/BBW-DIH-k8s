#!/bin/bash
# work_dir=~/BBW-DIH-k8s
# script_dir=$work_dir/scripts
# helm_dir=$work_dir/helm
# kafka_producer_dir=$work_dir/BBW-Kafka-Producer
source ./setEnv.sh

echo
echo "Uninstall Menu"
echo "------------------------------------"
echo
echo "1. Uninstall the generic DIH umbrella"
echo "2. Uninstall the bbw use-case-1 umbrella"
echo "3. Uninstall all (will remove everything from the AKS)"
echo "4. Destroy AKS Cluster"
echo "5. Uninstall datadog agent"
echo "E. Exit"
echo 
read -p ">> " choice

case "$choice" in
    1) $script_dir/uninstall-dih-umbrella-generic.sh
        echo
read -p "Enter any key to back to the menu..." key
echo
$work_dir/menu.sh
        ;;

    2) $script_dir/uninstall-bbw-uc1.sh
        echo
        read -p "Enter any key to back to the menu..." key
        echo
        $work_dir/menu.sh
        ;;
    
    3)  /home/centos/BBW-DIH-k8s/scripts/uninstall-all-umbrellas.sh
        echo
        read -p "Enter any key to back to the menu..." key
        echo
        $work_dir/menu.sh
        ;;
    
    4) $script_dir/destroy-aks-cluster.sh
        echo
        read -p "Enter any key to back to the menu..." key
        echo
        $work_dir/menu.sh
        ;;
    
    5) $script_dir/uninstall-datadog.sh
        echo
        read -p "Enter any key to back to the menu..." key
        echo
        $work_dir/menu.sh
        ;;

    [eE])
        exit
        ;;

    *)  ./menu.sh
        exit
        ;;
esac