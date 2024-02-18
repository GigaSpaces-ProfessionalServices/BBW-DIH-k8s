# Bath & and Body Works - 50M records load demo

We created this demo for BBW to demonstrate DIH massive data load capabilities.

## Demo setup

### Azure k8s cluster (AKS)
* 6 nodes of Standard_B16ms
* 8 partitions, 12Gb each, HA
* Oracle feeder

### azure linux vm (Oracle Database)
* Standard B16ms (16 vcpus, 64 GiB memory)
* Oracle 19c 
* K6 for load test

### azure Windoes vm (UI)
*  1 Standard B4ms (4 vcpus, 16 GiB memory)
* Chrome for UI (Spacedeck, OPSui, Grafana)
* mobaXterm

### Customized Grafana dashboatd for BBW
* bbw-dashboard-latest.json

## Note that we used an internal VPC (private IPs) to avoid latancy over the internat between feeder and DB.




