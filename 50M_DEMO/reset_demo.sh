#!/bin/bash
echo "Reset the demo setup ..."
echo 
echo "undeploy get-emp service ..."
kubectl patch deployment get-emp-id -p '{"spec": {"replicas": 0}}'

echo "undeploy oracle-feeder ..."
helm uninstall oracle-feeder

echo "undeploy bbw-space ..."
helm uninstall bbw-space

sleep 10
echo "Deploying the demo setup ..."
echo "deploy bbw-space ..."
./2.deploy_space.sh

echo "deploy oracle-feeder ..."
./3.deploy_feeder.sh

echo "deploy get-emp service ..."
kubectl patch deployment get-emp-id -p '{"spec": {"replicas": 10}}'

echo "Create the object type in the space ..."
./createObjectEmployees.sh

echo "Warm get-emp service ..."
./5.run_service_load_test.sh


