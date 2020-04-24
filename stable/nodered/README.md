# Node-Red

[Node-Red](https://nodered.org/) is a programming tool for wiring together hardware devices, APIs and online services in new and interesting ways.

It provides a browser-based editor that makes it easy to wire together flows using the wide range of nodes in the palette that can be deployed to its runtime in a single-click.

## TL;DR;

```console
$ helm install suez/nodered
```

## Introduction

This chart bootstraps a nodered deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Installing the Chart

To install the chart with the release name `my-release`:

```console
$ helm install suez/nodered --name my-release
```

The command deploys nodered on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```console
$ helm delete my-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the nodered chart and their default values.

Parameter | Description | Default
--- | --- | ---
`appName` | name of the flow (used mainly to label monitoring metrics) | `example`
`env` | key values array of additional environment variables passed to container | `{}`
`flowType` | type of the flow (used mainly to label monitoring metrics) | `flowExample`
`image.pullPolicy` | Image pull policy | `IfNotPresent`
`image.repository` | Image repository | `quay.io/smile/nodered`
`image.tag` | Image tag | `0.18.4`
`ingress.enabled` | Enables Ingress | `false`
`ingress.annotations` | Ingress annotations | None:
`ingress.hosts` | Ingress accepted hostnames | None:
`ingress.tls` | Ingress TLS configuration | None:
`livenessProbe.periodSeconds` | Customize liveness probe periodSeconds | `10`
`livenessProbe.timeoutSeconds` | Customize liveness probe timeoutSeconds | `1`
`livenessProbe.initialDelaySeconds` | Customize liveness probe initialDelaySeconds | `0`
`nodeSelector` | node labels for pod assignment | `{}`
`podAnnotations` | annotations to add to each pod | `{}`
`readinessProbe.periodSeconds` | Customize readiness probe periodSeconds | `10`
`readinessProbe.timeoutSeconds` | Customize readiness probe timeoutSeconds | `1`
`readinessProbe.initialDelaySeconds` | Customize readiness probe initialDelaySeconds | `0`
`replicaCount` | desired number of pods | `1`
`resources` | pod resource requests & limits | `{}`
`service.externalPort` | external port for the service | `1880`
`service.internalPort` | internal port for the service | `1880`
`service.externalIPs` | external IP addresses | None:
`service.type` | type of service | `ClusterIP`
`persistentVolume.enabled` | If true, will create a Persistent Volume Claim | `false`
`persistentVolume.accessModes` | data Persistent Volume access modes | `[ReadWriteOnce]`
`persistentVolume.annotations` | Annotations for Persistent Volume Claim` | `{}`
`persistentVolume.existingClaim` | data Persistent Volume existing claim name | `""`
`persistentVolume.mountPath` | data Persistent Volume mount root path | `/data`
`persistentVolume.size` | data Persistent Volume size | `2Gi`
`persistentVolume.storageClass` | data Persistent Volume Storage Class | `default`
`nodered.tmpFilesPath` | Path where nodered data are stored (from read only config map) | `/tmp/node-red`
`nodered.flows` | Add flows.json file content | `~`
`nodered.flowsCred` | Add flows_cred.json file content | `~`

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
$ helm install suez/nodered --name my-release \
  --set=image.tag=v0.0.2,resources.limits.cpu=200m
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
$ helm install suez/nodered --name my-release -f values.yaml
```

> **Tip**: You can use the default [values.yaml](values.yaml)
