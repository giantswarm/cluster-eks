# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed

- Remove `"helm.sh/resource-policy": keep` annotation from node pool resources to properly deleted them when it is removed from helm values.

### Added

- Add option to specify encryption config for the `AWSManagedControlPlane` to encrypt certain Kubernetes resources.
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

[Unreleased]: https://github.com/giantswarm/cluster-eks/compare/v0.12.0...HEAD
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
