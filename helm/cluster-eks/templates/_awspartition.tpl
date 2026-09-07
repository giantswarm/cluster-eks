{{- /*
AWS partition of the cluster's region. Only the China regions sit outside the standard `aws` partition.
*/ -}}
{{- define "aws-partition" -}}
{{- if hasPrefix "cn-" (include "aws-region" .) -}}
aws-cn
{{- else -}}
aws
{{- end -}}
{{- end -}}
