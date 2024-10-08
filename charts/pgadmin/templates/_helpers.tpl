{{/*
Expand the name of the chart.
*/}}
{{- define "pgadmin.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "pgadmin.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "pgadmin.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "pgadmin.labels" -}}
helm.sh/chart: {{ include "pgadmin.chart" . }}
{{ include "pgadmin.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "pgadmin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "pgadmin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "pgadmin.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "pgadmin.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Fake keda hostname
*/}}
{{- define "keda.hostname" -}}
{{- list .Chart.Name .Values.bind.name .Values.bind.namespace .Values.app.service.name .Values.app.service.namespace "kubedb.internal" | compact | join "." | quote }}
{{- end }}

{{- define "image.dockerHub" -}}
{{ list .Values.proxies.dockerHub ._repo | compact | join "/" }}
{{- end }}

{{- define "image.dockerLibrary" -}}
{{ prepend (list ._repo) (list .Values.proxies.dockerLibrary .Values.proxies.dockerHub | compact | first) | compact | join "/" }}
{{- end }}

{{- define "image.ghcr" -}}
{{ list .Values.proxies.ghcr ._repo | compact | join "/" }}
{{- end }}
