# pygisapi

Tools to process gis file as API endpoints

[See documentation](https://github.com/3slab/pygisapi).

## TL;DR;

```bash
$ helm install suez/pygisapi --version=1.0.0 --dry-run --debug
```

## Introduction

This chart pygisapi deploys a [pygisapi](https://github.com/3slab/pygisapi) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name=my-release suez/pygisapi --version=1.0.0 --dry-run --debug
```

The command deploys pygisapi on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release --purge --dry-run --debug
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the pygisapi chart and their default values.

| Parameter                          | Description                                                   | Default                        |
| ---------------------------------- | ------------------------------------------------------------- | ------------------------------ |
| `replicaCount`                     | Number of pods you want                                       | `1`                            |
| `strategy`                         | Specifies the strategy used to replace old Pods by new ones   | `Recreate`                     |
| `image.repository`                 | `pygisapi` image repository                                   | `3slab/pygisapi`               |
| `image.tag`                        | `pygisapi` image tag                                          | `latest`                       |
| `image.pullPolicy`                 | Image pull policy                                             | `IfNotPresent`                 |
| `nameOverride`                     | Override the app name                                         | `nil`                          |
| `fullnameOverride`                 | Override the fullname of the chart                            | `nil`                          |
| `imagePullSecrets`                 | The secret to use for pulling the images for all deployments  | `[]`                           |
| `service.type`                     | Service type                                                  | `ClusterIP`                    |
| `service.port`                     | Service port                                                  | `80`                           |
| `ingress.enabled`                  | Enable ingress controller resource                            | `false`                        |
| `ingress.annotations`              | Ingress annotations                                           | `{}`                           |
| `ingress.path`                     | Ingress path                                                  | `/`                            |
| `ingress.hosts`                    | Ingress host                                                  | ``                             |
| `ingress.tls`                      | Ingress tsl                                                   | `[]`                           |
| `env`                              | Custom environment variables                                  | `[]`                           |
| `resources`                        | CPU/Memory resource requests/limits                           | `nil`                          |
| `nodeSelector`                     | Node labels for pod assignment                                | `{}`                           |
| `affinity`                         | Affinity settings for pod assignment                          | `{}`                           |
| `tolerations`                      | Toleration labels for pod assignment                          | `[]`                           |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set image.tag=my-tag,nameOverride=mygisapi \
    suez/pygisapi --version=1.0.0 --dry-run --debug
```

The above command creates a pygisapi deployment with the image tag named `my-tag`. Additionally it override name of the chart `mygisapi`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml suez/pygisapi --version=1.0.0 --dry-run --debug
```

> **Tip**: You can use the default [values.yaml](values.yaml)
