# Elasticsearch Helm Chart

This chart is based on the [smile0x90/es-curator](https://hub.docker.com/r/smile0x90/es-curator/) image.

## Prerequisites Details

* Kubernetes 1.6+

## Chart Details
This chart will do the following:

* Implement curator cleaner for elasticsearch logging.
* run as cron for kubernetes < 1.8

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ helm install --name my-release 3slab/curator-cron
```

## Deleting the Charts

Delete the Helm deployment as normal

```
$ helm delete my-release
```

## Configuration

The following tables lists the configurable parameters of the elasticsearch chart and their default values.

|              Parameter               |                             Description                             |               Default                |
| ------------------------------------ | ------------------------------------------------------------------- | ------------------------------------ |
| `image.repository`                   | Container image name                                                | `smile0x90/es-curator`               |
| `image.tag`                          | Container image tag                                                 | `latest`                             |
| `image.pullPolicy`                   | Container pull policy                                               | `Always`                             |
| `replicaCount:`                      | Deployment replication count                                        | `Always`                             |
| `env`                                | Environment variables to pass                                       | `{}`                             |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm install`.
