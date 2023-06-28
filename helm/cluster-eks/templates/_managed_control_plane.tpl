{{- define "control-plane" }}
apiVersion: controlplane.cluster.x-k8s.io/v1beta2
kind: AWSManagedControlPlane
metadata:
  annotations:
    "helm.sh/resource-policy": keep
  labels:
    {{- include "labels.common" $ | nindent 4 }}
    app.kubernetes.io/version: {{ .Chart.Version | quote }}
  name: {{ include "resource.default.name" $ }}
  namespace: {{ $.Release.Namespace }}
spec:
  identityRef:
    kind: AWSClusterRoleIdentity
    {{- with .Values.providerSpecific.awsClusterRoleIdentityName }}
    name: {{ . | quote }}
    {{- end }}
  eksClusterName: {{ include "resource.default.name" $ }}
  region: {{ include "aws-region" . }}
  sshKeyName: ssh-key
  network:
    vpc:
      availabilityZoneUsageLimit: {{ .Values.connectivity.availabilityZoneUsageLimit }}
      cidrBlock: {{ .Values.connectivity.network.vpcCidr }}
    subnets:
    {{- range $j, $subnet := .Values.connectivity.subnets }}
    {{- range $i, $cidr := $subnet.cidrBlocks }}
    - cidrBlock: "{{ $cidr.cidr }}"
      {{- if eq (len $cidr.availabilityZone) 1 }}
      availabilityZone: "{{ include "aws-region" $ }}{{ $cidr.availabilityZone }}"
      {{- else }}
      availabilityZone: "{{ $cidr.availabilityZone }}"
      {{- end }}
      isPublic: {{ $subnet.isPublic | default false }}
      tags:
        {{- toYaml $subnet.tags | nindent 8 }}
        {{- if $cidr.tags }}
        {{- toYaml $cidr.tags | nindent 8 }}
        {{- end }}
    {{- end }}
    {{- end }}
  version: {{ $.Values.internal.kubernetesVersion }}
  vpcCni:
    disable: true
  kubeProxy:
    disable: true
{{- end -}}
