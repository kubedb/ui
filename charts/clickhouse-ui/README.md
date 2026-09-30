# clickhouse-ui

[clickhouse-ui](https://github.com/caioricciuti/ch-ui) - An administration tool for ClickHouse

## TL;DR;

```bash
$ helm repo add appscode https://charts.appscode.com/stable/
$ helm repo update
$ helm search repo appscode/clickhouse-ui --version=v2026.3.30
$ helm upgrade -i clickhouse-ui appscode/clickhouse-ui -n demo --create-namespace --version=v2026.3.30
```

## Introduction

This chart deploys a clickhouse-ui deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.20+

## Installing the Chart

To install/upgrade the chart with the release name `clickhouse-ui`:

```bash
$ helm upgrade -i clickhouse-ui appscode/clickhouse-ui -n demo --create-namespace --version=v2026.3.30
```

The command deploys a clickhouse-ui deployment on the Kubernetes cluster in the default configuration. The [configuration](#configuration) section lists the parameters that can be configured during installation.

> **Tip**: List all releases using `helm list`

## Uninstalling the Chart

To uninstall the `clickhouse-ui`:

```bash
$ helm uninstall clickhouse-ui -n demo
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Configuration

The following table lists the configurable parameters of the `clickhouse-ui` chart and their default values.

|           Parameter            |                                                      Description                                                       |                                                                                            Default                                                                                             |
|--------------------------------|------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| proxies.appscode               | r.appscode.com                                                                                                         | <code>r.appscode.com</code>                                                                                                                                                                    |
| proxies.dockerHub              | company/bin:tag                                                                                                        | <code>""</code>                                                                                                                                                                                |
| proxies.dockerLibrary          | alpine, nginx etc.                                                                                                     | <code>""</code>                                                                                                                                                                                |
| proxies.ghcr                   | ghcr.io/company/bin:tag                                                                                                | <code>ghcr.io</code>                                                                                                                                                                           |
| proxies.microsoft              |                                                                                                                        | <code>mcr.microsoft.com</code>                                                                                                                                                                 |
| proxies.oracle                 |                                                                                                                        | <code>container-registry.oracle.com</code>                                                                                                                                                     |
| proxies.quay                   | quay.io/company/bin:tag                                                                                                | <code>quay.io</code>                                                                                                                                                                           |
| proxies.kubernetes             | registry.k8s.io/bin:tag                                                                                                | <code>registry.k8s.io</code>                                                                                                                                                                   |
| proxies.weaviate               |                                                                                                                        | <code>cr.weaviate.io</code>                                                                                                                                                                    |
| replicaCount                   | CH-UI keeps state in a local SQLite database; it is a single-instance application.                                     | <code>1</code>                                                                                                                                                                                 |
| image.repository               |                                                                                                                        | <code>"caioricciuti/ch-ui"</code>                                                                                                                                                              |
| image.pullPolicy               |                                                                                                                        | <code>IfNotPresent</code>                                                                                                                                                                      |
| image.tag                      | Overrides the image tag whose default is the chart appVersion.                                                         | <code>"v2.14.1"</code>                                                                                                                                                                         |
| imagePullSecrets               |                                                                                                                        | <code>[]</code>                                                                                                                                                                                |
| nameOverride                   |                                                                                                                        | <code>""</code>                                                                                                                                                                                |
| fullnameOverride               |                                                                                                                        | <code>""</code>                                                                                                                                                                                |
| serviceAccount.create          | Specifies whether a service account should be created                                                                  | <code>true</code>                                                                                                                                                                              |
| serviceAccount.annotations     | Annotations to add to the service account                                                                              | <code>{}</code>                                                                                                                                                                                |
| serviceAccount.name            | The name of the service account to use. If not set and create is true, a name is generated using the fullname template | <code>""</code>                                                                                                                                                                                |
| podAnnotations                 |                                                                                                                        | <code>{}</code>                                                                                                                                                                                |
| podSecurityContext             |                                                                                                                        | <code>{"fsGroup":65534}</code>                                                                                                                                                                 |
| securityContext                |                                                                                                                        | <code>{"allowPrivilegeEscalation":false,"capabilities":{"drop":["ALL"]},"readOnlyRootFilesystem":true,"runAsNonRoot":true,"runAsUser":65534,"seccompProfile":{"type":"RuntimeDefault"}}</code> |
| service.type                   |                                                                                                                        | <code>ClusterIP</code>                                                                                                                                                                         |
| service.port                   |                                                                                                                        | <code>80</code>                                                                                                                                                                                |
| resources                      |                                                                                                                        | <code>{}</code>                                                                                                                                                                                |
| nodeSelector                   |                                                                                                                        | <code>{}</code>                                                                                                                                                                                |
| tolerations                    |                                                                                                                        | <code>[]</code>                                                                                                                                                                                |
| affinity                       |                                                                                                                        | <code>{}</code>                                                                                                                                                                                |
| persistence.enabled            |                                                                                                                        | <code>true</code>                                                                                                                                                                              |
| persistence.size               |                                                                                                                        | <code>1Gi</code>                                                                                                                                                                               |
| namespace.create               |                                                                                                                        | <code>false</code>                                                                                                                                                                             |
| gateway.className              |                                                                                                                        | <code>"ace"</code>                                                                                                                                                                             |
| gateway.port                   |                                                                                                                        | <code>8082</code>                                                                                                                                                                              |
| gateway.tlsSecretRef.name      |                                                                                                                        | <code>service-presets-cert</code>                                                                                                                                                              |
| gateway.tlsSecretRef.namespace |                                                                                                                        | <code>ace</code>                                                                                                                                                                               |
| gateway.referenceGrant.create  |                                                                                                                        | <code>true</code>                                                                                                                                                                              |
| keda.proxyService.namespace    |                                                                                                                        | <code>"keda"</code>                                                                                                                                                                            |
| keda.proxyService.name         |                                                                                                                        | <code>"keda-add-ons-http-interceptor-proxy"</code>                                                                                                                                             |
| keda.proxyService.port         |                                                                                                                        | <code>8080</code>                                                                                                                                                                              |
| targetPendingRequests          |                                                                                                                        | <code>200</code>                                                                                                                                                                               |
| autoscaling.http.minReplicas   |                                                                                                                        | <code>0</code>                                                                                                                                                                                 |
| autoscaling.http.maxReplicas   |                                                                                                                        | <code>1</code>                                                                                                                                                                                 |
| app.service.name               |                                                                                                                        | <code>""</code>                                                                                                                                                                                |
| app.service.namespace          |                                                                                                                        | <code>""</code>                                                                                                                                                                                |
| app.authSecret.name            |                                                                                                                        | <code>""</code>                                                                                                                                                                                |
| app.tls.enabled                |                                                                                                                        | <code>false</code>                                                                                                                                                                             |
| bind.name                      |                                                                                                                        | <code>""</code>                                                                                                                                                                                |
| bind.namespace                 |                                                                                                                        | <code>""</code>                                                                                                                                                                                |


Specify each parameter using the `--set key=value[,key=value]` argument to `helm upgrade -i`. For example:

```bash
$ helm upgrade -i clickhouse-ui appscode/clickhouse-ui -n demo --create-namespace --version=v2026.3.30 --set image.tag=latest
```

Alternatively, a YAML file that specifies the values for the parameters can be provided while
installing the chart. For example:

```bash
$ helm upgrade -i clickhouse-ui appscode/clickhouse-ui -n demo --create-namespace --version=v2026.3.30 --values values.yaml
```
