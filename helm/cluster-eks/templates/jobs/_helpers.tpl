{{- define "jobContainerCommon" -}}
image: "{{ .Values.kubectlImage.registry }}/{{ .Values.kubectlImage.name }}:{{ .Values.kubectlImage.tag }}"
securityContext:
  readOnlyRootFilesystem: true
  allowPrivilegeEscalation: false
  capabilities:
    drop:
    - ALL
  runAsNonRoot: true
  seccompProfile:
    type: RuntimeDefault
resources:
  requests:
    memory: "64Mi"
    cpu: "10m"
  limits:
    memory: "256Mi"
    cpu: "100m"
{{- end }}

{{- define "ciliumJobServiceAccount" }}
{{- include "resource.default.name" $ }}-update-cilium-values-job
{{- end }}

{{- define "controlPlaneJobServiceAccount" }}
{{- include "resource.default.name" $ }}-create-configmap-job
{{- end }}