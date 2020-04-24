Superset chart
==============

This chart install a simple Apache Superset deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

**IMPORTANT : it does not support the worker mode of Superset so only one instance is deployed**

## Prerequisites
  - Kubernetes 1.4+ with Beta APIs enabled

## Configuration

The following table lists the configurable parameters of the chart and their default values.

Parameter                  | Description                                                              | Default
-------------------------- | ------------------------------------------------------------------------ | -------
`strategy`                 | Specifies the strategy used to replace old Pods by new ones              | `Recreate`
`image.repository`         | container image repository                                               | `3slab/superset`
`image.tag`                | container image tag                                                      | `0.36.0rc1`
`image.pullPolicy`         | container image pull policy                                              | `IfNotPresent`
`image.pullSecrets`        | container image pull secrets                                             |
`nameOverride`             | Override the app name                                                    | `nil`
`fullnameOverride`         | Override the fullname of the chart                                       | `nil`
`service.type`             | type of the service                                                      | `ClusterIp`
`service.port`             | port of the service                                                      | `80`
`resources`                | resource requests and limits (YAML)                                      | `{}`
`nodeSelector`             | node labels for pod assignment                                           |
`ingress.enabled`          | Either or not the ingress is enabled                                     | `false`
`ingress.path`             | Base path of the ingress                                                 | `/`
`ingress.hosts`            | Hosts to reach the application                                           | `[]`
`ingress.annotations`      | Ingress annotation configuration                                         | `{}`
`ingress.tls`              | TLS support                                                              | `[]`
`env`                      | Custom environment variables                                             | `[]`
`affinity`                 | Affinity settings for pod assignment                                     | `{}`
`tolerations`              | Toleration labels for pod assignment                                     | `[]`
`volumeMounts`             | Volume mounts to configure configmap                                     | `[]`
`volumes`                  | Volumes                                                                  | `[]`
`admin.username`           | Username of the admin account                                            | `admin`
`admin.firstname`          | Firstname of the admin account                                           | `admin`
`admin.lastname`           | Lastname of the admin account                                            | `user`
`admin.email`              | Email of the admin account                                               | `admin@superset.local`
`admin.password`           | Password of the admin account                                            | `admin`

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

## Installation

To install the chart with the release name `my-release` and the namespace `prod` using a `values.yaml` file:

```bash
helm install --name my-release --namespace prod suez/superset -f ./values.yaml
```

```console
$ helm install --name my-release \
  --set image.repository=pathtodockerhub/name/whatever \
    suez/superset
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example :

```console
$ helm install --name my-release -f values.yaml suez/superset
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release --purge
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
