{{- define "managed-machine-pool-spec-hash" -}}
{{ $spec := include "managed-machine-pool-spec" $ }}{{ regexReplaceAll `^\s*#.*$` $spec "" | sha256sum | trunc 5 }}
{{- end -}}
{{- define "managed-machine-pool-spec" }}
{{- $_unused := required "nodePoolName must be set" $.nodePoolName -}}
{{- $_unused := required "nodePoolObject must be set" $.nodePoolObject -}}
additionalTags:
  k8s.io/cluster-autoscaler/enabled: "true"
  sigs.k8s.io/cluster-api-provider-aws/cluster/{{ include "resource.default.name" $ }}: "owned"
amiType: {{ $.nodePoolObject.amiType }}
availabilityZones: {{ include "aws-availability-zones" $.nodePoolObject | nindent 2 }}
availabilityZoneSubnetType: private
instanceType:  {{ $.nodePoolObject.instanceType }}
roleName: nodes-{{ include "resource.default.name" $ }}-{{ $.nodePoolName }}
scaling:
  minSize: {{ $.nodePoolObject.minSize | default 1 }}
  maxSize: {{ $.nodePoolObject.maxSize | default 3 }}
{{- if and $.nodePoolObject.subnetIds (gt (len $.nodePoolObject.subnetIds) 0) }}
subnetIDs: {{ $.nodePoolObject.subnetIds | toYaml | nindent 2 }}
{{- end }}
{{- if or $.nodePoolObject.maxUnavailable $.nodePoolObject.maxUnavailablePercentage }}
updateConfig:
  {{- if $.nodePoolObject.maxUnavailable }}
  maxUnavailable: {{ $.nodePoolObject.maxUnavailable }}
  {{- else if $.nodePoolObject.maxUnavailablePercentage }}
  maxUnavailablePercentage: {{ $.nodePoolObject.maxUnavailablePercentage }}
  {{- end }}
{{- end }}
{{- end }}
{{- define "machine-pools" }}
{{- range $name, $value := .Values.global.nodePools | default .Values.internal.nodePools }}
{{- $ := set $ "nodePoolName" $name }}
{{- $ := set $ "nodePoolObject" $value }}
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
        name: {{ include "resource.default.name" $ }}-{{ $name }}-{{ include "managed-machine-pool-spec-hash" $ }}
      version: {{ $.Values.internal.kubernetesVersion }}
---
apiVersion: infrastructure.cluster.x-k8s.io/v1beta2
kind: AWSManagedMachinePool
metadata:
  labels:
    giantswarm.io/machine-pool: {{ include "resource.default.name" $ }}-{{ $name }}
    {{- include "labels.common" $ | nindent 4 }}
  name: {{ include "resource.default.name" $ }}-{{ $name }}-{{ include "managed-machine-pool-spec-hash" $ }}
  namespace: {{ $.Release.Namespace }}
spec: {{- include "managed-machine-pool-spec" $ | nindent 2 }}
eksNodegroupName: nodes-{{ include "resource.default.name" $ }}-{{ $name }}-{{ include "managed-machine-pool-spec-hash" $ }}
---
{{ end }}
{{- end -}}
