{{- define "karpenter-machine-pools" }}
{{- range $name, $value := .Values.global.nodePools | default .Values.cluster.providerIntegration.workers.defaultNodePools }}
{{- if eq $value.type "karpenter" }}
apiVersion: infrastructure.cluster.x-k8s.io/v1alpha1
kind: KarpenterMachinePool
metadata:
  labels:
    giantswarm.io/machine-pool: {{ include "resource.default.name" $ }}-{{ $name }}
    {{- include "labels.common" $ | nindent 4 }}
    app.kubernetes.io/version: {{ $.Chart.AppVersion | quote }}
  name: {{ include "resource.default.name" $ }}-{{ $name }}
  namespace: {{ $.Release.Namespace }}
spec:
  ec2NodeClass:
    amiFamily: AL2023
    amiSelectorTerms:
      - alias: al2023@latest
    blockDeviceMappings:
    - deviceName: /dev/xvda
      rootVolume: true
      ebs:
        volumeSize: {{ $value.rootVolumeSizeGB | default 25 | max 25 }}Gi
        volumeType: gp3
        encrypted: true
        deleteOnTermination: true
    instanceProfile: {{ include "karpenter-node-iam-role" $ }}
    metadataOptions:
      {{- /* Cilium runs in ENI IPAM mode with `firstInterfaceIndex: 1`, so pods reach IMDS one hop away */}}
      httpPutResponseHopLimit: 2
      httpTokens: "required"
    securityGroupSelectorTerms:
    - tags:
        kubernetes.io/cluster/{{ include "resource.default.name" $ }}: owned
        aws:eks:cluster-name: {{ include "resource.default.name" $ }}
    {{- range $value.additionalSecurityGroups }}
    - id: {{ .id | quote }}
    {{- end }}
    tags:
      Name: {{ include "resource.default.name" $ }}-{{ $name }}
    subnetSelectorTerms:
    - tags:
        {{- /* CAPA tags the secondary Cilium pod subnets `role: private` too, and selector terms
               cannot express an absent tag, so the node subnets carry a dedicated discovery tag. */}}
        {{- if not $value.subnetTags }}
        karpenter.sh/discovery: {{ include "resource.default.name" $ }}
        {{- else }}
        {{- range $value.subnetTags }}
        {{- range $key, $val := . }}
        {{ $key | quote }}: {{ $val | quote }}
        {{- end }}
        {{- end }}
        {{- end }}
  nodePool:
    disruption:
      consolidateAfter: {{ $value.consolidateAfter | default "1h" }}
      {{- with $value.consolidationPolicy }}
      consolidationPolicy: {{ . }}
      {{- end }}
      {{- with (coalesce $value.disruptionBudgets $value.consolidationBudgets) }}
      budgets:
      {{- toYaml . | nindent 8 }}
      {{- end }}
    {{- $limits := default (dict "cpu" "1000" "memory" "1000Gi") $value.limits }}
    limits:
      cpu: {{ $limits.cpu }}
      memory: {{ $limits.memory }}
    template:
      metadata:
        labels:
          giantswarm.io/machine-pool: {{ include "resource.default.name" $ }}-{{ $name }}
          {{- with $value.customNodeLabels }}
          {{- range . }}
          {{- $parts := splitList "=" . }}
          {{- if eq (len $parts) 2 }}
          {{ index $parts 0 | quote }}: {{ index $parts 1 | quote }}
          {{- end }}
          {{- end }}
          {{- end }}
      spec:
        {{- with $value.expireAfter }}
        expireAfter: {{ . }}
        {{- end }}
        requirements:
        {{- range $value.requirements }}
        - key: {{ .key }}
          operator: {{ .operator }}
          values:
            {{- range .values }}
            - "{{ . }}"
            {{- end }}
        {{- else }}
        - key: karpenter.k8s.aws/instance-family
          operator: NotIn
          values:
          - t3
          - t3a
          - t2
        - key: karpenter.sh/capacity-type
          operator: In
          values:
          - spot
          - on-demand
        - key: karpenter.k8s.aws/instance-cpu
          operator: In
          values:
          - "4"
          - "8"
          - "16"
          - "32"
        - key: karpenter.k8s.aws/instance-hypervisor
          operator: In
          values:
          - nitro
        - key: kubernetes.io/arch
          operator: In
          values:
          - amd64
        - key: kubernetes.io/os
          operator: In
          values:
          - linux
        {{- end }}
        {{- /* EKS nodes never get a KubeadmConfig, so `node.cluster.x-k8s.io/uninitialized` is never
               applied and nothing would ever remove it. Cilium clears its own taint. */}}
        startupTaints:
        - effect: NoExecute
          key: node.cilium.io/agent-not-ready
          value: "true"
        {{- with $value.customNodeTaints }}
        taints:
        {{- range . }}
        - key: {{ .key | quote }}
          effect: {{ .effect | quote }}
          {{- if .value }}
          value: {{ .value | quote }}
          {{- end }}
        {{- end }}
        {{- end }}
        terminationGracePeriod: {{ $value.terminationGracePeriod | default "30m" }}
---
apiVersion: bootstrap.cluster.x-k8s.io/v1beta2
kind: NodeadmConfig
metadata:
  name: {{ include "resource.default.name" $ }}-{{ $name }}
spec: {}
---
{{ end }}
{{ end }}
{{- end -}}
