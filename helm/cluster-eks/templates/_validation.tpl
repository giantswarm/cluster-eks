{{- define "validation" }}
{{/*
No rendered templates live in here.
Instead this is used to perform some validation checks on values that dont make sense elsewhere.
*/}}
{{- $karpenterNodePools := list }}
{{- $managedNodePools := list }}
{{- range $name, $value := .Values.global.nodePools | default .Values.cluster.providerIntegration.workers.defaultNodePools }}
{{- if eq ($value.type | default "machinepool") "karpenter" }}
{{- $karpenterNodePools = append $karpenterNodePools $name }}
{{- else }}
{{- $managedNodePools = append $managedNodePools $name }}
{{- end }}
{{- end }}
{{- if and $karpenterNodePools (not $managedNodePools) }}
{{- fail (printf "karpenter node pools (%s) require at least one node pool of type \"machinepool\", because we schedule the karpenter controller not to run on nodes it provisions" (join ", " $karpenterNodePools)) }}
{{- end }}
{{- end -}}
