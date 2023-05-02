#!/bin/bash
REASOURCE_GROUP=csm-bbw

DIH_HELM_REPO="https://s3.amazonaws.com/resources.gigaspaces.com/helm-charts-dih"
DIH_HELM_CHART="16.3.0"
DIH_HELM_CONF_FILE="DIH/helm/dih-umbrella.yaml"

### Azure credentials
# ARM_CLIENT_ID=
# ARM_CLIENT_SECRET=
# ARM_SUBSCRIPTION_ID=
# ARM_TENANT_ID=

### datadog integration bbw-demo
export datadog_api_key=""
export datadog_app_key=""