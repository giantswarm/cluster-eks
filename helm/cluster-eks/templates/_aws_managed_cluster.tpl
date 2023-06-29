{{- define "aws-cluster" }}
apiVersion: infrastructure.cluster.x-k8s.io/v1beta2
kind: AWSManagedCluster
metadata:
  annotations:
    "helm.sh/resource-policy": keep
    aws.giantswarm.io/vpc-mode: public
    aws.cluster.x-k8s.io/external-resource-gc: "true"
  labels:
    {{- include "labels.common" $ | nindent 4 }}
    app.kubernetes.io/version: {{ .Chart.Version | quote }}
  name: {{ include "resource.default.name" $ }}
  namespace: {{ .Release.Namespace }}
spec:
{{ end }}
