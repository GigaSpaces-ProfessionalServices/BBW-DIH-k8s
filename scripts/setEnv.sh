#!/bin/bash
export kafka=https://charts.bitnami.com/bitnami
export kafka_ui=https://charts.redpanda.com/
export dih_helm_repo=https://s3.amazonaws.com/resources.gigaspaces.com/helm-charts-dih
export dih_gs_ea=https://resources.gigaspaces.com/helm-charts-ea
export ingress_helm_repo=https://kubernetes.github.io/ingress-nginx
export influxdb_kapacitor_helm=https://helm.influxdata.com

export resource_group_name=csm-bbw
export work_dir=~/BBW-DIH-k8s
export script_dir=$work_dir/scripts
export helm_dir=$work_dir/helm
export kafka_producer_dir=$work_dir/BBW-Kafka-Producer

export dih_version=16.3.0-m5