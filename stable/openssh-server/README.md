# OpenSSH Server

Deploy a full functionnal OpenSSH Server.

[See documentation](https://github.com/atmoz/openssh-server).

## TL;DR;

```bash
$ helm install suez/openssh-server --version=1.0.0 --dry-run --debug
```

## Introduction

This chart openssh-server deploys a [openssh-server](https://hub.docker.com/r/linuxserver/openssh-server) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.4+ with Beta APIs enabled
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name=my-release suez/openssh-server --version=1.0.0 --dry-run --debug
```

The command deploys openssh-server on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-release` deployment:

```bash
$ helm delete my-release --purge --dry-run --debug
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following tables lists the configurable parameters of the openssh-server chart and their default values.

| Parameter                          | Description                                                   | Default                        |
| ---------------------------------- | ------------------------------------------------------------- | ------------------------------ |
| `replicaCount`                     | Number of pods you want                                       | `1`                            |
| `strategy`                         | Specifies the strategy used to replace old Pods by new ones   | `Recreate`                     |
| `image.repository`                 | `linuxserver/openssh-server` image repository                 | `linuxserver/openssh-server`   |
| `image.tag`                        | `openssh-server` image tag                                    | `latest`                       |
| `image.pullPolicy`                 | Image pull policy                                             | `IfNotPresent`                 |
| `nameOverride`                     | Override the app name                                         | `nil`                          |
| `fullnameOverride`                 | Override the fullname of the chart                            | `nil`                          |
| `imagePullSecrets`                 | The secret to use for pulling the images for all deployments  | `[]`                           |
| `service.type`                     | Service type                                                  | `ClusterIP`                    |
| `service.port`                     | Service port                                                  | `22`                           |
| `service.loadBalancerIp`           | Service loadBalancerIp if your provider supports it           | `nil`                          |
| `volumeMounts`                     | Volume mounts to configure configmap                          | `[]`                           |
| `volumes`                          | Volumes                                                       | `[]`                           |
| `resources`                        | CPU/Memory resource requests/limits                           | `nil`                          |
| `nodeSelector`                     | Node labels for pod assignment                                | `{}`                           |
| `affinity`                         | Affinity settings for pod assignment                          | `{}`                           |
| `tolerations`                      | Toleration labels for pod assignment                          | `[]`                           |
| `ssh.hostname`                     | Override the default hostname env var                         | `nil`                          |
| `ssh.uid`                          | Set the uid of the SSH user                                   | `1000`                         |
| `ssh.gid`                          | Set the gid of the SSH user                                   | `1000`                         |
| `ssh.timezone`                     | Specify a TZ env variable                                     | `Europe/Paris`                 |
| `ssh.userName`                     | Specify the ssh user login                                    | `adminssh`                     |
| `ssh.sudoAccess`                   | Set to true to allow, the ssh user, sudo access. Without userPassword set, this will allow passwordless sudo access. | `false` |
| `ssh.userPassword`                 | Optionally set a sudo password for the ssh user. If this is not set but sudoAccess is set to true, the user will have passwordless sudo access. | `nil` |
| `publicKeys`                       | ssh public keys for authentication                            | `nil`                          |
| `sshHostKeys.ed25519`              | custom ed25519 ssh private key for host key                   | `nil`                          |
| `sshHostKeys.rsa`                  | custom rsa ssh private key for host key                       | `nil`                          |
| `sshHostKeys.ecdsa`                | custom ecdsa ssh private key for host key                     | `nil`                          |
| `sshHostKeys.dsa`                  | custom ecdsa ssh private key for host key                     | `nil`                          |

Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`. For example,

```bash
$ helm install --name my-release \
  --set image.tag=my-tag,nameOverride=openssh-server \
    suez/openssh-server --version=1.0.0 --dry-run --debug
```

The above command creates a openssh-server deployment with the image tag named `my-tag`. Additionally it override name of the chart `openssh-server`.

Alternatively, a YAML file that specifies the values for the parameters can be provided while installing the chart. For example,

```bash
$ helm install --name my-release -f values.yaml suez/openssh-server --version=1.0.0 --dry-run --debug
```

> **Tip**: You can use the default [values.yaml](values.yaml)
