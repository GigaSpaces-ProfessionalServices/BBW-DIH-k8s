DIH_XAP_VERSION=16.4.0
DIH_XAP_PU_VERSION=16.4.0
DIH_LICENSE="Product=InsightEdge;Version=16.4;Type=ENTERPRISE;Customer=Gigaspaces_R&D_DI_DEV;Expiration=2025-Dec-31;Hash=QROtPGzkRIRPMV84YXOU"

NAMESPACE=default

GS_REGISTRY_SERVER="https://index.docker.io/v1/"
GS_REGISTRY_USER="dihcustomers"
GS_REGISTRY_PASS="dckr_pat_NYcQySRyhRFZ6eUQAwLsYm314QA"
GS_REGISTRY_EMAIL="dih-customers@gigaspaces"

DIH_HELM_REPO_NAME=dihrepo
DIH_HELM_REPO_URL="https://s3.amazonaws.com/resources.gigaspaces.com/helm-charts-dih"
DIH_HELM_CHART_NAME=dih

INGRESS_CNTRL_HELM_REPO_NAME=ingress-nginx-repo
INGRESS_CNTRL_HELM_REPO_URL="https://kubernetes.github.io/ingress-nginx"
INGRESS_CNTRL_HELM_CHART_NAME=ingress-nginx

MANAGER_HA=true
SPACE_NAME=bbw-space
SPACE_PARTITIONS=8
SPACE_JAVA_HEAP=12 # in GB
SPACE_MEM_LIMITS=$(echo "scale=2; $SPACE_JAVA_HEAP * 1.25" | bc)
SPACE_MEM_LIMITS=$(printf "%.1f" $SPACE_MEM_LIMITS)
SPACE_HA=true

IIDR_ENABLED=false
GLOBAL_SECURITY_ENABLED=false
GLOBAL_SECURITY_PASS=demo-dih-pass
GLOBAL_S3_ENABLED=false
GLOBAL_FLINK_HA_ENABLED=false
GLOBAL_FLINK_HA_S3_BUCKET=s3://flink_HA_buckName
GLOBAL_CSV_S3_BUCKET=s3://power-dih



