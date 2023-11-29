# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/giantswarm/cluster-eks/compare/v0.6.2...HEAD
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
