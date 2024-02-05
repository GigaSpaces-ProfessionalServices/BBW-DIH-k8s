
{{/*
Return the proper Docker Image Registry Secret Names extracted from global.imagePullSecrets
*/}}
{{- define "di.imagePullSecrets" -}}
  {{- $pullSecrets := list }}

  {{- if .Values.global }}
    {{- range .Values.global.imagePullSecrets -}}
      {{- $pullSecrets = append $pullSecrets . -}}
    {{- end -}}
  {{- end -}}

  {{- if (not (empty $pullSecrets)) }}
imagePullSecrets:
    {{- range $pullSecrets }}
  - name: {{ . }}
    {{- end }}
  {{- end }}
{{- end -}}

{{- define "flink.affinity" -}}
{{/*enabled or (undefined + nodelocal mode) */}}
{{- if or (.Values.affinity.enabled) (and (eq .Values.affinity.enabled nil) (include "flink.nodeLocalMode" .)) -}}
affinity:
  podAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
            - key: deployment.affinity
              operator: In
              values:
                - {{ .Values.affinity.value }}
        topologyKey: "kubernetes.io/hostname"
{{- end -}}
{{- end -}}

{{- define "flink.highAvailabilityMode" -}}
{{- if and .Values.global.flink.highAvailability.enabled (or .Values.global.minio.enabled .Values.global.s3.enabled) -}}
true
{{- end -}}
{{- end -}}

{{- define "flink.nodeLocalMode" -}}
{{- if not (include "flink.highAvailabilityMode" .) -}}
true
{{- end -}}
{{- end -}}

{{- define "flink.initMinioContainer" -}}
{{- if and (include "flink.highAvailabilityMode" .) .Values.global.minio.enabled -}}
- name: wait-for-secret
  image: bitnami/kubectl
  command: [ 'sh' ]
  args:
    - "-c"
    - |
      set -x
      apt-get update -y \
      && apt-get install -y curl jq
      curl https://dl.min.io/client/mc/release/linux-amd64/mc --create-dirs -o /usr/local/bin/mc \
      && chmod +x /usr/local/bin/mc
      until kubectl get secret/{{ .Values.global.minio.tenantName }}-user-1; do sleep 1; done;
      until mc alias set myconfig http://{{ .Values.global.minio.tenantName }}-hl:9000 "$(kubectl get secret/{{ .Values.global.minio.tenantName }}-user-1 -o json | jq -r '.data.CONSOLE_ACCESS_KEY' | base64 -d)" "$(kubectl get secret/{{ .Values.global.minio.tenantName }}-user-1 -o json | jq -r '.data.CONSOLE_SECRET_KEY' | base64 -d)"; do sleep 1; done;
  securityContext:
    runAsUser: 0
{{- end -}}
{{- end -}}

{{- define "flink.high-availability.bucket" -}}
{{- if (and .Values.global.flink.highAvailability.enabled .Values.global.s3.enabled) }}
{{- required "global.flink.highAvailability.bucket should be defined in s3 high availability use case" .Values.global.flink.highAvailability.bucket }}
{{- else }}
{{- default "high-availability" .Values.global.flink.highAvailability.bucket | trunc 63 | trimSuffix "-" }}
{{- end -}}
{{- end -}}

{{- define "flink.high-availability.parentDir" -}}
{{- default .Release.Namespace .Values.global.flink.highAvailability.parentDirOverride | trunc 63 | trimSuffix "-" }}
{{- end -}}


{{- define "flink.high-availability.mode-properties" -}}
{{- if include "flink.nodeLocalMode" . }}
high-availability.storageDir: file://{{ .Values.highAvailability.mode.nodeLocal.storage.dir }}
state.checkpoints.dir: file://{{ .Values.highAvailability.mode.nodeLocal.checkpoints.dir }}
state.savepoints.dir: file://{{ .Values.highAvailability.mode.nodeLocal.savepoints.dir }}
{{- else if .Values.global.minio.enabled -}}
s3.endpoint: http://{{- .Values.global.minio.tenantName -}}-hl:9000
s3.path.style.access: true
high-availability.storageDir: s3://{{- include "flink.high-availability.bucket" . }}/{{- include "flink.high-availability.parentDir" . }}/flink-storage
state.checkpoints.dir: s3://{{- include "flink.high-availability.bucket" . }}/{{- include "flink.high-availability.parentDir" . }}/flink-checkpoints
state.savepoints.dir: s3://{{- include "flink.high-availability.bucket" . }}/{{- include "flink.high-availability.parentDir" . }}/flink-savepoints
{{- else if .Values.global.s3.enabled -}}
s3.path.style.access: false
high-availability.storageDir: s3://{{- include "flink.high-availability.bucket" . }}/{{- include "flink.high-availability.parentDir" . }}/flink-storage
state.checkpoints.dir: s3://{{- include "flink.high-availability.bucket" . }}/{{- include "flink.high-availability.parentDir" . }}/flink-checkpoints
state.savepoints.dir: s3://{{- include "flink.high-availability.bucket" . }}/{{- include "flink.high-availability.parentDir" . }}/flink-savepoints
{{- end -}}
{{- end -}}