# Contributing Guidelines

This project accepts GitHub pull requests. This document outlines the process to help get your contribution accepted.


This repository is used by Chart developers form Suez Smart Solutions for maintaining the official charts for Kubernetes Helm. 

### How to Contribute a Chart

1. Fork this repository, develop and test your Chart.
1. Choose the correct folder for your chart based on the information in the [Repository Structure](README.md#repository-structure) section
1. Ensure your Chart follows the [technical](#technical-requirements) and [documentation](#documentation-requirements) guidelines, described below.
1. Submit a pull request.


#### Technical requirements

* All Chart dependencies should also be submitted independently
* Must pass the linter (`helm lint`)
* Must successfully launch with default values (`helm install .`)
    * All pods go to the running state (or NOTES.txt provides further instructions if a required value is missing e.g. [minecraft](https://github.com/kubernetes/charts/blob/master/stable/minecraft/templates/NOTES.txt#L3))
    * All services have at least one endpoint
* Must include source GitHub repositories for images used in the Chart
* Images should not have any major security vulnerabilities
* Must be up-to-date with the latest stable Helm/Kubernetes features
    * Use Deployments in favor of ReplicationControllers
* Should follow Kubernetes best practices
    * Include Health Checks wherever practical
    * Allow configurable [resource requests and limits](http://kubernetes.io/docs/user-guide/compute-resources/#resource-requests-and-limits-of-pod-and-container)
* Provide a method for data persistence (if applicable)
* Support application upgrades
* Allow customization of the application configuration
* Provide a secure default configuration
* Do not leverage alpha features of Kubernetes
* Includes a [NOTES.txt](https://github.com/kubernetes/helm/blob/master/docs/charts.md#chart-license-readme-and-notes) explaining how to use the application after install
* Follows [best practices](https://github.com/kubernetes/helm/tree/master/docs/chart_best_practices)
  (especially for [labels](https://github.com/kubernetes/helm/blob/master/docs/chart_best_practices/labels.md)
  and [values](https://github.com/kubernetes/helm/blob/master/docs/chart_best_practices/values.md))

#### Documentation requirements

* Must include an in-depth `README.md`, including:
    * Short description of the Chart
    * Any prerequisites or requirements
    * Customization: explaining options in `values.yaml` and their defaults
* Must include a short `NOTES.txt`, including:
    * Any relevant post-installation information for the Chart
    * Instructions on how to access the application or service provided by the Chart

<!-- #### Merge approval and release process

A Kubernetes Charts maintainer will review the Chart submission, and start a validation job in the CI to verify the technical requirements of the Chart. A maintainer may add "LGTM" (Looks Good To Me) or an equivalent comment to indicate that a PR is acceptable. Any change requires at least one LGTM. No pull requests can be merged until at least one maintainer signs off with an LGTM.

Once the Chart has been merged, the release job will automatically run in the CI to package and release the Chart in the [`gs://kubernetes-charts` Google Storage bucket](https://console.cloud.google.com/storage/browser/kubernetes-charts/). -->
