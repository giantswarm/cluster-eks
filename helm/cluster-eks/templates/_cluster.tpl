{{- define "cluster" }}
apiVersion: cluster.x-k8s.io/v1beta1
kind: Cluster
metadata:
  annotations:
    {{- with .Values.metadata.description }}
    cluster.giantswarm.io/description: "{{ . }}"
    {{- end }}
  labels:
    cluster-apps-operator.giantswarm.io/watching: ""
    {{- if .Values.metadata.servicePriority }}
    giantswarm.io/service-priority: {{ .Values.metadata.servicePriority }}
    {{- end }}
    {{- include "labels.common" $ | nindent 4 }}
    app.kubernetes.io/version: {{ .Chart.Version | quote }}
  name: {{ include "resource.default.name" $ }}
  namespace: {{ .Release.Namespace }}
spec:
  clusterNetwork:
    services:
      # service CIDR cannot be changed as EKS do not allow configuration
      cidrBlocks:
      - 172.31.0.0/16
    pods:
      cidrBlocks:
      {{- toYaml .Values.connectivity.network.pods.cidrBlocks | nindent 8 }}
  controlPlaneRef:
    apiVersion: controlplane.cluster.x-k8s.io/v1beta2
    kind: AWSManagedControlPlane
    name: {{ include "resource.default.name" $ }}
  infrastructureRef:
    apiVersion: infrastructure.cluster.x-k8s.io/v1beta2
    kind: AWSManagedCluster
    name: {{ include "resource.default.name" $ }}
{{- end -}}
