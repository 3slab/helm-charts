# Helm Charts

Suez Smart Solutions and its 3S.lab use a set of tools that should be installed in Kubernetes cluster. For this purpose, we decided to use helm to install these tools.

[Helm](https://github.com/helm/helm) is a tool for managing Kubernetes charts. Charts are packages of pre-configured Kubernetes resources.

This repository contains stable charts, and a repo for helm.

## Configure helm to use this Repo

### Stable repository

Charts are packaged and stored under `repo/` directory. To use this github repository as helm repository you need to run these commands:

```bash
$ helm repo add 3slab 'https://raw.githubusercontent.com/3slab/helm-charts/master/repo'
$ helm repo update
```

### Incubator repository

Non stable charts are stored in incubator repository under `/repo-incubator` directory. To use this github repository as helm repository you need to:

- Add Suez repo to you helm repositories
```bash
$ helm repo add 3slab-incubator 'https://raw.githubusercontent.com/3slab/helm-charts/master/repo-incubator'
$ helm repo update
```

## Repository Structure

The purpose of this repository is to provide a place for maintaining and contributing official Charts, with CI processes in place for managing the releasing of Charts into the Chart Repository.

The Charts in this repository are organized into two folders:

- stable: Source of charts
- incubator: Work in progress, not yet charted.
- repo: To serve stable charts
- repo-incubator: To serve unstable charts

## Contribution

Contribution [guide](CONTRIBUTING.md) should be respected.

When you add charts to `stable/` directory, you need to add/update you charts within `repo` directory.

### Package your chart

```bash
helm package -d repo/ $YOUR_CHART_PATH/
```

*Add the option `-u` when the package has dependencies*
*Change `repo/` with `repo-incubator` for unstable packages.*

### Index your chart

```bash
helm repo index repo/
```
