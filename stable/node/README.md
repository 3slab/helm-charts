# Node

[Node](https://www.nodejs.org) Event-driven I/O server-side JavaScript environment based on V8

## TL;DR

```console
helm install suez-incubator/node
```

## Introduction

This chart bootstraps a Node deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

It clones and deploys a Node.js application from a docker image. Optionally you can set un an Ingress resource to access your application and provision an external database using the k8s service catalog and the Open Service Broker for Azure.

## Prerequisites

- CF the "Configure helm to use this Repo -> Incubator repository" in [the root README](../../README.md)
- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure

## Installing the Chart

```console
export HELM_NAME=my-node
helm install --name $HELM_NAME suez-incubator/node
```

The command deploys Node.js on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation. Also includes support for MariaDB chart out of the box.

## Uninstalling the Chart

```console
helm delete $HELM_NAME
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the Node chart and their default values.

|              Parameter                  |            Description                                    |                        Default                            |
|-----------------------------------------|-----------------------------------------------------------|-----------------------------------------------------------|
| `global.imageRegistry`                  | Global Docker image registry                              | `nil`                                                     |
| `image.registry`                        | NodeJS image registry                                     | `docker.io`                                               |
| `image.repository`                      | NodeJS image name                                         | `node`                                            |
| `image.tag`                             | NodeJS image tag                                          | `{VERSION}`                                               |
| `image.pullPolicy`                      | NodeJS image pull policy                                  | `IfNotPresent`                                            |
| `image.pullSecrets`                     | Specify image pull secrets                                | `nil` (does not add image pull secrets to deployed pods)  |
| `replicas`                              | Number of replicas for the application                    | `1`                                                       |
| `applicationPort`                       | Port where the application will be running                | `3000`                                                    |
| `extraEnv`                              | Any extra environment variables to be pass to the pods    | `{}`                                                      |
| `service.type`                          | Kubernetes Service type                                   | `ClusterIP`                                               |
| `service.port`                          | Kubernetes Service port                                   | `80`                                                      |
| `service.annotations`                   | Annotations for the Service                               | {}                                                        |
| `service.nodePort`                      | NodePort if Service type is `LoadBalancer` or `NodePort`  | `nil`                                                     |
| `persistence.enabled`                   | Enable persistence using PVC                              | `false`                                                   |
| `persistence.path`                      | Path to persisted directory                               | `/app/data`                                               |
| `persistence.accessMode`                | PVC Access Mode                                           | `ReadWriteOnce`                                           |
| `persistence.size`                      | PVC Storage Request                                       | `1Gi`                                                     |
| `ingress.enabled`                       | Enable ingress controller resource                        | `false`                                                   |
| `ingress.hosts[0].name`                 | Hostname to your Node installation                        | `node.local`                                              |
| `ingress.hosts[0].path`                 | Path within the url structure                             | `/`                                                       |
| `ingress.hosts[0].tls`                  | Utilize TLS backend in ingress                            | `false`                                                   |
| `ingress.hosts[0].tlsSecret`            | TLS Secret (certificates)                                 | `node.local-tls-secret`                                   |
| `ingress.hosts[0].annotations`          | Annotations for this host's ingress record                | `[]`                                                      |
| `ingress.secrets[0].name`               | TLS Secret Name                                           | `nil`                                                     |
| `ingress.secrets[0].certificate`        | TLS Secret Certificate                                    | `nil`                                                     |
| `ingress.secrets[0].key`                | TLS Secret Key                                            | `nil`                                                     |
| `volumeMounts`             | Volume mounts to configure configmap                                     | `[]`
| `volumes`                  | Volumes                                                                  | `[]`

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```console
helm install $HELM_NAME 3slab/node \
  --set tag=1.1.2
```

Alternatively, a YAML file that specifies the values for the above parameters can be provided while installing the chart. For example,

```console
helm install $HELM_NAME 3slab/node -f values.yaml
```

> **Tip**: You can use the default [values.yaml](values.yaml)

## Persistence

Persistent Volume Claims are used to keep the data across deployments. This is known to work in GCE, AWS, and minikube.
See the [Configuration](#configuration) section to configure the PVC or to disable persistence.
