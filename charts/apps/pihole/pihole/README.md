# Pi-hole Helm Chart

A production-ready Helm chart for [Pi-hole](https://pi-hole.net/) DNS ad blocker with Kubernetes best practices.

## Description

This Helm chart deploys Pi-hole on Kubernetes with comprehensive support for:

- ✅ **Security**: Pod Security Standards, NetworkPolicies, ServiceAccounts with RBAC
- ✅ **High Availability**: Pod Disruption Budgets, Anti-affinity rules, Health probes
- ✅ **Scalability**: Horizontal Pod Autoscaling, Topology spread constraints
- ✅ **Observability**: Prometheus ServiceMonitor integration, Structured logging
- ✅ **Reliability**: Startup/Liveness/Readiness probes, Rolling updates
- ✅ **Storage**: Persistent Volume Claims for stateful data
- ✅ **Networking**: Ingress support with TLS, Service customization

## Prerequisites

- Kubernetes 1.23+
- Helm 3.8+
- PV provisioner support in the underlying infrastructure (for persistence)
- (Optional) Prometheus Operator (for ServiceMonitor)
- (Optional) Cert-manager (for automated TLS certificates)

## Installation

### Quick Start

```bash
# Add the Helm repository (if published)
helm repo add my-charts https://charts.example.com
helm repo update

# Install with default values
helm install pihole my-charts/pihole

# Or install from local directory
helm install pihole ./pihole
```

### Install with Custom Values

```bash
# Install with production configuration
helm install pihole ./pihole -f examples/values-production.yaml

# Install with monitoring enabled
helm install pihole ./pihole -f examples/values-with-monitoring.yaml

# Install with high availability
helm install pihole ./pihole -f examples/values-ha.yaml
```

### Upgrade

```bash
helm upgrade pihole ./pihole -f your-values.yaml
```

### Uninstall

```bash
helm uninstall pihole
```

## Configuration

For detailed Pi-hole Docker configuration options, see the [official documentation](https://docs.pi-hole.net/docker/configuration/).

### Core Parameters

| Parameter           | Description                         | Default |
| ------------------- | ----------------------------------- | ------- |
| `namespaceOverride` | Override the deployment namespace   | `""`    |
| `applicationName`   | Override the application name       | `""`    |
| `additionalLabels`  | Additional labels for all resources | `{}`    |

### ServiceAccount

| Parameter                         | Description                              | Default |
| --------------------------------- | ---------------------------------------- | ------- |
| `serviceAccount.enabled`          | Create a ServiceAccount                  | `true`  |
| `serviceAccount.name`             | ServiceAccount name (generated if empty) | `""`    |
| `serviceAccount.annotations`      | ServiceAccount annotations               | `{}`    |
| `serviceAccount.imagePullSecrets` | Image pull secrets for ServiceAccount    | `[]`    |

### NetworkPolicy

| Parameter               | Description                                | Default         |
| ----------------------- | ------------------------------------------ | --------------- |
| `networkPolicy.enabled` | Enable NetworkPolicy for network isolation | `false`         |
| `networkPolicy.ingress` | Ingress rules                              | See values.yaml |
| `networkPolicy.egress`  | Egress rules                               | See values.yaml |

### PodDisruptionBudget

| Parameter                            | Description                      | Default |
| ------------------------------------ | -------------------------------- | ------- |
| `podDisruptionBudget.enabled`        | Enable PDB for high availability | `false` |
| `podDisruptionBudget.minAvailable`   | Minimum available pods           | `nil`   |
| `podDisruptionBudget.maxUnavailable` | Maximum unavailable pods         | `1`     |

### ServiceMonitor (Prometheus)

| Parameter                         | Description                          | Default                     |
| --------------------------------- | ------------------------------------ | --------------------------- |
| `serviceMonitor.enabled`          | Enable Prometheus ServiceMonitor     | `false`                     |
| `serviceMonitor.interval`         | Scrape interval                      | `30s`                       |
| `serviceMonitor.path`             | Metrics path                         | `/admin/api.php?summaryRaw` |
| `serviceMonitor.additionalLabels` | Additional labels for ServiceMonitor | `{}`                        |

### Deployment

| Parameter                          | Description                | Default         |
| ---------------------------------- | -------------------------- | --------------- |
| `deployment.enabled`               | Enable deployment          | `true`          |
| `deployment.replicas`              | Number of replicas         | `1`             |
| `deployment.image.repository`      | Container image repository | `pihole/pihole` |
| `deployment.image.tag`             | Container image tag        | `latest`        |
| `deployment.image.imagePullPolicy` | Image pull policy          | `IfNotPresent`  |
| `deployment.strategy.type`         | Update strategy            | `RollingUpdate` |
| `deployment.priorityClassName`     | Priority class for pods    | `""`            |
| `deployment.dnsPolicy`             | DNS policy for pods        | `ClusterFirst`  |

### Security Context

| Parameter                                             | Description                | Default                     |
| ----------------------------------------------------- | -------------------------- | --------------------------- |
| `deployment.podSecurityContext.fsGroup`               | FSGroup for pod volumes    | `1000`                      |
| `deployment.podSecurityContext.seccompProfile.type`   | Seccomp profile            | `RuntimeDefault`            |
| `deployment.securityContext.runAsNonRoot`             | Run as non-root user       | `true`                      |
| `deployment.securityContext.runAsUser`                | User ID to run as          | `1000`                      |
| `deployment.securityContext.allowPrivilegeEscalation` | Allow privilege escalation | `false`                     |
| `deployment.securityContext.capabilities.drop`        | Dropped capabilities       | `["ALL"]`                   |
| `deployment.securityContext.capabilities.add`         | Added capabilities         | `["NET_BIND_SERVICE", ...]` |

### Health Probes

| Parameter                   | Description                   | Default         |
| --------------------------- | ----------------------------- | --------------- |
| `deployment.startupProbe`   | Startup probe configuration   | See values.yaml |
| `deployment.livenessProbe`  | Liveness probe configuration  | See values.yaml |
| `deployment.readinessProbe` | Readiness probe configuration | See values.yaml |

### Resources

| Parameter                              | Description    | Default |
| -------------------------------------- | -------------- | ------- |
| `deployment.resources.requests.cpu`    | CPU request    | `0.5`   |
| `deployment.resources.requests.memory` | Memory request | `256M`  |
| `deployment.resources.limits.cpu`      | CPU limit      | `2`     |
| `deployment.resources.limits.memory`   | Memory limit   | `512M`  |

### Autoscaling

| Parameter                                                  | Description      | Default         |
| ---------------------------------------------------------- | ---------------- | --------------- |
| `deployment.autoscaling.enabled`                           | Enable HPA       | `false`         |
| `deployment.autoscaling.minReplicas`                       | Minimum replicas | `1`             |
| `deployment.autoscaling.maxReplicas`                       | Maximum replicas | `10`            |
| `deployment.autoscaling.targetCPUUtilizationPercentage`    | Target CPU %     | `80`            |
| `deployment.autoscaling.targetMemoryUtilizationPercentage` | Target Memory %  | `80`            |
| `deployment.autoscaling.behavior`                          | Scaling behavior | See values.yaml |

### Persistence

| Parameter                             | Description                           | Default |
| ------------------------------------- | ------------------------------------- | ------- |
| `persistence.etc-pihole.enabled`      | Enable persistence for /etc/pihole    | `false` |
| `persistence.etc-pihole.size`         | PVC size                              | `1Gi`   |
| `persistence.etc-pihole.storageClass` | Storage class                         | `""`    |
| `persistence.etc-dnsmasq.enabled`     | Enable persistence for /etc/dnsmasq.d | `false` |
| `persistence.etc-dnsmasq.size`        | PVC size                              | `500Mi` |

### Service

| Parameter                | Description                              | Default     |
| ------------------------ | ---------------------------------------- | ----------- |
| `service.type`           | Service type                             | `ClusterIP` |
| `service.port`           | Service port                             | `80`        |
| `service.annotations`    | Service annotations                      | `{}`        |
| `service.clusterIP`      | Specific cluster IP                      | `nil`       |
| `service.loadBalancerIP` | Load balancer IP (for LoadBalancer type) | `nil`       |

### Ingress

| Parameter             | Description                 | Default |
| --------------------- | --------------------------- | ------- |
| `ingress.enabled`     | Enable ingress              | `false` |
| `ingress.className`   | Ingress class name          | `""`    |
| `ingress.annotations` | Ingress annotations         | `{}`    |
| `ingress.hosts`       | Ingress hosts configuration | `[]`    |
| `ingress.tls`         | Ingress TLS configuration   | `[]`    |

## Examples

### Minimal Configuration

```yaml
deployment:
  enabled: true
  replicas: 1

  env:
    FTLCONF_webserver_api_password:
      value: "your-secure-password"
```

### Production Configuration with HA

```yaml
serviceAccount:
  enabled: true

podDisruptionBudget:
  enabled: true
  minAvailable: 1

deployment:
  replicas: 3

  resources:
    requests:
      memory: 256Mi
      cpu: 100m
    limits:
      memory: 512Mi
      cpu: 500m

  affinity:
    podAntiAffinity:
      preferredDuringSchedulingIgnoredDuringExecution:
        - weight: 100
          podAffinityTerm:
            labelSelector:
              matchExpressions:
                - key: app.kubernetes.io/name
                  operator: In
                  values:
                    - pihole
            topologyKey: kubernetes.io/hostname

persistence:
  etc-pihole:
    enabled: true
    size: 5Gi
    storageClass: "fast-ssd"
  etc-dnsmasq:
    enabled: true
    size: 1Gi
    storageClass: "fast-ssd"

ingress:
  enabled: true
  className: nginx
  annotations:
    cert-manager.io/cluster-issuer: letsencrypt-prod
  hosts:
    - host: pihole.example.com
      paths:
        - path: /
          pathType: Prefix
          port: 80
  tls:
    - secretName: pihole-tls
      hosts:
        - pihole.example.com
```

### With Prometheus Monitoring

```yaml
serviceMonitor:
  enabled: true
  interval: 30s
  additionalLabels:
    release: prometheus

deployment:
  replicas: 2
```

### With Network Policy

```yaml
networkPolicy:
  enabled: true
  ingress:
    - from:
        - namespaceSelector: {}
      ports:
        - protocol: UDP
          port: 53
        - protocol: TCP
          port: 53
```

## Security Best Practices

This chart implements several Kubernetes security best practices:

1. **Pod Security Standards**: Implements restricted pod security policies
2. **Secret Management**: Multiple approaches for secure credential storage (see [SECRET_MANAGEMENT.md](SECRET_MANAGEMENT.md))
3. **ServiceAccount & RBAC**: Dedicated service account with proper permissions
4. **NetworkPolicies**: Fine-grained network access control
5. **Security Contexts**: Non-root execution, capability dropping
6. **Resource Limits**: Prevent resource exhaustion
7. **Health Probes**: Detect and restart unhealthy containers

### Managing Secrets Securely

**⚠️ IMPORTANT: Never store passwords in plain text in values.yaml!**

This chart supports multiple secret management approaches:

#### Option 1: Existing Kubernetes Secret (Recommended for Simple Deployments)

```bash
# Create a secret
kubectl create secret generic pihole-secrets \
  --from-literal=WEBPASSWORD='my-password' \
  --from-literal=FTLCONF_webserver_api_password='my-api-password'
```

```yaml
secret:
  enabled: false
  existingSecret: "pihole-secrets"

deployment:
  env:
    FTLCONF_webserver_api_password:
      valueFrom:
        secretKeyRef:
          name: pihole-secrets
          key: FTLCONF_webserver_api_password
```

#### Option 2: External Secrets Operator (Recommended for Production)

```yaml
externalSecrets:
  enabled: true
  secretStoreName: "aws-secretsmanager"
  data:
    - secretKey: FTLCONF_webserver_api_password
      remoteRef:
        key: prod/pihole/api-password
```

#### Option 3: Sealed Secrets (GitOps Friendly)

```yaml
sealedSecrets:
  enabled: true
  encryptedData:
    FTLCONF_webserver_api_password: AgBZ8VzTxW5... # Encrypted with kubeseal
```

#### Option 4: Secret Store CSI Driver (Enterprise)

```yaml
secretProviderClass:
  enabled: true
  provider: aws
  parameters:
    objects: |
      - objectName: "prod/pihole/api-password"
        objectType: "secretsmanager"
```

**📖 For complete secret management documentation, see [SECRET_MANAGEMENT.md](SECRET_MANAGEMENT.md)**

**📁 For working examples, see:**

- `examples/values-existing-secret.yaml` - Using pre-created secrets (environment variables)
- `examples/values-webpassword-file.yaml` - Using file-based secrets (WEBPASSWORD_FILE) ⭐ More Secure
- `examples/values-external-secrets.yaml` - External Secrets Operator (cloud-native)
- `examples/values-sealed-secrets.yaml` - Sealed Secrets (GitOps-friendly)
- `examples/values-csi-driver.yaml` - CSI Driver (enterprise)

2. **Non-root User**: Runs as non-root user (UID 1000)
3. **Read-only Root Filesystem**: (Configurable based on Pi-hole requirements)
4. **Dropped Capabilities**: Drops all capabilities except required ones
5. **Seccomp Profile**: Uses RuntimeDefault seccomp profile
6. **NetworkPolicy**: Optional network isolation
7. **ServiceAccount**: Dedicated service account with minimal permissions

## High Availability

For production deployments, consider:

1. **Multiple Replicas**: Set `deployment.replicas` to 3 or more
2. **Pod Disruption Budget**: Enable with `podDisruptionBudget.enabled: true`
3. **Anti-affinity Rules**: Configure pod anti-affinity to spread across nodes
4. **Topology Spread**: Use topology spread constraints for zone distribution
5. **Persistent Storage**: Enable persistence with PVCs
6. **Health Probes**: Configured by default (startup, liveness, readiness)
7. **Rolling Updates**: Zero-downtime deployments with proper update strategy

## Monitoring

### Prometheus Integration

The chart supports Prometheus monitoring through ServiceMonitor CRD:

```yaml
serviceMonitor:
  enabled: true
  interval: 30s
  additionalLabels:
    release: prometheus
```

Pi-hole exposes metrics at `/admin/api.php?summaryRaw` including:

- DNS queries blocked
- Total DNS queries
- Percentage blocked
- Domains on blocklist
- Active clients

## Troubleshooting

### Pods not starting

Check logs:

```bash
kubectl logs -l app.kubernetes.io/name=pihole
```

Check events:

```bash
kubectl describe pod -l app.kubernetes.io/name=pihole
```

### DNS not working

Verify service:

```bash
kubectl get svc
kubectl describe svc pihole
```

Test DNS resolution:

```bash
kubectl run -it --rm debug --image=busybox --restart=Never -- nslookup google.com <pihole-service-ip>
```

### Permission issues

Check security context settings and ensure the storage volume has correct permissions:

```bash
kubectl exec -it <pod-name> -- ls -la /etc/pihole
```

## Contributing

Contributions welcome! Please see [CONTRIBUTING.md](../../../docs/CONTRIBUTING.md).

## Support

For bug reports, feature requests, and general questions:

- **GitHub Issues**: [Report a bug or request a feature](https://github.com/codefuturist/helm-charts/issues)
- **GitHub Discussions**: [Ask questions and discuss ideas](https://github.com/codefuturist/helm-charts/discussions)
- **Pi-hole Documentation**: [Official Pi-hole Support](https://github.com/pi-hole/pi-hole/issues)

## License

This Helm chart is licensed under the [Apache License 2.0](../../../LICENSE).

## Maintainers

| Name         | Email | GitHub                                           |
| ------------ | ----- | ------------------------------------------------ |
| codefuturist | -     | [@codefuturist](https://github.com/codefuturist) |

## Source Code

- **Chart Repository**: <https://github.com/codefuturist/helm-charts/tree/main/charts/pihole/pihole>
