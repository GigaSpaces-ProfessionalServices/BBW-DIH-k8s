table_name=BBW.PRODUCTS
MAX_COL=product_id
REST=$(kubectl get svc ingress-nginx-controller -o json | jq -r .status.loadBalancer.ingress[].ip):8015
curl -X POST "http://$REST/table-feed/start?table-name=${table_name}&base-column=${MAX_COL}&rows-limit=50000000"
