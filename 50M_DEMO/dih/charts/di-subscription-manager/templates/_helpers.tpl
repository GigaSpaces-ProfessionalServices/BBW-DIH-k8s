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


{{- define "iidrConnectorType" -}}
iidr
{{- end -}}

{{- define "s3ConnectorType" -}}
s3
{{- end -}}

{{- define "getConnectorType" -}}
  {{- if eq (lower .Values.connectorType) "iidr" -}}
{{- include "iidrConnectorType" . -}}
  {{- else if eq (lower .Values.connectorType) "s3" -}}
{{- include "s3ConnectorType" . -}}
  {{- else -}}
{{- include "iidrConnectorType" . -}}
  {{- end -}}
{{- end -}}
