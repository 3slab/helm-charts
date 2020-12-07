# Alfresco Content Services (ACS) Community Helm Chart

Alfresco Content Services is an Enterprise Content Management (ECM) system that is used for document and case management, project collaboration, web content publishing, and compliant records management.  The flexible compute, storage, and database services that Kubernetes offers make it an ideal platform for Alfresco Content Services. This helm chart presents an enterprise-grade Alfresco Content Services configuration that you can adapt to virtually any scenario, and scale up, down, or out, depending on your use case.

To use, add the `incubator` or `stable` repository to your local Helm.
```console
helm repo add alfresco-incubator http://kubernetes-charts.alfresco.com/incubator
helm repo add alfresco-stable http://kubernetes-charts.alfresco.com/stable
```
## Versioning

The versioning of the Helm Chart is based on [SemVer](https://semver.org/) as it is [supported by Helm](https://docs.helm.sh/developing_charts/#charts-and-versioning). There are a few ACS specific extensions to the rules. Please refer to the [Helm versioning guide](https://github.com/Alfresco/acs-deployment/blob/master/docs/helm-versioning.md).

Stable charts are published in [stable repository](http://kubernetes-charts.alfresco.com/stable). Once a stable chart is published, an entry will be added to [releases table](../../docs/helm-chart-releases.md).

## To install the ACS cluster

```console
$ helm install alfresco-incubator/alfresco-content-services-community
```

## Introduction

This chart bootstraps an ACS deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites
  - Kubernetes 1.4+ with Beta APIs enabled
  - Minimum of 12GB Memory to distribute among ACS Cluster nodes

## Structure

![Helm Deployment Components](../../docs/diagrams/helm-chart/helm-components.png)

## Installing the Chart

To install the chart with the release name `my-acs`:

```console
# Alfresco Admin password should be encoded in MD5 Hash
export ALF_ADMIN_PWD=$(printf %s 'MyAdminPwd' | iconv -t UTF-16LE | openssl md4 | awk '{ print $1}')

# Alfresco Database (Postgresql) password
export ALF_DB_PWD='MyDbPwd'

$ helm install --name my-acs alfresco-incubator/alfresco-content-services-community  \
               --set repository.adminPassword="$ALF_ADMIN_PWD" \
               --set postgresql.postgresPassword="$ALF_DB_PWD"
```

The command deploys ACS Cluster on the Kubernetes cluster in the default configuration (but with your chosen Alfresco administrator & database passwords). The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall/delete the `my-acs` deployment:

```console
$ helm delete my-acs --purge
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the ACS chart and their default values.

Parameter | Description | Default
--- | --- | ---
`repository.adminPassword` | Administrator password for ACS in md5 hash format | md5: `209c6174da490caeb422f3fa5a7ae634` (of string `admin`)
`postgresql.enabled` | Enable the use of the postgres chart in the deployment | `true`
`postgresql.postgresUser` | Postgresql database user | `alfresco`
`postgresql.postgresPassword` | Postgresql database password | `alfresco`
`postgresql.postgresDatabase` | Postgresql database name | `alfresco`
`database.external` | Enable the use of an externally provisioned database | `false`
`database.driver` | External database driver | ``
`database.user` | External database user | ``
`database.password` | External database password | ``
`database.url` | External database jdbc url | ``
`alfresco-search.resources.requests.memory` | Alfresco Search Services requests memory | `250Mi`
`alfresco-search.ingress.enabled` | Enable external access for Alfresco Search Services | `false`
`alfresco-search.ingress.basicAuth` | If `alfresco-search.ingress.enabled` is `true`, user need to provide a `base64` encoded `htpasswd` format user name & password (ex: `echo -n "$(htpasswd -nbm solradmin somepassword)"` where `solradmin` is username and `somepassword` is the password) | None
`alfresco-search.ingress.whitelist_ips` | If `alfresco-search.ingress.enabled` is `true`, user can restrict `/solr` to a list of IP addresses of CIDR notation | `0.0.0.0/0`

# Activate Apache Mellon

You can activate Apache Mellon to authenticate users from SAMLv2 server.

At first, you need to create key pairs for Apache Mellon - it will be used to encrypt messages from Apache to SAML provider:

```bash
# set the URL of the root endpoint, without protocol (only domain)
export _HOST="ROOT-URL-TO-APACHE"

# generate the openssl template
/bin/cat  <<EOF > /tmp/mellon-template
RANDFILE           = /dev/urandom
[req]
default_bits       = 3072
default_keyfile    = privkey.pem
distinguished_name = req_distinguished_name
prompt             = no
policy             = policy_anything
[req_distinguished_name]
commonName         = $_HOST
EOF

# generate key pair
openssl req \
    -utf8 -batch \
    -config "/tmp/mellon-template" \
    -new -x509 -days 3652 \
    -nodes \
    -out "mellon.crt" \
    -keyout "mellon.key" 2>/dev/null

# cleanup
rm -f /tmp/mellon-template
unset _HOST
```

Both files `mellon.key` and `mellon.crt` will be injected in `values.yaml`.

Then get the SDP metadata file in XML format.

In `values.yaml` (or any other anwser file you use with `-f` option from helm command line), add or modify the `mellon` section:

```yaml
mellon:
  # set to true to activate SAMLv2 authentication
  enable: true
  # image to use for apache + mod_auth_mellon
  image: 3spartnerdockerregistry.azurecr.io/apache-mellon:latest
  # snippets to add to Apache httpd
  server_snippets: |
    <LocationMatch "^(/.*/service/api/solr/.*)$" >
        deny from all
    </LocationMatch>
    <LocationMatch "^(/.*/s/api/solr/.*)$" >
        deny from all
    </LocationMatch>
    <LocationMatch "^(/.*/wcservice/api/solr/.*)$" >
        deny from all
    </LocationMatch>
    <LocationMatch "^(/.*/wcs/api/solr/.*)$">
        deny from all
    </LocationMatch>
  # allowed_routes are routes to leave public
  allowed_routes: []
  # protected_routes are restricted to authenticated users
  # from SAML server
  protected_routes:
  - path: /alfresco
    suffix: -repository
  - path: /api-explorer
    suffix: -repository
  - path: /share
    suffix: -share
  # Attributes from SAML to bind to headers
  saml_attributes:
  - name: email
    set_header: X-Alfresco-Remote-Email
  - name: uid
    set_header: X-Alfresco-Remote-User
  # The SP name to register in SAML SDP
  entity_id: alfresco
  cert: |
    # paste here the SP certificate
  key: |
    # paste here the SP key
  idp_metadata: |
    # paste here the XML content of SDP Metadata
```

In this case:

- only the ingress `ingress-mellon-protected`will be activated - everything will be sent to Apache
- the saml attributes will be configured to send correct headers with SAML user information
- if you change mellon configuration, you **need to restart apache-mellon pod**, you can do this by removing the apache pod, it will be recreated
