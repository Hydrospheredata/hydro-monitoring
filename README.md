# Hydro-monitoring
[![Slack](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white)](https://hydrospheredata.slack.com/join/shared_invite/zt-tt4j24xj-TpnI_D2aJDBHIbA~EmPSlQ#/shared-invite/email)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docs.docker.com/get-docker/)
[![Helm Version](https://img.shields.io/badge/helm-3.0+-green?style=for-the-badge)](https://helm.sh/docs/intro/install/)
[![GitHub license](https://shields.io/badge/license-Apache%202-blue?style=for-the-badge)](https://github.com/Hydrospheredata/hydro-monitoring/blob/master/LICENSE)

Monitoring Platform

## Getting Started

## Installation

The Hydro-Monitoring platform can be installed in the following orchestrators:
- [Docker](#docker)
- [Kubernetes](#kubernetes)

### Docker

Before installing Hydrosphere Monitoring, please install its prerequisites: 

* [Docker 20+, with BuildKit enabled](https://docs.docker.com/get-docker/);
* [Docker Compose 1.29+](https://docs.docker.com/compose/install/#install-compose).

#### Install from releases

1. Download the latest release version from the [releases](https://github.com/Hydrospheredata/hydro-monitoring/releases) page;
    ```sh 
    ### __released_version__
    export HYDRO_MONITORING_RELEASE=0.1.0

    wget -O hydro-monitoring-${HYDRO_MONITORING_RELEASE}.tar.gz https://github.com/Hydrospheredata/hydro-monitoring/archive/${HYDRO_MONITORING_RELEASE}.tar.gz
    ```
2. Unpack the tar ball:
    ```sh 
    tar -xvf hydro-monitoring-${HYDRO_MONITORING_RELEASE}.tar.gz
    ```
3. Set up an environment.
    ```sh
    cd hydro-monitoring-${HYDRO_MONITORING_RELEASE}/docker-compose
    docker-compose up -d
    ```
4. *To see metrics in Grafana-Prometheus stack:
    ```sh
    docker-compose -f docker-compose.yaml -f docker-compose.metrics.yaml up -d
    ```

#### Install from source

1. Clone the repository locally.
    ```sh
    git clone https://github.com/Hydrospheredata/hydro-monitoring
    cd hydro-monitoring/docker-compose
    ```
2. Set up an environment.
    ```sh
    docker-compose up -d
    ```
3. *To see metrics in Grafana-Prometheus stack:
    ```sh
    docker-compose -f docker-compose.yaml -f docker-compose.metrics.yaml up -d
    ```
Hydro-Monitoring will be available at [localhost](http://localhost).

### Kubernetes

Before installing Hydrosphere Monitoring, please install its prerequisites: 

* [Helm 3.0+](https://helm.sh/docs/intro/install/)
* [Kubernetes 1.16+ with v1 API](https://kubernetes.io/docs/setup/) with beta APIs enabled.

#### Install from charts repository

1. Add the Hydrosphere Monitoring charts repository:
    ```sh
    helm repo add hydromonitoring https://hydrospheredata.github.io/hydro-monitoring/helm/
    ```
2. Install the chart from repo to the cluster:
    ```sh
    helm install monitoring hydromonitoring/monitoring --namespace hydromonitoring --create-namespace
    ```

#### Install from source

1. Clone the repository:
    ```sh
    git clone https://github.com/Hydrospheredata/hydro-monitoring
    cd hydro-monitoring/helm
    ```
2. Build dependencies:
    ```sh
    helm dependency build monitoring
    ```
3. Install the chart:
    ```sh
    helm install monitoring monitoring --namespace hydromonitoring --create-namespace
    ```

After the chart has been installed, you have to expose the `shell-ui` component outside of the cluster. For the sake of simplicity, we will just port-forward it locally.

```sh
kubectl port-forward svc/monitoring-shell-ui 8080:8080 -n hydromonitoring
```

Hydro-Monitoring will be available at [localhost:8080](http://localhost:8080/).


## Community
Keep up to date and get Hydrosphere.io support via [![Slack](https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white)](https://hydrospheredata.slack.com/join/shared_invite/zt-tt4j24xj-TpnI_D2aJDBHIbA~EmPSlQ#/shared-invite/email) or contact us directly at [info@hydrosphere.io](mailto:info@hydrosphere.io)

### Contributing

We'd be glad to receive any help from the community!

Check out our issues for anything labeled with `help wanted`, they will be the perfect starting point! If you don't see any, just let us know, we would be happy to hear from you.