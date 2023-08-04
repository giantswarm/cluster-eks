{{- /*
Extracts the AWS account ID from an ARN string.
From our friend ChatGPT

Example usage: {{ include "extractAWSAccountID" "arn:aws:iam::1234567890:role/example-role" }}

Input: An ARN string
Output: The AWS account ID
*/ -}}
{{- define "extractAWSAccountID" -}}
{{- $colonCount := 0 -}}
{{- $startIndex := 0 -}}
{{- $endIndex := 0 -}}
{{- range $index, $char := . -}}
  {{- if eq $char ":" -}}
    {{- if eq $colonCount 4 -}}
      {{- $endIndex = $index -}}
      {{- break -}}
    {{- else -}}
      {{- $colonCount = add $colonCount 1 -}}
      {{- $startIndex = add $index 1 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
{{- substr . $startIndex $endIndex -}}
{{- end -}}

{{- define "aws-account" }}
{{- $accountID := ""}}
{{- $roleName := .Values.providerSpecific.awsClusterRoleIdentityName }}
{{- $role :=  (lookup "infrastructure.cluster.x-k8s.io/v1beta2" "AWSClusterRoleIdentity" "" "$roleName" ) }}
{{- if $role }}
{{- $accountID = (include "extractAWSAccountID" $role.spec.roleARN) }}
{{- end }}
{{ $accountID }}
{{- end }}
