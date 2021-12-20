# manager

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A helm chart for the service which manages plugins for the entire system

**Homepage:** <https://hydrosphere.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hydrospheredata | support@hydrosphere.io | https://hydrosphere.io |

## Source Code

* <https://github.com/Hydrospheredata/monitoring-manager>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | number of replicas |
| global.postgresql.url | string | `""` | Specify Postgresql connection string if you want to use an external Postgresql instance. If empty, an in-cluster deployment will be provisioned |
| global.postgresql.postgresqlDatabase | string | `"monitoring"` | Postgresql database name. Used for an internal installation |
| global.postgresql.postgresqlUsername | string | `"postgres"` | Postgresql username. Used for an internal installation |
| global.postgresql.postgresqlPassword | string | `"hydr0m0nit0ring"` | Postgresql password. Used for an internal installation |
| global.postgresql.servicePort | int | `5432` | Postgresql service port |
| global.manager.service.type | string | `"ClusterIP"` | Kubernetes Service type |
| global.manager.service.ports.http | int | `8080` | manager service http port |
| global.manager.service.ports.grpc | int | `8081` | manager service grpc port |
| global.persistence.url | string | `""` |  |
| global.persistence.service.ports.api | int | `9000` | Minio api port |
| global.tolerations | list | `[]` | Tolerations for manager pods |
| image.full | string | `"hydrosphere/monitoring-manager:6bf7b627406890d0527a569f8f6c62c1a8402e71"` | manager image |
| image.pullPolicy | string | `"IfNotPresent"` | manager image pull policy |
| containerPorts.http | int | `443` | manager container http port |
| containerPorts.grpc | int | `8081` | manager container grpc port |
| resources.limits.cpu | string | `"2000m"` | The cpu limit for the container |
| resources.limits.memory | string | `"2Gi"` | The memory limit for the container |
| resources.requests.cpu | string | `"1000m"` | The requested cpu for the container |
| resources.requests.memory | string | `"2Gi"` | The requested memory for the container |
| podAnnotations | object | `{}` | Map of annotations to add to the pods |
| nodeSelector | object | `{}` | Node labels for manager pods assignment |
| affinity | object | `{}` | Affinity for manager pods assignment |
