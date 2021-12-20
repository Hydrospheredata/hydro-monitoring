# drift-report-plugin

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A Helm chart for drift-report-plugin

**Homepage:** <https://hydrosphere.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hydrospheredata | support@hydrosphere.io | https://hydrosphere.io |

## Source Code

* <https://github.com/Hydrospheredata/drift-report-plugin>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | number of replicas |
| global.persistence.url | string | `""` | Endpoint for the object storage. Compatible with S3 or Minio |
| global.persistence.service.ports.api | int | `9000` | Minio api port |
| global.manager.service.ports.http | int | `8080` | Manager http port |
| global.manager.service.ports.grpc | int | `8081` | Manager grpc port |
| global.tolerations | list | `[]` | Tolerations for drift-report-plugin pods |
| image.full | string | `"hydrosphere/drift-report-plugin:3a78805d62f234e3738ccdfcb52618d7fcae8243"` | drift-report-plugin image |
| image.pullPolicy | string | `"IfNotPresent"` | drift-report-plugin image pull policy |
| service.type | string | `"ClusterIP"` | Kubernetes Service type |
| service.port | int | `5000` | drift-report-plugin port |
| podSecurityContext.runAsUser | int | `42069` | User ID for the container |
| securityContext.allowPrivilegeEscalation | bool | `false` | Container child process can gain more privileges than its parent |
| podAnnotations | object | `{}` | Map of annotations to add to the pods |
| resources | object | `{}` | Map of resources to add to the pods |
| nodeSelector | object | `{}` | Node labels for drift-report-plugin pods assignment |
| affinity | object | `{}` | Affinity for drift-report-plugin pods assignment |

