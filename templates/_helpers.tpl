{{/* vim: set filetype=mustache: */}}

{{/*
Create the name of the service account to use
*/}}
{{- define "freebox-exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper freebox-exporter image name
*/}}
{{- define "freebox-exporter.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "freebox-exporter.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Check if there are rolling tags in the images
*/}}
{{- define "freebox-exporter.checkRollingTags" -}}
{{- include "common.warnings.rollingTag" .Values.image }}
{{- end -}}

{{/*
Get the config secret.
*/}}
{{- define "freebox-exporter.secretName" -}}
{{- if .Values.configuration.existingSecret -}}
    {{- .Values.configuration.existingSecret -}}
{{- else }}
    {{- printf "%s" (include "common.names.fullname" . ) -}}
{{- end -}}
{{- end -}}