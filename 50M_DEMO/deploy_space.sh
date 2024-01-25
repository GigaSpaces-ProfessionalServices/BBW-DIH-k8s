helm install bbw-space dihrepo/xap-pu --version 16.4.0 --set partitions=3,instances=0,ha=false,java.heap=10g,resources.limits.memory=12.5Gi
