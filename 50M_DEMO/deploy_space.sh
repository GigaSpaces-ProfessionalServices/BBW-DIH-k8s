PARTITIONS=8
HA=true
JAVA_HEAP=10 #In GB
MEM_LIMITS=12.5 #JAVA_HEAP*1.25

helm uninstall bbw-space
sleep 15 
helm upgrade --install bbw-space dihrepo/xap-pu --version 16.4.0 --set partitions=${PARTITIONS=6},instances=0,ha=${HA},antiAffinity.enabled=true,java.heap="${JAVA_HEAP}g",resources.limits.memory="${MEM_LIMITS}Gi"
