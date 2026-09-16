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
