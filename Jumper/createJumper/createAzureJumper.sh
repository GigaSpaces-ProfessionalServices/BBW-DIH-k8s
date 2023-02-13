#!/bin/bash
read -p "Jumper Name (prefix: bbw-jumper): " vmname
read -p "Tags | Owner: " owner
read -p "Tags | Project: " project

default_tags="gspolicy=noprod"
image="OpenLogic:CentOS:7_9:latest"
userdata="~/azure-jumper-userdata.txt"
az vm create -n bbw-jumper-$vmname -g csm-bbw --image $image --custom-data $userdata --ssh-key-value ~/.ssh/OOTB-DIH-Provisioning.pub --public-ip-sku Standard --nic-delete-option delete --admin-username centos --tags Owner=$owner Project=$project $default_tags
