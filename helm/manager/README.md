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
| image.full | string | `"hydrosphere/monitoring-manager:b0afcdf93ca17dfd6757a4bcf02c80982f6d30ad"` | manager image |
| image.pullPolicy | string | `"IfNotPresent"` | manager image pull policy |
| containerPorts.http | int | `8080` | manager container http port |
| containerPorts.grpc | int | `8081` | manager container grpc port |
| containerPorts.jmx | int | `5555` | manager container jmx port |
| resources.limits.cpu | string | `"2000m"` | The cpu limit for the container |
| resources.limits.memory | string | `"2Gi"` | The memory limit for the container |
| resources.requests.cpu | string | `"1000m"` | The requested cpu for the container |
| resources.requests.memory | string | `"2Gi"` | The requested memory for the container |
| monitoring.enabled | bool | `false` | JMX metrics monitoring |
| exportMetrics.enabled | bool | `false` | export metrics |
| exportMetrics.prometheusEndpoint | string | `"monitoring-kube-prometheus-prometheus:9090"` | Prometheus endpoint within the cluster |
| exportMetrics.ports.pprof | int | `1888` | pprof extension port |
| exportMetrics.ports.metrics | int | `8888` | Prometheus metrics exposed by the collector port |
| exportMetrics.ports.exporterMetrics | int | `8889` | Prometheus exporter metrics port |
| exportMetrics.ports.healthCheck | int | `13133` | health_check extension port |
| exportMetrics.ports.grpc | int | `4317` | OTLP gRPC receiver |
| exportMetrics.ports.zpages | int | `55679` | zpages extension port |
| podAnnotations | object | `{"prometheus.io/port":"5556","prometheus.io/scrape":"true"}` | Map of annotations to add to the pods |
| podAnnotations."prometheus.io/scrape" | string | `"true"` | Scrape by prometheus |
| podAnnotations."prometheus.io/port" | string | `"5556"` | Port of jmx exporter |
| nodeSelector | object | `{}` | Node labels for manager pods assignment |
| affinity | object | `{}` | Affinity for manager pods assignment |

