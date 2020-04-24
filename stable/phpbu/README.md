# PHPBU

Phpbu is used to backup database.

[See documentation](https://phpbu.de/documentation.html).

## TL;DR;

```bash
$ helm install suez/phpbu --version=1.0.0 --dry-run --debug
```

## Introduction

This chart phpbu a [Phpbu](https://phpbu.de/documentation.html) cronjob on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure (Only when persisting data)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name=my-release suez/phpbu --version=1.0.0 --dry-run --debug
```

The command deploys Phpbu on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the Phpbu chart and their default values.

| Parameter                     | Description                                                               | Default               |
| ----------------------------- | -----------------------------------------------------                     | --------------------- |
| `image`                       | `phpbu` image                                                             | `phpbu`               |
| `image.registry`              | `phpbu` image registry                                                    | `docker.io`           |
| `image.repository`            | `phpbu` image repository                                                  | `suezenv/phpbu`       |
| `image.tag`                   | `phpbu` image tag                                                         | `5.2.7`               |
| `image.pullPolicy`            | Image pull policy                                                         | `IfNotPresent`        |
| `nameOverride`                | Override the app name                                                     | ``                    |
| `fullnameOverride`            | Override the fullname of the chart                                        | ``                    |
| `schedule`                    | Schedule for the CronJob.                                                 | `0 0 * * *`           |
| `successfulJobsHistoryLimit`  | Specify the number of completed Jobs to keep.                             | `nil`                 |
| `failedJobsHistoryLimit`      | Specify the number of failed Jobs to keep.                                | `nil`                 |
| `concurrencyPolicy`           | Specify how to treat concurrent executions of a job.                      | `nil`                 |
| `backoffLimit`                | Specify the number of retry.                                              | `nil`                 |
| `restartPolicy`               | Control the Job restartPolicy.                                            | `nil`                 |
| `command`                     | Container command to execute.                                             | `nil`                 |
| `configMap`                   | ConfigMap ressources                                                      | `nil`                 |
| `configMap.enable`            | ConfigMap enable                                                          | `false`               |
| `configMap.name`              | ConfigMap name                                                            | ``                    |
| `configMap.data`              | ConfigMap data                                                            | `[]`                  |
| `env`                         | Environment variables that are passed to the container and the webserver  | `[]`                  |
| `volumeMounts`                | Volume mounts to configure configmap                                      | `[]`                  |
| `resources`                   | CPU/Memory resource requests/limits                                       | `{}`                  |
| `volumes`                     | Volumes                                                                   | `[]`                  |
| `persistence.enabled`         | Use a PVC to persist data                                                 | `true`                |
| `persistence.name`            | PVC name                                                                  | `nil`                 |
| `persistence.annotations`     | PVC annotations                                                           | `nil`                 |
| `persistence.storageClass`    | Storage class of backing PVC                                              | `nil`                 |
| `persistence.accessMode`      | Use volume as ReadOnly or ReadWrite                                       | `ReadWriteOnce`       |
| `persistence.size`            | Size of data volume                                                       | `10Gi`                |
| `nodeSelector`                | Node labels for pod assignment                                            | `{}`                  |
| `affinity`                    | Affinity settings for pod assignment                                      | `{}`                  |
| `tolerations`                 | Toleration labels for pod assignment                                      | `[]`                  |

The above parameters map to the env variables defined in [phpbu](https://phpbu.de/documentation.html).

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set image.tag=my-tag,nameOverride=phpbu \
    suez/phpbu --version=1.0.0 --dry-run --debug
```

The above command creates a Phpbu cronjob with the image tag named `my-tag`. Additionally it override name of the chart `phpbu`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml suez/phpbu --version=1.0.0 --dry-run --debug
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Metrics

Further, it's possible to create a PrometheusRule ressource for this chart
