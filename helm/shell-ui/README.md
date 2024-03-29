# shell-ui

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

A helm chart for the hydro-monitoring user interface

**Homepage:** <https://hydrosphere.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hydrospheredata | support@hydrosphere.io | https://hydrosphere.io |

## Source Code

* <https://github.com/Hydrospheredata/hydroserving-shell-ui>

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| replicaCount | int | `1` | number of replicas |
| global.ui.ingress.enabled | bool | `false` | Enable frontend ingress |
| global.ui.ingress.host | string | `"hydromonitoring.local"` | Domain name for the frontend ingress |
| global.ui.ingress.path | string | `"/"` | Path, which will match the service |
| global.ui.ingress.issuer | string | `"letsencrypt-prod"` | A name of the cert-manager issuer name, configured within the cluster |
| global.manager.service.ports.http | int | `8080` | Manager http port |
| global.tolerations | list | `[]` | Tolerations for shell-ui pods |
| image.full | string | `"hydrosphere/shell-ui:c41e575569bb61995cfdcd64dcca647434800712"` | shell-ui image |
| image.pullPolicy | string | `"IfNotPresent"` | shell-ui image pull policy |
| service.type | string | `"ClusterIP"` | Kubernetes Service type |
| service.port | int | `8080` | shell-ui port |
| podSecurityContext.runAsUser | int | `42069` | User ID for the container |
| securityContext.allowPrivilegeEscalation | bool | `false` | Container child process can gain more privileges than its parent |
| podAnnotations | object | `{}` | Map of annotations to add to the pods |
| resources | object | `{}` | Map of resources to add to the pods |
| nodeSelector | object | `{}` | Node labels for shell-ui pods assignment |
| affinity | object | `{}` | Affinity for shell-ui pods assignment |

