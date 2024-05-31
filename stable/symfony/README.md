Symfony chart
=============

This chart bootstraps a Symfony application deployment on a [Kubernetes](http://kubernetes.io) cluster using
the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.25+ with Beta APIs enabled

## Configuration

The following table lists the configurable parameters of the chart and their default values.

| Parameter                            | Description                                                                                    | Default                     |
|--------------------------------------|------------------------------------------------------------------------------------------------|-----------------------------|
| `image.repository`                   | container image repository                                                                     | `nginx`                     |
| `image.tag`                          | container image tag                                                                            | `stable`                    |
| `image.pullPolicy`                   | container image pull policy                                                                    | `IfNotPresent`              |
| `image.pullSecrets`                  | container image pull secrets                                                                   |                             |
| `service.enabled`                    | enable the creation of the service resource                                                    | `true`                      |
| `service.name`                       | name of the service                                                                            | `nginx`                     |
| `service.type`                       | type of the service                                                                            | `ClusterIp`                 |
| `service.externalPort`               | external port of the service                                                                   | `80`                        |
| `service.internalPort`               | internal port of the service                                                                   | `80`                        |
| `service.annotations`                | Service annotation configuration                                                               | `{}`                        |
| `livenessProbe`                      | liveness probe (YAML)                                                                          | `{}`                        |
| `readinessProbe`                     | readiness probe (YAML)                                                                         | `{}`                        |
| `resources`                          | resource requests and limits (YAML)                                                            | `{}`                        |
| `nodeSelector`                       | node labels for pod assignment                                                                 |                             |
| `ingress.enabled`                    | Either or not the ingress is enabled                                                           | `false`                     |
| `ingress.hosts`                      | Hosts to reach the application                                                                 | `false`                     |
| `ingress.annotations`                | Ingress annotation configuration                                                               | `false`                     |
| `ingress.tls`                        | TLS support                                                                                    | `false`                     |
| `nginx.enabled`                      | Enable the creation of the configmap resource for nginx                                        | `true`                      |
| `nginx.sourcesPath`                  | Path where the Symfony application is located                                                  | `/var/www/symfony`          |
| `nginx.sourcesDir`                   | Directory in sourcesPath where the Symfony application is located                              | `public`                    |
| `nginx.mainControllerName`           | Directory in sourcesPath where the Symfony application is located                              | `index`                     |
| `nginx.accessLogPath`                | Path where Nginx access_log is located                                                         | `/var/log/nginx/access.log` |
| `nginx.errorLogPath`                 | Path where Nginx error_log is located                                                          | `/var/log/nginx/error.log`  |
| `nginx.locationParams`               | List of params added to location block in nginx config file                                    | `[]`                        |
| `env.container`                      | Environment variables that are passed to the container and the webserver                       |                             |
| `env.initContainer`                  | Environment variables that are passed to each initContainer                                    |                             |
| `extraEnv`                           | Add specific environment variable to the container                                             | `[]`                        |
| `initContainers`                     | Allow to configure initContainers for the deployment (YAML)                                    |                             |
| `secrets`                            | Allow to configure secrets (mounted only for now)                                              |                             |
| `configMap.dollar.enabled`           | Allow to pass variable with $ in value                                                         | `false`                     |
| `job.enabled`                        | Enables a pre-update job                                                                       | `false`                     |
| `job.activeDeadlineSeconds`          | Pod activeDeadlineSeconds parameter                                                            | `60`                        |
| `job.restartPolicy`                  | Pod restartPolicy parameter                                                                    | `Never`                     |
| `job.name`                           | Pod suffixe name (Release.Name+this parameter)                                                 | `job`                       |
| `job.cmd`                            | Command to run                                                                                 | `[]`                        |
| `job.args`                           | Command arguments                                                                              | `[]`                        |
| `job.annotations`                    | Defines the hooks to use and their delete                                                      | `{}`                        |
| `cronjobs`                           | Defines one or multiple cronjobs                                                               | `{}`                        |
| `cronjob.enabled`                    | Enables a  cronjob                                                                             | `false`                     |
| `cronjob.schedule`                   | Cronjob schedule, defaults to "0 0 * * *"                                                      | `0 0 * * *`                 |
| `cronjob.ttlSecondsAfterFinished`    | Specify this field, so that a Job can be cleaned up automatically some time after it finishes. | 172800 #48 hours            |
| `cronjob.failedJobsHistoryLimit`     | This field specifies the number of failed finished jobs to keep.                               | 1                           |
| `cronjob.successfulJobsHistoryLimit` | This field specifies the number of successful finished jobs to keep.                           | 3                           |
| `cronjob.concurrencyPolicy`          | Specifies how to treat concurrent executions of a Job that is created by this CronJob.         | `Allow`                     |
| `cronjob.activeDeadlineSeconds`      | Pod activeDeadlineSeconds parameter                                                            | `60`                        |
| `cronjob.restartPolicy`              | Pod restartPolicy parameter                                                                    | `Never`                     |
| `cronjob.name`                       | Pod suffixe name (Release.Name+this parameter)                                                 | ``                          |
| `cronjob.command`                    | Command to run                                                                                 | `[]`                        |
| `cronjob.args`                       | Command arguments                                                                              | `[]`                        |
| `cronjob.annotations`                | Defines the hooks to use and their delete                                                      | `{}`                        |
| `workers`                            | Defines one or multiple workers to run long-term tasks                                         | `{}`                        |
| `worker.enabled`                     | Enables a  worker                                                                              | `false`                     |
| `worker.replicaCount`                | worker deployment replicaCount parameter                                                       | `1`                         |
| `worker.name`                        | worker pod suffixe name (Release.Name+this parameter)                                          | ``                          |
| `worker.command`                     | Command to run                                                                                 | `[]`                        |
| `worker.args`                        | Command arguments                                                                              | `[]`                        |
| `worker.volumeMounts`                | worker volume mounts arguments                                                                 | `[]`                        |
| `worker.volumes`                     | worker volumes arguments                                                                       | `[]`                        |
| `worker.annotations`                 | Defines the hooks to use and their delete                                                      | `{}`                        |
| `strategy`                           | Defines deployment strategy                                                                    | `{type: 'Recreate'}`        |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

## Installation

To install the chart with the release name `my-release` and the namespace `prod` using a `values.yaml` file:

```bash
helm install --name my-release --namespace prod suez/symfony -f ./values.yaml
```

```console
$ helm install --name my-release \
  --set image.repository=pathtodockerhub/name/whatever \
    suez/symfony
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For
example,

```console
$ helm install --name my-release -f values.yaml suez/kube-lego
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release --purge
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
