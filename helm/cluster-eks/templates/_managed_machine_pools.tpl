{{- define "machine-pools" }}
{{- range $name, $value := .Values.global.nodePools | default .Values.internal.nodePools }}
apiVersion: cluster.x-k8s.io/v1beta1
kind: MachinePool
metadata:
  annotations:
    machine-pool.giantswarm.io/name: {{ include "resource.default.name" $ }}-{{ $name }}
    cluster.x-k8s.io/replicas-managed-by: "external-autoscaler"
  labels:
    giantswarm.io/machine-pool: {{ include "resource.default.name" $ }}-{{ $name }}
    {{- include "labels.common" $ | nindent 4 }}
    app.kubernetes.io/version: {{ $.Chart.Version | quote }}
  name: {{ include "resource.default.name" $ }}-{{ $name }}
  namespace: {{ $.Release.Namespace }}
spec:
  clusterName: {{ include "resource.default.name" $ }}
  replicas: {{ $value.minSize | default 1 }}
  template:
    spec:
      bootstrap:
        dataSecretName: ""
      clusterName: {{ include "resource.default.name" $ }}
      infrastructureRef:
        apiVersion: infrastructure.cluster.x-k8s.io/v1beta2
        kind: AWSManagedMachinePool
        name: {{ include "resource.default.name" $ }}-{{ $name }}
      version: {{ $.Values.internal.kubernetesVersion }}
---
apiVersion: infrastructure.cluster.x-k8s.io/v1beta2
kind: AWSManagedMachinePool
metadata:
  labels:
    giantswarm.io/machine-pool: {{ include "resource.default.name" $ }}-{{ $name }}
    {{- include "labels.common" $ | nindent 4 }}
  name: {{ include "resource.default.name" $ }}-{{ $name }}
  namespace: {{ $.Release.Namespace }}
spec:
  additionalTags:
    k8s.io/cluster-autoscaler/enabled: "true"
    sigs.k8s.io/cluster-api-provider-aws/cluster/{{ include "resource.default.name" $ }}: "owned"
  availabilityZones: {{ include "aws-availability-zones" $value | nindent 2 }}
  eksNodegroupName: nodes-{{ include "resource.default.name" $ }}-{{ $name }}
  instanceType:  {{ $value.instanceType }}
  roleName: nodes-{{ include "resource.default.name" $ }}-{{ $name }}
  scaling:
    minSize: {{ $value.minSize | default 1 }}
    maxSize: {{ $value.maxSize | default 3 }}
  {{- if or $value.maxUnavailable $value.maxUnavailablePercentage }}
  updateConfig:
    {{- if $value.maxUnavailable }}
    maxUnavailable: {{ $value.maxUnavailable }}
    {{- else if $value.maxUnavailablePercentage }}
    maxUnavailablePercentage: {{ $value.maxUnavailablePercentage }}
    {{- end }}
  {{- end }}
---
{{ end }}
{{- end -}}
