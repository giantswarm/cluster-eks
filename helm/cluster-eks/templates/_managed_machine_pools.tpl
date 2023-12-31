{{- define "machine-pools" }}
{{- range $name, $value := .Values.global.nodePools | default .Values.internal.nodePools }}
apiVersion: cluster.x-k8s.io/v1beta1
kind: MachinePool
metadata:
  annotations:
    "helm.sh/resource-policy": keep
    machine-pool.giantswarm.io/name: {{ include "resource.default.name" $ }}-{{ $name }}
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
  annotations:
    "helm.sh/resource-policy": keep
  labels:
    giantswarm.io/machine-pool: {{ include "resource.default.name" $ }}-{{ $name }}
    {{- include "labels.common" $ | nindent 4 }}
  name: {{ include "resource.default.name" $ }}-{{ $name }}
  namespace: {{ $.Release.Namespace }}
spec:
  eksNodegroupName: nodes-{{ include "resource.default.name" $ }}-{{ $name }}
  roleName: nodes-{{ include "resource.default.name" $ }}-{{ $name }}
  availabilityZones: {{ include "aws-availability-zones" $value | nindent 2 }}
  scaling:
    minSize: {{ $value.minSize | default 1 }}
    maxSize: {{ $value.maxSize | default 3 }}
  instanceType:  {{ $value.instanceType }}
---
{{ end }}
{{- end -}}
