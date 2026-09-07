{{- /*
Name of the IAM role and instance profile that karpenter-launched nodes assume. Created by the
`karpenter-bundle` chart, and named so that it matches the `iam:PassRole` wildcard
(`role/nodes-*-<cluster>`) the karpenter controller role is scoped to.
*/ -}}
{{- define "karpenter-node-iam-role" -}}
nodes-karpenter-{{ include "resource.default.name" . }}
{{- end -}}

{{- /*
Node label marking the EKS managed node groups. Karpenter must not run on the nodes it provisions,
or it can consolidate its own host away mid-operation, so the controller is pinned here.
*/ -}}
{{- define "karpenter-host-node-selector" -}}
giantswarm.io/run-karpenter: "true"
{{- end -}}
