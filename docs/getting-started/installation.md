# Installation

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+

## Add Helm Repository

```bash
helm repo add pandia https://charts.pandia.io
helm repo update
```

## Verify Installation

```bash
helm search repo pandia
```

You should see output similar to:

```
NAME                        CHART VERSION   APP VERSION   DESCRIPTION
pandia/application          6.14.1          1.0.0         Generic helm chart for all kind of applications
pandia/homarr               5.2.12          1.0.0         Generic helm chart for all kind of applications
pandia/nginx                0.1.2           1.27.0        Helm chart for deploying NGINX web server
```

## Install a Chart

=== "Basic Installation"

    ```bash
    helm install my-release pandia/application
    ```

=== "With Custom Values"

    ```bash
    helm install my-release pandia/application -f values.yaml
    ```

=== "Specific Namespace"

    ```bash
    helm install my-release pandia/application -n my-namespace --create-namespace
    ```

## Upgrade a Release

```bash
helm upgrade my-release codefuturist/application
```

## Uninstall a Release

```bash
helm uninstall my-release
```

!!! warning "Data Loss"
Uninstalling a release will delete all associated resources. Make sure to backup any persistent data before uninstalling.
