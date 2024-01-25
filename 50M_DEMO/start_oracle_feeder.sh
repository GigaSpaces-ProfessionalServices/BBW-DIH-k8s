table_name=ORDERS
MAX_COL=LAST_UPDATE
REST=bbw-demo.eastus.cloudapp.azure.com:8015
curl -XPOST "http://$REST/table-feed/start?table-name=${table_name}&base-column=${MAX_COL}"
