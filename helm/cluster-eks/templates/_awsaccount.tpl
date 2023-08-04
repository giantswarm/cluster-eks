{{- /*
Extracts the AWS account ID from an ARN string.

Example usage: {{ include "extractAWSAccountID" "arn:aws:iam::1234567890:role/example-role" }}

Input: An ARN string
Output: The AWS account ID
*/ -}}
{{- define "extractAWSAccountID" -}}
{{- (split ":" . )._4 -}}
{{- end -}}

{{- define "aws-account-id" -}}
{{- $accountID :="*" -}}
{{- $role :=  (lookup "infrastructure.cluster.x-k8s.io/v1beta2" "AWSClusterRoleIdentity" "" "default2" ) -}}
{{- if $role -}}
{{- $accountID = (include "extractAWSAccountID" $role.spec.roleARN) -}}
{{- end -}}
{{- $role -}}
{{- end -}}
