# Values schema documentation

This page lists all available configuration options, based on the [configuration values schema](values.schema.json).

Note that configuration options can change between releases. Use the GitHub function for selecting a branch/tag to view the documentation matching your cluster-eks version.

<!-- Update the content below by executing (from the repo root directory)

schemadocs generate helm/cluster-eks/values.schema.json -o helm/cluster-eks/README.md

-->

<!-- DOCS_START -->

### AWS settings
Properties within the `.global.providerSpecific` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.providerSpecific.additionalResourceTags` | **Additional resource tags** - Additional tags to add to AWS resources created by the cluster.|**Type:** `object`<br/>|
| `global.providerSpecific.additionalResourceTags.*` | **Tag value**|**Type:** `string`<br/>**Value pattern:** `^[ a-zA-Z0-9\._:/=+-@]+$`<br/>|
| `global.providerSpecific.ami` | **Amazon machine image (AMI)** - If specified, this image will be used to provision EC2 instances.|**Type:** `string`<br/>|
| `global.providerSpecific.awsAccountId` | **AWS account ID** - AWS Account ID of the AWSClusterRoleIdentity IAM role, recommendation is to leave this value empty as it will be automatically calculated. This value is needed for tests.|**Type:** `string`<br/>**Value pattern:** `^[0-9]{0,12}$`<br/>**Default:** `""`|
| `global.providerSpecific.awsClusterRoleIdentityName` | **Cluster role identity name** - Name of an AWSClusterRoleIdentity object. This in turn refers to the IAM role used to create all AWS cloud resources when creating the cluster. The role can be in another AWS account in order to create all resources in that account. Note: This name does not refer directly to an IAM role name/ARN.|**Type:** `string`<br/>**Value pattern:** `^[-a-zA-Z0-9_\.]{1,63}$`<br/>**Default:** `"default"`|
| `global.providerSpecific.region` | **Region**|**Type:** `string`<br/>|

### Connectivity
Properties within the `.global.connectivity` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.connectivity.availabilityZoneUsageLimit` | **Availability zones** - Maximum number of availability zones (AZ) that should be used in a region. If a region has more than this number of AZs then this number of AZs will be picked randomly when creating subnets.|**Type:** `integer`<br/>**Default:** `3`|
| `global.connectivity.baseDomain` | **Base DNS domain**|**Type:** `string`<br/>|
| `global.connectivity.network` | **Network**|**Type:** `object`<br/>|
| `global.connectivity.network.pods` | **Pods**|**Type:** `object`<br/>|
| `global.connectivity.network.pods.cidrBlocks` | **Pod subnets**|**Type:** `array`<br/>**Default:** `["100.64.0.0/16"]`|
| `global.connectivity.network.pods.cidrBlocks[*]` | **Pod subnet** - IPv4 address range for pods, in CIDR notation. Must be within the 100.64.0.0/10 or 198.19.0.0/16 range. The CIDR block size must be betwen /16 and /28.|**Type:** `string`<br/>**Example:** `"100.64.0.0/16"`<br/>|
| `global.connectivity.network.services` | **Services**|**Type:** `object`<br/>|
| `global.connectivity.network.services.cidrBlocks` | **K8s Service subnets**|**Type:** `array`<br/>**Default:** `["172.31.0.0/16"]`|
| `global.connectivity.network.services.cidrBlocks[*]` | **Service subnet** - IPv4 address range for kubernetes services, in CIDR notation.|**Type:** `string`<br/>**Example:** `"172.31.0.0/16"`<br/>|
| `global.connectivity.network.vpcCidr` | **VPC subnet** - IPv4 address range to assign to this cluster's VPC, in CIDR notation.|**Type:** `string`<br/>**Default:** `"10.0.0.0/16"`|
| `global.connectivity.proxy` | **Proxy** - Whether/how outgoing traffic is routed through proxy servers.|**Type:** `object`<br/>|
| `global.connectivity.proxy.enabled` | **Enable**|**Type:** `boolean`<br/>|
| `global.connectivity.proxy.httpProxy` | **HTTP proxy** - To be passed to the HTTP_PROXY environment variable in all hosts.|**Type:** `string`<br/>|
| `global.connectivity.proxy.httpsProxy` | **HTTPS proxy** - To be passed to the HTTPS_PROXY environment variable in all hosts.|**Type:** `string`<br/>|
| `global.connectivity.proxy.noProxy` | **No proxy** - To be passed to the NO_PROXY environment variable in all hosts.|**Type:** `string`<br/>|
| `global.connectivity.subnets` | **Subnets** - Subnets are created and tagged based on this definition.|**Type:** `array`<br/>**Default:** `[{"cidrBlocks":[{"availabilityZone":"a","cidr":"10.0.0.0/20"},{"availabilityZone":"b","cidr":"10.0.16.0/20"},{"availabilityZone":"c","cidr":"10.0.32.0/20"}],"isPublic":true},{"cidrBlocks":[{"availabilityZone":"a","cidr":"10.0.64.0/18"},{"availabilityZone":"b","cidr":"10.0.128.0/18"},{"availabilityZone":"c","cidr":"10.0.192.0/18"}],"isPublic":false}]`|
| `global.connectivity.subnets[*]` | **Subnet**|**Type:** `object`<br/>|
| `global.connectivity.subnets[*].cidrBlocks` | **Network**|**Type:** `array`<br/>|
| `global.connectivity.subnets[*].cidrBlocks[*]` |**None**|**Type:** `object`<br/>|
| `global.connectivity.subnets[*].cidrBlocks[*].availabilityZone` | **Availability zone**|**Type:** `string`<br/>**Example:** `"a"`<br/>|
| `global.connectivity.subnets[*].cidrBlocks[*].cidr` | **Address range** - IPv4 address range, in CIDR notation.|**Type:** `string`<br/>|
| `global.connectivity.subnets[*].cidrBlocks[*].tags` | **Tags** - AWS resource tags to assign to this subnet.|**Type:** `object`<br/>|
| `global.connectivity.subnets[*].cidrBlocks[*].tags.*` | **Tag value**|**Type:** `string`<br/>**Value pattern:** `^[ a-zA-Z0-9\._:/=+-@]+$`<br/>|
| `global.connectivity.subnets[*].isPublic` | **Public**|**Type:** `boolean`<br/>|
| `global.connectivity.subnets[*].tags` | **Tags** - AWS resource tags to assign to this CIDR block.|**Type:** `object`<br/>|
| `global.connectivity.subnets[*].tags.*` | **Tag value**|**Type:** `string`<br/>**Value pattern:** `^[ a-zA-Z0-9\._:/=+-@]+$`<br/>|

### Control plane
Properties within the `.global.controlPlane` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.controlPlane.apiMode` | **API mode** - Whether the Kubernetes API server load balancer should be reachable from the internet (public) or internal only (private).|**Type:** `string`<br/>**Default:** `"public"`|
| `global.controlPlane.logging` | **Logging**|**Type:** `object`<br/>|
| `global.controlPlane.logging.apiServer` | **Api Server** - Enable or disable Api server logging to CloudWatch (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html).|**Type:** `boolean`<br/>**Default:** `true`|
| `global.controlPlane.logging.audit` | **Audit** - Enable or disable audit logging to CloudWatch (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html).|**Type:** `boolean`<br/>**Default:** `true`|
| `global.controlPlane.logging.authenticator` | **Authenticator** - Enable or disable IAM Authenticator logging to CloudWatch (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html).|**Type:** `boolean`<br/>**Default:** `true`|
| `global.controlPlane.logging.controllerManager` | **Controller Manager** - Enable or disable Controller Manager logging to CloudWatch (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html).|**Type:** `boolean`<br/>**Default:** `true`|
| `global.controlPlane.oidcIdentityProviderConfig` | **OIDC identity provider config** - OIDC identity provider configuration for the Kubernetes API server.|**Type:** `object`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.clientId` | **Client ID** - Client ID of the OIDC identity provider.|**Type:** `string`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.groupsClaim` | **Groups claim** - Claim to use for mapping groups.|**Type:** `string`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.groupsPrefix` | **Groups prefix** - Prefix to use for mapping groups.|**Type:** `string`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.identityProviderConfigName` | **Identity provider config name** - Name of the OIDC identity provider config.|**Type:** `string`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.issuerUrl` | **Issuer URL** - URL of the OIDC identity provider.|**Type:** `string`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.requiredClaims` | **Required claims** - Required claims for the OIDC identity provider.|**Type:** `object`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.requiredClaims.*` | **Claim**|**Type:** `string`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.tags` | **Tags** - AWS resource tags to assign to the IAM OIDC provider.|**Type:** `object`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.tags.*` | **Tag value**|**Type:** `string`<br/>**Value pattern:** `^[ a-zA-Z0-9\._:/=+-@]+$`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.usernameClaim` | **Username claim** - Claim to use for mapping usernames.|**Type:** `string`<br/>|
| `global.controlPlane.oidcIdentityProviderConfig.usernamePrefix` | **Username prefix** - Prefix to use for mapping usernames.|**Type:** `string`<br/>|
| `global.controlPlane.roleMapping` | **Role mappings**|**Type:** `array`<br/>|
| `global.controlPlane.roleMapping[*]` | **Role mapping** - Maps AWS IAM role to Kubernetes role.|**Type:** `object`<br/>|
| `global.controlPlane.roleMapping[*].groups` | **Groups** - Kubernetes groups.|**Type:** `array`<br/>|
| `global.controlPlane.roleMapping[*].groups[*]` | **Group** - Kubernetes group, for example `system:masters`.|**Type:** `string`<br/>|
| `global.controlPlane.roleMapping[*].rolearn` | **AWS Role ARN** - Full ARN of the AWS IAM role.|**Type:** `string`<br/>|
| `global.controlPlane.roleMapping[*].username` | **Kubernetes username** - Kubernetes username, for example `cluster-admin`.|**Type:** `string`<br/>|

### Internal
Properties within the `.internal` top-level object
For Giant Swarm internal use only, not stable, or not supported by UIs.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `internal.hashSalt` | **Hash salt** - If specified, this token is used as a salt to the hash suffix of some resource names. Can be used to force-recreate some resources.|**Type:** `string`<br/>|
| `internal.kubernetesVersion` | **Kubernetes version**|**Type:** `string`<br/>**Example:** `"1.24.7"`<br/>**Default:** `"1.24.10"`|
| `internal.nodePools` | **Default node pool**|**Type:** `object`<br/>**Default:** `{"def00":{"customNodeLabels":["label=default"],"instanceType":"r6i.xlarge","maxSize":4,"minSize":3}}`|
| `internal.nodePools.PATTERN` | **Node pool**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.availabilityZones` | **Availability zones**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.availabilityZones[*]` | **Availability zone**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.customNodeLabels` | **Custom node labels**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.customNodeLabels[*]` | **Label**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.customNodeTaints` | **Custom node taints**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.customNodeTaints[*]` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.customNodeTaints[*].effect` | **Effect**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.customNodeTaints[*].key` | **Key**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.customNodeTaints[*].value` | **Value**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.instanceType` | **EC2 instance type**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.maxSize` | **Maximum number of nodes**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.minSize` | **Minimum number of nodes**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.rootVolumeSizeGB` | **Root volume size (GB)**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.subnetTags` | **Subnet tags** - Tags to filter which AWS subnets will be used for this node pool.|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.subnetTags[*]` | **Subnet tag**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `internal.nodePools.PATTERN.subnetTags[*].*` | **Tag value**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>**Value pattern:** `^[ a-zA-Z0-9\._:/=+-@]+$`<br/>|
| `internal.sandboxContainerImage` | **Kubectl image**|**Type:** `object`<br/>|
| `internal.sandboxContainerImage.name` | **Repository**|**Type:** `string`<br/>**Default:** `"giantswarm/pause"`|
| `internal.sandboxContainerImage.registry` | **Registry**|**Type:** `string`<br/>**Default:** `"quay.io"`|
| `internal.sandboxContainerImage.tag` | **Tag**|**Type:** `string`<br/>**Default:** `"3.9"`|

### Kubectl image
Properties within the `.kubectlImage` top-level object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `kubectlImage.name` | **Repository**|**Type:** `string`<br/>**Default:** `"giantswarm/kubectl"`|
| `kubectlImage.registry` | **Registry**|**Type:** `string`<br/>**Default:** `"quay.io"`|
| `kubectlImage.tag` | **Tag**|**Type:** `string`<br/>**Default:** `"1.23.5"`|

### Metadata
Properties within the `.global.metadata` object

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.metadata.description` | **Cluster description** - User-friendly description of the cluster's purpose.|**Type:** `string`<br/>|
| `global.metadata.name` | **Cluster name** - Unique identifier, cannot be changed after creation.|**Type:** `string`<br/>|
| `global.metadata.organization` | **Organization**|**Type:** `string`<br/>|
| `global.metadata.preventDeletion` | **Prevent cluster deletion**|**Type:** `boolean`<br/>**Default:** `false`|
| `global.metadata.servicePriority` | **Service priority** - The relative importance of this cluster.|**Type:** `string`<br/>**Default:** `"highest"`|

### Node pools
Properties within the `.global.nodePools` object
Node pools of the cluster. If not specified, this defaults to the value of `internal.nodePools`.

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.nodePools.PATTERN` | **Node pool**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.availabilityZones` | **Availability zones**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.availabilityZones[*]` | **Availability zone**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeLabels` | **Custom node labels**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeLabels[*]` | **Label**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints` | **Custom node taints**|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints[*]` |**None**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints[*].effect` | **Effect**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints[*].key` | **Key**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.customNodeTaints[*].value` | **Value**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.instanceType` | **EC2 instance type**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.maxSize` | **Maximum number of nodes**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.minSize` | **Minimum number of nodes**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.rootVolumeSizeGB` | **Root volume size (GB)**|**Type:** `integer`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.subnetTags` | **Subnet tags** - Tags to filter which AWS subnets will be used for this node pool.|**Type:** `array`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.subnetTags[*]` | **Subnet tag**|**Type:** `object`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>|
| `global.nodePools.PATTERN.subnetTags[*].*` | **Tag value**|**Type:** `string`<br/>**Key pattern:**<br/>`PATTERN`=`^[a-z0-9]{5,10}$`<br/>**Value pattern:** `^[ a-zA-Z0-9\._:/=+-@]+$`<br/>|

### Other global

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `global.managementCluster` | **Management cluster** - Name of the Cluster API cluster managing this workload cluster.|**Type:** `string`<br/>|

### Other

| **Property** | **Description** | **More Details** |
| :----------- | :-------------- | :--------------- |
| `baseDomain` | **Base DNS domain**|**Type:** `string`<br/>|
| `cluster-shared` | **Library chart**|**Type:** `object`<br/>|
| `managementCluster` | **Management cluster** - Name of the Cluster API cluster managing this workload cluster.|**Type:** `string`<br/>|
| `provider` | **Cluster API provider name**|**Type:** `string`<br/>|



<!-- DOCS_END -->
