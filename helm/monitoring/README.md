# monitoring

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.0.1](https://img.shields.io/badge/AppVersion-0.0.1-informational?style=flat-square)

Hydro-monitoring is a cluster for monitoring your machine learning models in production

**Homepage:** <https://hydrosphere.io/>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| hydrospheredata | info@hydrosphere.io | https://hydrosphere.io |

## Source Code

* <https://github.com/Hydrospheredata/hydro-monitoring>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../drift-report-plugin | drift-report-plugin | ~0.1.0 |
| file://../manager | manager | ~0.1.0 |
| file://../minio | minio | ~9.2.1 |
| file://../postgresql | postgresql | ~10.13.9 |
| file://../profiler | profiler | ~0.1.0 |
| file://../shell-ui | shell-ui | ~0.1.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.ui.ingress.enabled | bool | `false` | Enable frontend ingress |
| global.ui.ingress.host | string | `"hydromonitoring.local"` | Domain name for the frontend ingress |
| global.ui.ingress.path | string | `"/"` | Path, which will match the service |
| global.ui.ingress.issuer | string | `"letsencrypt-prod"` | A name of the cert-manager issuer name, configured within the cluster |
| global.postgresql.url | string | `""` | Specify Postgresql connection string if you want to use an external Postgresql instance. If empty, an in-cluster deployment will be provisioned |
| global.postgresql.postgresqlUsername | string | `"root"` | Postgresql username. Used for an internal installation |
| global.postgresql.postgresqlPassword | string | `"root"` | Postgresql password. Used for an internal installation |
| global.postgresql.postgresqlDatabase | string | `"monitoring"` | Postgresql database name. Used for an internal installation |
| global.postgresql.servicePort | int | `5432` | Postgresql service port |
| global.persistence.url | string | `""` | Endpoint for the object storage. Compatible with S3 or Minio |
| global.persistence.mode | string | `"minio"` | Use pvc("minio") or s3("s3") |
| global.persistence.ingress.enabled | bool | `false` | Enable minio console ingress |
| global.persistence.ingress.host | string | `"hydrosphere-minio.local"` | Domain name for the minio console ingress |
| global.persistence.apiIngress.enabled | bool | `false` | Enable minio api ingress |
| global.persistence.apiIngress.host | string | `"hydrosphere-minio-api.local"` | Domain name for the minio api ingress |
| global.persistence.accessKey | string | `"ACCESSKEYEXAMPLE"` | ACCESS_KEY_ID for s3 or minio |
| global.persistence.secretKey | string | `"SECRETKEYEXAMPLE"` | SECRET_KEY_ID for s3 or minio |
| global.persistence.service.ports.api | int | `9000` | Minio api port |
| global.persistence.service.ports.console | int | `9001` | Minio console port |
| global.manager.service.ports.http | int | `8080` | manager service http port |
| global.manager.service.ports.grpc | int | `8081` | manager service grpc port |
| global.tolerations | list | `[]` | Tolerations for pods in hydro-monitoring |

