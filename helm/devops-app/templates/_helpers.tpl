{{- /* Name used for most resources */ -}}
{{- define "devops-app.fullname" -}}
{{ printf "%s-%s" .Release.Name "devops-app" }}
{{- end }}

{{- /* Common labels for resources */ -}}
{{- define "devops-app.labels" -}}
app.kubernetes.io/name: devops-app
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- /* Labels used in selectors (must match pod labels) */ -}}
{{- define "devops-app.selectorLabels" -}}
app.kubernetes.io/name: devops-app
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
