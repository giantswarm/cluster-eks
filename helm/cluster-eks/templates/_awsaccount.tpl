{{- /*
Extracts the AWS account ID from an ARN string.

Example usage: {{ include "extractAWSAccountID" "arn:aws:iam::1234567890:role/example-role" }}

Input: An ARN string
Output: The AWS account ID
*/ -}}
{{- define "extractAWSAccountID" -}}
{{- $parts := (split ":" . ) -}}
{{ index $parts 5 -}}
{{- end -}}

{{- define "aws-account-id" -}}
{{- $role :=  (lookup "infrastructure.cluster.x-k8s.io/v1beta2" "AWSClusterRoleIdentity" "" ".Values.providerSpecific.awsClusterRoleIdentityName" ) -}}
{{- $accountID := (include "extractAWSAccountID" $role.spec.roleARN) -}}
{{- if eq $accountID "" -}}*{{- else -}}{{- $accountID -}}{{- end -}}
{{- end -}}
