# CRONJOB

Cron is used to automatically execute script.

## TL;DR;

```bash
$ helm install suez/cronjob --version=1.3.0 --dry-run --debug
```

## Introduction

This chart allow to create a cronjob on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure (Only when persisting data)

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name=my-release suez/cronjob --version=1.3.0 --dry-run --debug
```

The command deploys the cronjob on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the Cronjob chart and their default values.

| Parameter                     | Description                                                              | Default                        |
| ----------------------------- | ------------------------------------------------------------------------ | ------------------------------ |
| `image`                       | `cronjob` image                                                          | `cronjob`                      |
| `image.registry`              | `cronjob` image registry                                                 | `docker.io`                    |
| `image.repository`            | `cronjob` image repository                                               | `suezenv/cronjob`              |
| `image.tag`                   | `cronjob` image tag                                                      | `5.2.7`                        |
| `image.pullPolicy`            | Image pull policy                                                        | `IfNotPresent`                 |
| `image.pullSecrets`           | container image pull secrets                                             |                                |
| `nameOverride`                | Override the app name                                                    | ``                             |
| `fullnameOverride`            | Override the fullname of the chart                                       | ``                             |
| `schedule`                    | Schedule for the CronJob.                                                | `0 0 * * *`                    |
| `timeZone`                    | Specify a time zone for a CronJob.                                       | `Europe/Paris"`                |
| `successfulJobsHistoryLimit`  | Specify the number of completed Jobs to keep.                            | `nil`                          |
| `failedJobsHistoryLimit`      | Specify the number of failed Jobs to keep.                               | `nil`                          |
| `backoffLimit`                | Specify the number of retry.                                             | `nil`                          |
| `concurrencyPolicy`           | Specify how to treat concurrent executions of a job.                     | `nil`                          |
| `env`                         | Environment variables that are passed to the container and the webserver | `[]`                           |
| `command`                     | Command to execute                                                       | `[]`                           |
| `args`                        | Args for the command                                                     | `[]`                           |
| `volumeMounts`                | Volume mounts to configure configmap                                     | `[]`                           |
| `configMap`                   | ConfigMap ressources                                                     | `nil`                          |
| `configMap.enable`            | ConfigMap enable                                                         | `false`                        |
| `configMap.name`              | ConfigMap name                                                           | `self-service-password-config` |
| `configMap.data`              | ConfigMap data                                                           | `self-service-password-config` |
| `volumes`                     | Volumes                                                                  | `[]`                           |
| `resources`                   | CPU/Memory resource requests/limits                                      | ``                             |
| `nodeSelector`                | Node labels for pod assignment                                           | {}                             |
| `affinity`                    | Affinity settings for pod assignment                                     | {}                             |
| `tolerations`                 | Toleration labels for pod assignment                                     | []                             |
| `metadata.labels`             | Metadata labels for pod assignment                                       | []                             |
| `jobTemplate.metadata.labels` | Metadata labels for jobTemplate assignment                               | []                             |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set image.tag=my-tag,nameOverride=cronjob \
    suez/cronjob --version=1.3.0 --dry-run --debug
```

The above command creates a cronjob with the image tag named `my-tag`. Additionally it override name of the chart `cronjob`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml suez/cronjob --version=1.3.0 --dry-run --debug
```

> **Tip**: You can use the default [values.yaml](values.yaml)
