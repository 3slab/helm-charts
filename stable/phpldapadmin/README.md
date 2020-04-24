# Phpldapadmin

Phpldapadmin is used to catch mail in dev environment or preprod.

[See documentation](https://github.com/Suezenv/phpldapadmin-docker).

## TL;DR;

```bash
$ helm install suez/phpldapadmin --version=1.0.0 --dry-run --debug
```

## Introduction

This chart phpldapadmin a [Phpldapadmin](https://github.com/Suezenv/phpldapadmin-docker) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure (Only when persisting data)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name=my-release suez/phpldapadmin --version=1.0.0 --dry-run --debug
```

The command deploys Phpldapadmin on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release --purge --dry-run --debug
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the Phpldapadmin chart and their default values.

| Parameter                     | Description                                                       | Default                             |
| ----------------------------- | ----------------------------------------------------------------- | ----------------------------------- |
| `replicaCount`                | Number of pods you want                                           | `1`                                 |
| `strategy`                    | Specifies the strategy used to replace old Pods by new ones       | `Recreate`                          |
| `image`                       | `phpldapadmin` image                                              | `phpldapadmin`                      |
| `image.repository`            | `phpldapadmin` image repository                                   | `suezenv/phpldapadmin-docker`       |
| `image.tag`                   | `phpldapadmin` image tag                                          | `latest`                            |
| `image.pullPolicy`            | Image pull policy                                                 | `IfNotPresent`                      |
| `nameOverride`                | Override the app name                                             | ``                                  |
| `fullnameOverride`            | Override the fullname of the chart                                | ``                                  |
| `imagePullSecrets`            | The secret to use for pulling the images for all deployments      | `[]`                                |
| `service.type`                | Service type                                                      | `ClusterIP`                         |
| `service.port`                | Service port                                                      | `80`                                |
| `service.secureport`          | Service secureport (https)                                        | `443`                               |
| `ingress.enabled`             | Enable ingress controller resource                                | `false`                             |
| `ingress.annotations`         | Ingress annotations                                               | `{}`                                |
| `ingress.path`                | Ingress path                                                      | `/`                                 |
| `ingress.hosts`               | Ingress host                                                      | ``                                  |
| `ingress.tls`                 | Ingress tsl                                                       | `[]`                                |
| `env`                         | Map of env vars (key/value)                                       | `[]`                                |
| `volumeMounts`                | Volume mounts to configure configmap                              | `[]`                                |
| `volumes`                     | Volumes                                                           | `[]`                                |
| `configMap`                   | ConfigMap ressources                                              | `nil`                               |
| `configMap.template.enable`   | ConfigMap config enable                                           | `false`                             |
| `configMap.template.name`     | ConfigMap config name                                             | `phpldapadmin-template`             |
| `resources`                   | CPU/Memory resource requests/limits                               | ``                                  |
| `nodeSelector`                | Node labels for pod assignment                                    | `{}`                                |
| `affinity`                    | Affinity settings for pod assignment                              | `{}`                                |
| `tolerations`                 | Toleration labels for pod assignment                              | `[]`                                |

The above parameters map to the env variables defined in [Phpldapadmin](https://github.com/Suezenv/phpldapadmin-docker).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set image.tag=my-tag,nameOverride=phpldapadmin \
    suez/phpldapadmin --version=1.0.0 --dry-run --debug
```

The above command creates a Phpldapadmin deployment with the image tag named `my-tag`. Additionally it override name of the chart `phpldapadmin`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml suez/phpldapadmin --version=1.0.0 --dry-run --debug
```

> **Tip**: You can use the default [values.yaml](values.yaml)

To use configMap:

- You have to create a folder at the root of your file `values.yaml`
 
For example, if you want use your own config, tree view will be like this:

```bash
.
├── phpldapadmin
│   ├── values.yaml
│   └── config
|       ├── conf
|       |   └── config.inc.php
|       └── images
|       |   └── image_projet.logo.svg
|       └──
└──
```
