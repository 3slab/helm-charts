# Simplesamlphp

We use simplesamlphp to log user with an LDAP.

[See documentation](https://simplesamlphp.org/).

## TL;DR;

```bash
$ helm install suez/simplesamlphp --version=1.3.0 --dry-run --debug
```

## Introduction

This chart simplesamlphp a [Simplesamlphp](https://simplesamlphp.org/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure (Only when persisting data)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name=my-release suez/simplesamlphp --version=1.3.0 --dry-run --debug
```

The command deploys Simplesamlphp on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release --purge --dry-run --debug
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the Simplesamlphp chart and their default values.

| Parameter                     | Description                                                   | Default                    |
| ----------------------------- | ------------------------------------------------------------- | -------------------------- |
| `replicaCount`                | Number of pods you want                                       | `1`                        |
| `strategy`                    | Specifies the strategy used to replace old Pods by new ones   | `Recreate`                 |
| `image`                       | `simplesamlphp` image                                         | `simplesamlphp`            |
| `image.repository`            | `simplesamlphp` image repository                              | `suezenv/simplesamlphp`    |
| `image.tag`                   | `simplesamlphp` image tag                                     | `5.2.7`                    |
| `image.pullPolicy`            | Image pull policy                                             | `IfNotPresent`             |
| `nameOverride`                | Override the app name                                         | ``                         |
| `fullnameOverride`            | Override the fullname of the chart                            | ``                         |
| `imagePullSecrets`            | The secret to use for pulling the images for all deployments  | `[]`                       |
| `service.type`                | Service type                                                  | `ClusterIP`                |
| `service.port`                | Service port                                                  | `80`                       |
| `service.secureport`          | Service secureport (https)                                    | `443`                      |
| `ingress.enabled`             | Enable ingress controller resource                            | `false`                    |
| `ingress.annotations`         | Ingress annotations                                           | `{}`                       |
| `ingress.path`                | Ingress path                                                  | `/`                        |
| `ingress.hosts`               | Ingress host                                                  | ``                         |
| `ingress.tls`                 | Ingress tsl                                                   | `[]`                       |
| `volumeMounts`                | Volume mounts to configure configmap                          | `[]`                       |
| `volumes`                     | Volumes                                                       | `[]`                       |
| `configMap`                   | ConfigMap ressources                                          | `nil`                      |
| `configMap.cert.enable`       | ConfigMap cert enable                                         | `false`                    |
| `configMap.cert.name`         | ConfigMap cert name                                           | `simplesamlphp-cert`       |
| `configMap.config.enable`     | ConfigMap config enable                                       | `false`                    |
| `configMap.config.name`       | ConfigMap config name                                         | `simplesamlphp-config`     |
| `configMap.metadata.enable`   | ConfigMap metadata enable                                     | `false`                    |
| `configMap.metadata.name`     | ConfigMap metadata name                                       | `simplesamlphp-metadata`   |
| `configMap.data.enable`       | ConfigMap data enable                                         | `false`                    |
| `configMap.data.name`         | ConfigMap data name                                           | `simplesamlphp-data`       |
| `resources`                   | CPU/Memory resource requests/limits                           | ``                         |
| `nodeSelector`                | Node labels for pod assignment                                | `{}`                       |
| `affinity`                    | Affinity settings for pod assignment                          | `{}`                       |
| `tolerations`                 | Toleration labels for pod assignment                          | `[]`                       |

The above parameters map to the env variables defined in [simplesamlphp](https://simplesamlphp.org/).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set image.tag=my-tag,nameOverride=simplesamlphp \
    suez/simplesamlphp --version=1.0.0 --dry-run --debug
```

The above command creates a Simplesamlphp deployment with the image tag named `my-tag`. Additionally it override name of the chart `simplesamlphp`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml suez/simplesamlphp --version=1.0.0 --dry-run --debug
```

> **Tip**: You can use the default [values.yaml](values.yaml)

To use configMap:

- You have to create a folder at the root of your file `values.yaml`
 
For example, if you want use your own cert, tree view will be like this:

```bash
.
├── simplesamlphp
│   ├── values.yaml
│   └── cert
|       └── mycert.crt
└──
```
Full example:
```bash
.
├── simplesamlphp
│   ├── values.yaml
│   ├── cert
|   |   └── mycert.crt
|   ├── config
|   |   ├── authsources.php
|   |   └── config.php
|   ├── metadata
|   |   ├── saml20-idp-hosted.php
|   |   └── saml20-sp-remote.php
|   ├── data
|   |   └── etc-httpd
|   |       └── conf.d
|   |           └── ssp.conf
|   └──
└──
```

For data, you have to specify each file location.

For example, volumeMounts and volumes will be like this:

```yaml
volumeMounts:
  - mountPath: /etc/httpd/conf.d/ssp.conf
    name: simplesamlphp-data-vol

volumes:
  - name: simplesamlphp-data-vol
    configMap:
      name: simplesamlphp-data
```
