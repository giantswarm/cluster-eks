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
    {{- if .Values.global.providerSpecific.additionalResourceTags -}}{{- toYaml .Values.global.providerSpecific.additionalResourceTags | nindent 4 }}{{- end}}
  identityRef:
    kind: AWSClusterRoleIdentity
    {{- with .Values.global.providerSpecific.awsClusterRoleIdentityName }}
    name: {{ . | quote }}
    {{- end }}
  eksClusterName: {{ include "resource.default.name" $ }}
  region: {{ include "aws-region" . }}
  secondaryCidrBlock: {{ first .Values.global.connectivity.network.pods.cidrBlocks }}
  sshKeyName: ssh-key
  network:
    vpc:
      availabilityZoneUsageLimit: {{ .Values.global.connectivity.availabilityZoneUsageLimit }}
      cidrBlock: {{ .Values.global.connectivity.network.vpcCidr }}
      emptyRoutesDefaultVPCSecurityGroup: true
    subnets:
    {{- range $j, $subnet := .Values.global.connectivity.subnets }}
    {{- range $i, $cidr := $subnet.cidrBlocks -}}
    {{/* CAPA v2.3.0 defaults to using the `id` field as subnet name unless it's an unmanaged one (`id` starts with `subnet-`), so use CAPA's previous standard subnet naming scheme */}}
    - id: "{{ include "resource.default.name" $ }}-subnet-{{ $subnet.isPublic | default false | ternary "public" "private" }}-{{ if eq (len $cidr.availabilityZone) 1 }}{{ include "aws-region" $ }}{{ end }}{{ $cidr.availabilityZone }}"
      cidrBlock: "{{ $cidr.cidr }}"
      {{- if eq (len $cidr.availabilityZone) 1 }}
      availabilityZone: "{{ include "aws-region" $ }}{{ $cidr.availabilityZone }}"
      {{- else }}
      availabilityZone: "{{ $cidr.availabilityZone }}"
      {{- end }}
      isPublic: {{ $subnet.isPublic | default false }}
      {{- if or $subnet.tags $cidr.tags }}
      tags:
        {{- toYaml $subnet.tags | nindent 8 }}
        {{- if $cidr.tags }}
        {{- toYaml $cidr.tags | nindent 8 }}
        {{- end }}
      {{- end }}
    {{- end }}
    {{- end }}
    {{- range $j, $subnet := .Values.global.connectivity.podSubnets }}
    {{- range $i, $cidr := $subnet.cidrBlocks }}
    - id: "{{ include "resource.default.name" $ }}-subnet-secondary-{{ if eq (len $cidr.availabilityZone) 1 }}{{ include "aws-region" $ }}{{ end }}{{ $cidr.availabilityZone }}"
      cidrBlock: "{{ $cidr.cidr }}"
      {{- if eq (len $cidr.availabilityZone) 1 }}
      availabilityZone: "{{ include "aws-region" $ }}{{ $cidr.availabilityZone }}"
      {{- else }}
      availabilityZone: "{{ $cidr.availabilityZone }}"
      {{- end }}
      isPublic: false
      {{- if or $subnet.tags $cidr.tags }}
      tags:
        {{- if $cidr.tags }}
        {{- toYaml $cidr.tags | nindent 8 }}
        {{- end }}
      {{- end }}
    {{- end }}
    {{- end }}
  version: {{ $.Values.internal.kubernetesVersion }}
  vpcCni:
    disable: true
  kubeProxy:
    disable: true
  {{ if .Values.global.controlPlane.encryptionConfig.keyARN }}
  encryptionConfig:
    resources:
    - resources:
      {{- if  gt (len .Values.global.controlPlane.encryptionConfig.resources) 0 }}
      {{- toYaml .Values.global.controlPlane.encryptionConfig.resources | nindent 8 }}
      {{- else }}
      - secrets
      {{- end }}
      provider:
        aws:
          keyARN: {{ $.Values.global.controlPlane.encryptionConfig.keyARN }}
  {{- end }}
  logging:
    apiServer: {{ $.Values.global.controlPlane.logging.apiServer }}
    audit: {{ $.Values.global.controlPlane.logging.audit }}
    authenticator: {{ $.Values.global.controlPlane.logging.authenticator }}
    controllerManager: {{ $.Values.global.controlPlane.logging.controllerManager }}
  iamAuthenticatorConfig:
    mapRoles:
    - rolearn: 'arn:aws:iam::{{ include "aws-account-id" $ }}:role/GiantSwarmAdmin'
      groups:
      - "system:masters"
      username: cluster-admin
  {{- if $.Values.global.controlPlane.oidcIdentityProviderConfig.issuerUrl }}
  oidcIdentityProviderConfig:
  {{- toYaml $.Values.global.controlPlane.oidcIdentityProviderConfig | nindent 4 }}
  {{- end }}
{{- if $.Values.global.controlPlane.roleMapping }}
{{- toYaml $.Values.global.controlPlane.roleMapping | nindent 4 }}
{{- end }}
{{- end -}}
