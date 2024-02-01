table_name=BBW.EMPLOYEES
MAX_COL=emp_id
REST=10.222.0.179:8015
curl -X POST "http://$REST/table-feed/start?table-name=${table_name}&base-column=${MAX_COL}&rows-limit=50000000"
