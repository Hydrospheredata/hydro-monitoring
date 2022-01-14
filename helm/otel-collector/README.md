# otel-collector

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A Helm chart for otel-collector-contrib

## Source Code

* <https://github.com/open-telemetry/opentelemetry-collector-contrib>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | number of replicas |
| global.metrics | bool | `true` | Enable exporting metrics option to opentelemetry-collector |
| global.tolerations | list | `[]` | Tolerations for otel-collector pods |
| image.full | string | `"otel/opentelemetry-collector-contrib:0.42.0"` | otel-collector image |
| image.pullPolicy | string | `"IfNotPresent"` | otel-collector image pull policy |
| prometheusEndpoint | string | `"monitoring-kube-prometheus-prometheus:9090"` | Prometheus endpoint within the cluster |
| podAnnotations | object | `{}` | Map of annotations to add to the pods |
| podSecurityContext | object | `{}` | Security context to be added to otel-collector pods |
| securityContext | object | `{}` | Security context to be added to otel-collector containers |
| service.type | string | `"ClusterIP"` | Kubernetes Service type |
| service.ports.pprof | int | `1888` | pprof extension port |
| service.ports.metrics | int | `8888` | Prometheus metrics exposed by the collector port |
| service.ports.exporterMetrics | int | `8889` | Prometheus exporter metrics port |
| service.ports.healthCheck | int | `13133` | health_check extension port |
| service.ports.grpc | int | `4317` | OTLP gRPC receiver |
| service.ports.zpages | int | `55679` | zpages extension port |
| resources.limits.cpu | string | `"100m"` | The cpu limit for the container |
| resources.limits.memory | string | `"200Mi"` | The memory limit for the container |
| resources.requests.cpu | string | `"100m"` | The requested cpu for the container |
| resources.requests.memory | string | `"200Mi"` | The requested memory for the container |
| nodeSelector | object | `{}` | Node labels for otel-collector pods assignment |
| affinity | object | `{}` | Affinity for otel-collector pods assignment |

