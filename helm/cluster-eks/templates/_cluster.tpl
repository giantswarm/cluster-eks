{{- define "cluster" }}
apiVersion: cluster.x-k8s.io/v1beta1
kind: Cluster
metadata:
  annotations:
    {{- with .Values.global.metadata.description }}
    cluster.giantswarm.io/description: "{{ . }}"
    {{- end }}
  labels:
    cluster-apps-operator.giantswarm.io/watching: ""
    {{- if .Values.global.metadata.servicePriority }}
    giantswarm.io/service-priority: {{ .Values.global.metadata.servicePriority }}
    {{- end }}
    {{- if .Values.global.podSecurityStandards.enforced }}
    policy.giantswarm.io/psp-status: disabled
    {{- end }}
    {{- include "labels.common" $ | nindent 4 }}
    app.kubernetes.io/version: {{ .Chart.Version | quote }}
  name: {{ include "resource.default.name" $ }}
  namespace: {{ .Release.Namespace }}
spec:
  clusterNetwork:
    services:
      cidrBlocks:
      {{- toYaml .Values.global.connectivity.network.services.cidrBlocks | nindent 8 }}
    pods:
      cidrBlocks:
      {{- toYaml .Values.global.connectivity.network.pods.cidrBlocks | nindent 8 }}
  controlPlaneRef:
    apiVersion: controlplane.cluster.x-k8s.io/v1beta2
    kind: AWSManagedControlPlane
    name: {{ include "resource.default.name" $ }}
  infrastructureRef:
    apiVersion: infrastructure.cluster.x-k8s.io/v1beta2
    kind: AWSManagedCluster
    name: {{ include "resource.default.name" $ }}
{{- end -}}
