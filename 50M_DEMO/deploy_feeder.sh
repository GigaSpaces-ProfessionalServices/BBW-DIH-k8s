#!/bin/bash

# Deploy a space
curl -X GET --header 'Accept: application/json' \
'http://bbw-gs:8090/v2/internal/spaces/bbw-space/expressionquery?expression=CREATE%20TABLE%20%22BBW_DEMO.EMPLOYEES%22%20(%20%20%20%20%20EMP_ID%20INT%20PRIMARY%20KEY%2C%20%20%20%20%20FIRST_NAME%20VARCHAR(50)%2C%20%20%20%20%20LAST_NAME%20VARCHAR(50)%2C%20%20%20%20%20PHONE_NUMBER%20VARCHAR(40)%2C%20%20%20%20%20ADDRESS%20VARCHAR(100)%2C%20%20%20%20%20IS_MANAGER%20CHAR(1)%2C%20%20%20%20%20DEPARTMENT_CODE%20CHAR(1)%2C%20%20%20%20%20COMMENTS%20CHAR(30)%20)&withExplainPlan=false&ramOnly=true'

# Install feeder xap-pu
helm install oracle-feeder dihrepo/xap-pu --version 16.4.0 -f helm_feeder.yaml
kubectl apply -f ./feeder_service.yaml

