MongoBI chart
=============

This chart bootstraps a mongo bi connector on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.


## Prerequisites
  - Kubernetes 1.4+ with Beta APIs enabled


## Configuration

The following table lists the configurable parameters of the chart and their default values.

Parameter                  | Description                                                              | Default
-------------------------- | ------------------------------------------------------------------------ | -------
`image.repository`         | container image repository                                               | `nginx`
`image.tag`                | container image tag                                                      | `stable`
`image.pullPolicy`         | container image pull policy                                              | `IfNotPresent`
`image.pullSecrets`        | container image pull secrets                                             |
`service.enabled`          | enable the creation of the service resource                              | `true`
`service.name`             | name of the service                                                      | `nginx`
`service.type`             | type of the service                                                      | `ClusterIp`
`service.externalPort`     | external port of the service                                             | `80`
`service.internalPort`     | internal port of the service                                             | `80`
`service.annotations`      | Service annotation configuration                                         | `{}`
`livenessProbe`            | liveness probe (YAML)                                                    | `{}`
`readinessProbe`           | readiness probe (YAML)                                                   | `{}`
`resources`                | resource requests and limits (YAML)                                      | `{}`
`nodeSelector`             | node labels for pod assignment                                           |
`env.container`            | Environment variables that are passed to the container and the webserver |
`env.initContainer`        | Environment variables that are passed to each initContainer              |
`extraEnv`                 | Add specific environment variable to the container                       | `[]`
`initContainers`           | Allow to configure initContainers for the deployment (YAML)              |
`job.enabled`              | Enables a pre-update job                                                 | `false`
`job.activeDeadlineSeconds`| Pod activeDeadlineSeconds parameter                                      | `60`
`job.restartPolicy`        | Pod restartPolicy parameter                                              | `Never`
`job.name`                 | Pod suffixe name (Release.Name+this parameter)                           | `job`
`job.cmd`                  | Command to run                                                           | `[]`
`job.args`                 | Command arguments                                                        | `[]`
`job.annotations`          | Defines the hooks to use and their delete                                | `{}`
`strategy`                 | Defines deployment strategy                                              | `{type: 'Recreate'}`

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,


## Installation

To install the chart with the release name `my-release` and the namespace `prod` using a `values.yaml` file:

```bash
helm install --name my-release --namespace prod 3slab/mongobi -f ./values.yaml
```

```console
$ helm install --name my-release \
  --set image.repository=pathtodockerhub/name/whatever \
    3slab/mongobi
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```console
$ helm install --name my-release -f values.yaml 3slab/mongobi
```

> **Tip**: You can use the default [values.yaml](values.yaml)


## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release --purge
```

The command removes all the Kubernetes components associated with the chart and deletes the release.
