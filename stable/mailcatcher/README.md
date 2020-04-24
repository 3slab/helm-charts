# MailCatcher

MailCatcher is used to catch mail in dev environment or preprod.

[See documentation](https://mailcatcher.me/).

## TL;DR;

```bash
$ helm install suez/mailcatcher --version=1.0.0 --dry-run --debug
```

## Introduction

This chart mailCatcher a [MailCatcher](https://mailcatcher.me/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure (Only when persisting data)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name=my-release suez/mailcatcher --version=1.0.0 --dry-run --debug
```

The command deploys MailCatcher on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release --purge --dry-run --debug
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the MailCatcher chart and their default values.

| Parameter                     | Description                                     | Default                    |
| ----------------------------- | ---------------------------------------------   | -------------------------- |
| `replicaCount`                | Number of pods you want                         | `1`                        |
| `image`                       | `mailcatcher` image                             | `mailcatcher`              |
| `image.repository`            | `mailcatcher` image repository                  | `schickling/mailcatcher`   |
| `image.tag`                   | `mailcatcher` image tag                         | `latest`                   |
| `image.pullPolicy`            | Image pull policy                               | `IfNotPresent`             |
| `nameOverride`                | Override the app name                           | ``                         |
| `fullnameOverride`            | Override the fullname of the chart              | ``                         |
| `service.type`                | Service type                                    | `ClusterIP`                |
| `service.port`                | Service port                                    | `80`                       |
| `service.secureport`          | Service secureport (https)                      | `443`                      |
| `ingress.enabled`             | Enable ingress controller resource              | `false`                    |
| `ingress.annotations`         | Ingress annotations                             | `{}`                       |
| `ingress.path`                | Ingress path                                    | `/`                        |
| `ingress.hosts`               | Ingress host                                    | ``                         |
| `ingress.tls`                 | Ingress tsl                                     | `[]`                       |
| `resources`                   | CPU/Memory resource requests/limits             | ``                         |
| `nodeSelector`                | Node labels for pod assignment                  | `{}`                       |
| `affinity`                    | Affinity settings for pod assignment            | `{}`                       |
| `tolerations`                 | Toleration labels for pod assignment            | `[]`                       |

The above parameters map to the env variables defined in [MailCatcher](https://mailcatcher.me/).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set image.tag=my-tag,nameOverride=mailcatcher \
    suez/mailcatcher --version=1.0.0 --dry-run --debug
```

The above command creates a MailCatcher deployment with the image tag named `my-tag`. Additionally it override name of the chart `mailcatcher`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml suez/mailcatcher --version=1.0.0 --dry-run --debug
```

> **Tip**: You can use the default [values.yaml](values.yaml)
