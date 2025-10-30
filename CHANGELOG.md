# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Fixed

- Fix availability zone handling in managed machine pool template.

## [1.0.0] - 2025-10-10

### Added

- Add `machine-pool-bootstrap-config` template to render  `MachinePool` bootstrap config.
- Move `MachinePool` to be rendered by `giantswarm/cluster` chart.
- Expose `amiType` for node pools and default to `AL2023_x86_64_STANDARD`.
- Add `giantswarm/cluster` as a chart dependency.

### Changed

- Update API version for HelmReleases to `helm.toolkit.fluxcd.io/v2beta2`.
- Disable privilege escalation for helmrelease cleanup job.
- Use `giantswarm/cluster` to render the `Cluster` object.
- Fix ManagedMachinePool spec.
- Update AWSManagedControlPlane resource to align with the Cluster chart.
- Integrate Releases into the chart.
- Remove MachinePool spec hash from resource names.
- Update `giantswarm/cluster` to 4.0.2.
- Update `aws-ebs-csi-driver-app` to 3.2.0.

### Removed

- Remove deprecated `capi-node-labeler` app.

## [0.19.0] - 2024-09-19

### Fixed

- Give permissions to clean up all used `HelmReleases` to the cleanup job.

### Changed

- Don't delete `HelmRelease` clean up job if it failed.

## [0.18.0] - 2024-09-09

### Removed

- Remove permissive policies removal from cilium-app. There shouldn't be any clusters with those policies installed anymore.

### Changed

- Set `kubeProxyReplacement` to `'true'` instead of deprecated value `strict` in cilium values.
- Set provider specific configuration for cilium CNI ENI values.

## [0.17.1] - 2024-06-04

### Changed

- Fix rendering of control-plane role mapping values.

## [0.17.0] - 2024-06-04

### Changed

- Bump `cilium-app` to version 0.24.0 (cilium v1.15.4).
- Bump `cluster-shared` to version `0.7.1`.
- Fix `update-values-job` to include full CR name for `clusters.cluster.x-k8s.io`.

### Added

- Add network-policies-app with DNS policies enabled. This makes `kube-system` and `giantswarm` namespaces to be `deny` by default.
- Add `cluster-catalog` and `cluster-test-catalog` HelmRepositories.

### Changed

- Disable and remove permissive policies from cilium-app.

## [0.16.0] - 2024-03-20

### Changed

- Update kubernets version to `1.25.16` and remove use of PSPs.

## [0.15.0] - 2024-02-21

### Breaking Changes

- Set `availabilityZoneSubnetType` to `private` for machine pools. This prevents nodes from landing on public subnets. As this is an immutable field, upgrading will cause the existing machine pool will be deleted and replaced with a new one.

## [0.14.0] - 2024-02-13

### Added

- Add option to specify encryption config for the `AWSManagedControlPlane` to encrypt certain Kubernetes resources.

## [0.13.0] - 2024-02-12

### Changed

- Remove `"helm.sh/resource-policy": keep` annotation from node pool resources to properly deleted them when it is removed from helm values.

### Added

- Add propagating tags from `cluster-eks` to resources managed my `ebs-csi-driver`.
- Allow configuration of `subnetIDs` for node pool.
- Add option to configure `updateConfig` for node pool.

## [0.12.0] - 2024-01-30

### Changed

- Remove ingress and egress rules from the security group that AWS creates by default when creating a new VPC.

## [0.11.0] - 2024-01-19

### Changed

- Added additionalTags and annotation in managed machine pool template to support cluster-autoscaler in EKS.
- Render secondary subnets used for pods to the `AWSManagedControlPlane.spec.network.subnets` field.

## [0.10.0] - 2023-12-13

### Changed

- Add option to configure OIDC Provider Config.

## [0.9.0] - 2023-12-12

### Changed

- Move values under `.global`.

## [0.8.0] - 2023-12-12

### Changed

- Support longer node pool names and allow dashes.

## [0.7.0] - 2023-12-06

### Changed

- Fill `AWSManagedControlPlane.spec.network.subnets[*].id` field for managed subnets for compatibility with CAPA v2.3.0

## [0.6.3] - 2023-11-29

### Added

- Add global fields. 

## [0.6.2] - 2023-11-08

### Changed

- Rollback default instance type to `r6i.xlarge`.

## [0.6.1] - 2023-11-08

### Changed

- Increased default instance type to `r6i.2xlarge`.

## [0.6.0] - 2023-11-07

### Added

- Allow configuration of `AWSManagedControlPlane.spec.AdditionalTags` value and add a default giantswarm tag.
- Add `aws-ebs-csi-driver-app` via `HelmRelease` CR.

## [0.5.2] - 2023-10-27

### Changed

- Bump `cilium-app` to version 0.16.0.
- Fetch AWS account ID automatically.

## [0.5.1] - 2023-10-25

### Changed

- Bump `coredns-app` to version 1.19.0 and adjust values.

## [0.5.0] - 2023-10-25

### Changed

- Use Cilium ENI mode.

### Added

- Add option to map custom IAM roles to EKS roles.
- Expose option to configure logging and enable logging by default.

## [0.4.0] - 2023-08-09

### Added

- Configure `IAMAuthenticatorConfig` to allow role `GiantSwarmAdmin` to get `cluster-admin` privileges in the EKS cluster.

## [0.3.2] - 2023-08-04

### Added

- Add annotation to `AWSManagedControlPlane` to enabled garbage collection of  loadbalancers.

## [0.3.1] - 2023-07-20

- Add annotation to `AWSManagedControlPlane` for vpc and dns mode.

## [0.3.0] - 2023-07-12

### Added

- Add `coredns` adopter resource.

## [0.2.0] - 2023-07-07

### Added

- Add CNI/CSI/coredns apps as HelmReleases.

## [0.1.0] - 2023-06-29

### Added

- Add EKS templates.

[Unreleased]: https://github.com/giantswarm/cluster-eks/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/giantswarm/cluster-eks/compare/v0.19.0...v1.0.0
[0.19.0]: https://github.com/giantswarm/cluster-eks/compare/v0.18.0...v0.19.0
[0.18.0]: https://github.com/giantswarm/cluster-eks/compare/v0.17.1...v0.18.0
[0.17.1]: https://github.com/giantswarm/cluster-eks/compare/v0.17.0...v0.17.1
[0.17.0]: https://github.com/giantswarm/cluster-eks/compare/v0.16.0...v0.17.0
[0.16.0]: https://github.com/giantswarm/cluster-eks/compare/v0.15.0...v0.16.0
[0.15.0]: https://github.com/giantswarm/cluster-eks/compare/v0.14.0...v0.15.0
[0.14.0]: https://github.com/giantswarm/cluster-eks/compare/v0.13.0...v0.14.0
[0.13.0]: https://github.com/giantswarm/cluster-eks/compare/v0.12.0...v0.13.0
[0.12.0]: https://github.com/giantswarm/cluster-eks/compare/v0.11.0...v0.12.0
[0.11.0]: https://github.com/giantswarm/cluster-eks/compare/v0.10.0...v0.11.0
[0.10.0]: https://github.com/giantswarm/cluster-eks/compare/v0.9.0...v0.10.0
[0.9.0]: https://github.com/giantswarm/cluster-eks/compare/v0.8.0...v0.9.0
[0.8.0]: https://github.com/giantswarm/cluster-eks/compare/v0.7.0...v0.8.0
[0.7.0]: https://github.com/giantswarm/cluster-eks/compare/v0.6.3...v0.7.0
[0.6.3]: https://github.com/giantswarm/cluster-eks/compare/v0.6.2...v0.6.3
[0.6.2]: https://github.com/giantswarm/cluster-eks/compare/v0.6.1...v0.6.2
[0.6.1]: https://github.com/giantswarm/cluster-eks/compare/v0.6.0...v0.6.1
[0.6.0]: https://github.com/giantswarm/cluster-eks/compare/v0.5.2...v0.6.0
[0.5.2]: https://github.com/giantswarm/cluster-eks/compare/v0.5.1...v0.5.2
[0.5.1]: https://github.com/giantswarm/cluster-eks/compare/v0.5.0...v0.5.1
[0.5.0]: https://github.com/giantswarm/cluster-eks/compare/v0.4.0...v0.5.0
[0.4.0]: https://github.com/giantswarm/cluster-eks/compare/v0.3.2...v0.4.0
[0.3.2]: https://github.com/giantswarm/cluster-eks/compare/v0.3.1...v0.3.2
[0.3.1]: https://github.com/giantswarm/cluster-eks/compare/v0.3.0...v0.3.1
[0.3.0]: https://github.com/giantswarm/cluster-eks/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/giantswarm/cluster-eks/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/giantswarm/cluster-eks/releases/tag/v0.1.0
