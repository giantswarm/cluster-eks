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

{{- /*
Whether Karpenter waits for the cilium-extensions HelmRelease, so new nodes start with their Cilium IP pre-allocation.
Only when the cluster chart renders that HelmRelease: enabled here, Cilium managed by us, not disabled ephemerally and,
when apps come from Releases, part of the cluster's Release. A dependency on a HelmRelease that doesn't exist would block Karpenter forever.
*/ -}}
{{- define "karpenter-waits-for-cilium-extensions" -}}
{{- $global := $.Values.global | toYaml | fromYaml -}}
{{- $cluster := $.Values.cluster | toYaml | fromYaml -}}
{{- $enabled := dig "providerIntegration" "apps" "ciliumExtensions" "enable" false $cluster -}}
{{- $cniManaged := dig "connectivity" "cni" "managed" true $global -}}
{{- $ephemeralDisable := dig "internal" "ephemeralConfiguration" "apps" "ciliumExtensions" "disable" false $cluster -}}
{{- $useReleases := dig "providerIntegration" "useReleases" false $cluster -}}
{{- $inRelease := include "cluster.app.in-release" (merge (dict "appName" "cilium-extensions") $) | trim -}}
{{- and $enabled $cniManaged (not $ephemeralDisable) (or (not $useReleases) (eq $inRelease "true")) -}}
{{- end -}}
