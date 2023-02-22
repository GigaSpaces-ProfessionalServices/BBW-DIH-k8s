#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
cd $SCRIPTPATH
source ./setEnv.sh

$scripts_dir/uninstall-dih-umbrella-generic.sh
$scripts_dir/uninstall-bbw-uc1.sh
$scripts_dir/uninstall-datadog.sh


