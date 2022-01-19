# Installation using Helm

Before installing Hydrosphere Monitoring, please install its prerequisites: 

* [Helm 3.0+](https://helm.sh/docs/intro/install/)
* [Kubernetes 1.16+ with v1 API](https://kubernetes.io/docs/setup/) with beta APIs enabled.

## Install from charts repository

1. Add the Hydrosphere Monitoring charts repository:
    ```sh
    helm repo add hydromonitoring https://hydrospheredata.github.io/hydro-monitoring/helm/
    ```
2. Install the chart from repo to the cluster:
    ```sh
    helm install monitoring hydromonitoring/monitoring --namespace hydromonitoring --create-namespace
    ```

## Install from source

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
