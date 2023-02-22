#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
#######
source ./setEnv.sh
#######
clear
echo "AKS management"
echo "--------------"
echo
echo "1. Set a current AKS cluster (update kubeconfig)"
echo "2. Create a new AKS cluster"
echo "-----------------------------------------------------------------"
echo "B. Back to Main menu."
echo "E. Exit"
echo 
read -p ">> " choice

case "$choice" in
    1) $scripts_dir/set-current-cluster.sh   
        ;;
    
    2) $scripts_dir/create-aks-cluster.sh        
        ;;

    [Bb]) $work_dir/menu.sh
        ;;

    [eE]) exit
        ;;

    *) $work_dir/menu.sh
        ;;
esac