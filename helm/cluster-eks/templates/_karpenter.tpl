{{- define "hasKarpenterNodePool" -}}
{{- $ret := "false" }}
{{- range $name, $value := .Values.global.nodePools | default (.Values.cluster).providerIntegration.workers.defaultNodePools | default (.Values.providerIntegration).workers.defaultNodePools }}
  {{- if eq $value.type "karpenter" }}
    {{- $ret = "true" }}
    {{- break -}}
  {{- end }}
{{- end }}
{{- print $ret -}}
{{- end }}

{{- /*
Name of the IAM role and instance profile that karpenter-launched nodes assume
*/ -}}
{{- define "karpenter-node-iam-role" -}}
{{ include "resource.default.name" . }}-karpenter-worker
{{- end -}}

{{- /*
Node label marking the EKS managed node groups. Karpenter must not run on the nodes it provisions,
or it can consolidate its own host away mid-operation.
*/ -}}
{{- define "karpenter-host-node-selector" -}}
giantswarm.io/run-karpenter: "true"
{{- end -}}
