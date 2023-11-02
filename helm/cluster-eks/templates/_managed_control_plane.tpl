{{- define "control-plane" }}
apiVersion: controlplane.cluster.x-k8s.io/v1beta2
kind: AWSManagedControlPlane
metadata:
  annotations:
    "helm.sh/resource-policy": keep
    aws.giantswarm.io/vpc-mode: "public"
    aws.giantswarm.io/dns-mode: "public"
    aws.cluster.x-k8s.io/external-resource-gc: "true"
  labels:
    {{- include "labels.common" $ | nindent 4 }}
    app.kubernetes.io/version: {{ .Chart.Version | quote }}
  name: {{ include "resource.default.name" $ }}
  namespace: {{ $.Release.Namespace }}
spec:
  additionalTags:
    giantswarm.io/cluster: {{ include "resource.default.name" $ }}
    {{- if .Values.providerSpecific.additionalResourceTags -}}{{- toYaml .Values.providerSpecific.additionalResourceTags | nindent 4 }}{{- end}}
  identityRef:
    kind: AWSClusterRoleIdentity
    {{- with .Values.providerSpecific.awsClusterRoleIdentityName }}
    name: {{ . | quote }}
    {{- end }}
  eksClusterName: {{ include "resource.default.name" $ }}
  region: {{ include "aws-region" . }}
  secondaryCidrBlock: {{ first .Values.connectivity.network.pods.cidrBlocks }}
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
  logging:
    apiServer: {{ $.Values.controlPlane.logging.apiServer }}
    audit: {{ $.Values.controlPlane.logging.audit }}
    authenticator: {{ $.Values.controlPlane.logging.authenticator }}
    controllerManager: {{ $.Values.controlPlane.logging.controllerManager }}
  iamAuthenticatorConfig:
    mapRoles:
    - rolearn: 'arn:aws:iam::{{ include "aws-account-id" $ }}:role/GiantSwarmAdmin'
      groups: 
      - "system:masters"
      username: cluster-admin
{{- if $.Values.controlPlane.roleMapping }}
{{- toYaml $.Values.controlPlane.roleMapping | nindent 4 }}
{{- end }}
{{- end -}}
