#!/bin/bash
# Helm repositories
export kafka=https://charts.bitnami.com/bitnami
export kafka_ui=https://charts.redpanda.com/
export dih_helm_repo=https://s3.amazonaws.com/resources.gigaspaces.com/helm-charts-dih
export dih_gs_ea=https://resources.gigaspaces.com/helm-charts-ea
export ingress_helm_repo=https://kubernetes.github.io/ingress-nginx
export influxdb_kapacitor_helm=https://helm.influxdata.com
export datadog_helm=https://helm.datadoghq.com

### Azure 
export resource_group_name=csm-bbw
# export ARM_CLIENT_ID=""
# export ARM_CLIENT_SECRET=""
# export ARM_SUBSCRIPTION_ID=""
# export ARM_TENANT_ID=""

### dih umbrellas
export work_dir=~/BBW-DIH-k8s
export scripts_dir=$work_dir/scripts
export helm_dir=$work_dir/helm
export kafka_producer_dir=$work_dir/BBW-Kafka-Producer
export dih_version=16.3.0-m5


### datadog integration bbw-demo
export datadog_api_key="6b06a3864ceb15999b3d7c330789ba0e"
export datadog_app_key="223a3e6ae717a731f165dff49a4faba063815586"