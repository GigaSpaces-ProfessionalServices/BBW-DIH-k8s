#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
#######
source scripts/setEnv.sh
#######

source scripts/setEnv.sh
clear
echo "Welcome to DIH Builder on Azure!"
echo "--------------------------------"
echo
echo "1. AKS Management"
echo "2. DIH Management"
echo "E. Exit"
echo 
read -p ">> " choice

case "$choice" in
 
    1)  $scripts_dir/AKS-menu.sh
        ;;
    
    2)  $scripts_dir/dih-menu.sh
        ;;
        
    [eE]) exit
        ;;

    *) $work_dir/menu.sh
        ;;
esac