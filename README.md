# Helm Chart for mlflow

[![CircleCI](https://circleci.com/gh/cetic/helm-mlflow.svg?style=svg)](https://circleci.com/gh/cetic/helm-mlflow/tree/master) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![version](https://img.shields.io/github/tag/cetic/helm-mlflow.svg?label=release)

## Introduction

This [Helm](https://github.com/kubernetes/helm) chart installs [mlflow](https://github.com/mlflow/mlflow) in a Kubernetes cluster.

## Prerequisites

- Kubernetes cluster 1.10+
- Helm 2.8.0+
- PV provisioner support in the underlying infrastructure.

## Installation

### Add Helm repository

```bash
helm repo add cetic https://cetic.github.io/helm-charts
helm repo update
```

### Configure the chart

The following items can be set via `--set` flag during installation or configured by editing the `values.yaml` directly (need to download the chart first).

#### Configure the way how to expose mlflow service:

- **Ingress**: The ingress controller must be installed in the Kubernetes cluster.
- **ClusterIP**: Exposes the service on a cluster-internal IP. Choosing this value makes the service only reachable from within the cluster.
- **NodePort**: Exposes the service on each Node’s IP at a static port (the NodePort). You’ll be able to contact the NodePort service, from outside the cluster, by requesting `NodeIP:NodePort`.
- **LoadBalancer**: Exposes the service externally using a cloud provider’s load balancer.

### Install the chart

Install the mlflow helm chart with a release name `my-release`:

```bash
helm install --name my-release cetic/mlflow
```

## Uninstallation

To uninstall/delete the `my-release` deployment:

```bash
helm delete --purge my-release
```

## Configuration

The following table lists the configurable parameters of the mlflow chart and the default values.

| Parameter                                                                   | Description                                                                                                        | Default                         |
| --------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------| ------------------------------- |
| **Image**                                                                   |
| `image.repository`                                                          | MLFlow Image name                                                                                              | `ayadi05/mlflow`         |
| `image.tag`                                                                 | MLFlow Image tag                                                                                               | `1.5.0`                      |
| `image.pullPolicy`                                                          | MLFlow Image pull policy                                                                                       | `IfNotPresent`                  |
| **Outpout configuration**                                                              |
| `backend_store_uri`                                                       | Database which store the metrics file                                                                       | `postgresql://user:password@postgresql.default.svc.cluster.local:5432`                            |
| `default_artifact_root`                                                        | Bucket and path used to save the artifacts                                                                  | `s3://datalake/mlflow/artifacts` |
| **Database configuration**                                                             |
| `db.default.enabled`                                                      | Default database (in container) enabled                                                                          | false                           |
| `db.host`                                                                 | Database host                                                                                                    | postgresql                      |
| `db.port`                                                                 | Database port                                                                                                    | 5432                            |
| `db.user`                                                                 | Database user                                                                                                    | admin                           |
| `db.password`                                                             | Database password                                                                                                | password                        |
| `db.database`                                                             | Database name                                                                                                    | postgres                        |

|**Minio Configuration**                                                                 |
| `minio.url`                                                              | mlflow S3 endpoint url frontend                                                                            | `minio.default.svc.cluster.local:9000`                      |
| `minio.accesskey`                                                              | minio access key                                                                                          | `secret`                          |
| `minio.secretkey`                                                          | minio secret key                                                                               | `secret`                         |
 |**Service**                                                                 |
| `service.type`                                                              | Type of service for MLFlow frontend                                                                            | `NodePort`                      |
| `service.port`                                                              | Port to expose service                                                                                             | `80`                          |
| `service.nodePort`                                                          | Port where the service is reachable                                                                                | `30245`                         |
| `service.loadBalancerIP`                                                    | LoadBalancerIP if service type is `LoadBalancer`                                                                   | `nil`                           |
| `service.loadBalancerSourceRanges`                                          | Address that are allowed when svc is `LoadBalancer`                                                                | `[]`                            |
| `service.annotations`                                                       | Service annotations                                                                                                | `{}`                            |
| **Ingress**                                                                 |
| `ingress.enabled`                                                           | Enables Ingress                                                                                                    | `false`                         |
| `ingress.annotations`                                                       | Ingress annotations                                                                                                | `{}`                            |
| `ingress.path`                                                              | Path to access frontend                                                                                            | `/`                             |
| `ingress.hosts`                                                             | Ingress hosts                                                                                                      | `[]`                            |
| `ingress.tls`                                                               | Ingress TLS configuration                                                                                          | `[]`                            |
| **Resources**                                                               |
| `resources`                                                                 | CPU/Memory resource requests/limits                                                                                | `{}`                            |

## Contributing

Feel free to contribute by making a [pull request](https://github.com/cetic/helm-mlflow/pull/new/master).

Please read the official [Contribution Guide](https://github.com/helm/charts/blob/master/CONTRIBUTING.md) from Helm for more information on how you can contribute to this Chart.

## License

[Apache License 2.0](/LICENSE.md)
