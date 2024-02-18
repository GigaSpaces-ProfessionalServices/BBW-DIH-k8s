# Bath & and Body Works - 50M records load demo

We created this demo for BBW to demonstrate DIH massive data load capabilities.

## Demo setup

### Azure k8s cluster (AKS)
* 6 nodes of Standard_B16ms
* 8 partitions, 12Gb each, HA
* Oracle feeder

### azure linux vm (Oracle Database)
* Oracle 19c 
* K6

### azure Windoes vm (UI)
* Chrome for UI (Spacedeck, OPSui, Grafana)
* mobaXterm

### Customized Grafana dashboatd for BBW
* bbw-dashboard-latest.json

## Note that we used an internal VPC (private IPs) to avoid latancy over the internat between feeder and DB.




