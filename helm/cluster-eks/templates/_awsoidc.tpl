{{- /*
OIDC issuer domain of the EKS cluster, taken from the OIDC provider ARN that CAPA sets in the AWSManagedControlPlane status.
Empty until CAPA has created the OIDC provider.
*/ -}}
{{- define "aws-oidc-domain" -}}
{{- $controlPlane := lookup "controlplane.cluster.x-k8s.io/v1beta2" "AWSManagedControlPlane" $.Release.Namespace (include "resource.default.name" $) -}}
{{- $arn := (($controlPlane.status).oidcProvider).arn | default "" -}}
{{- if contains "oidc-provider/" $arn -}}
{{- last (splitList "oidc-provider/" $arn) -}}
{{- end -}}
{{- end -}}
