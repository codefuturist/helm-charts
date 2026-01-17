# Paperless-ngx Chart Development Guide

## Prerequisites

- Kubernetes cluster (minikube, kind, or cloud provider)
- Helm 3.0+
- kubectl configured to access your cluster

## Local Development

### Testing with Helm

1. **Lint the chart:**

   ```bash
   helm lint charts/paperless-ngx
   ```

2. **Dry run to see generated manifests:**

   ```bash
   helm install paperless-ngx charts/paperless-ngx \
     --dry-run --debug \
     --set database.postgresql.host=postgresql \
     --set database.postgresql.password=test \
     --set redis.host=redis
   ```

3. **Template specific resources:**
   ```bash
   helm template paperless-ngx charts/paperless-ngx \
     --show-only templates/deployment.yaml
   ```

### Installing Dependencies for Testing

1. **Install PostgreSQL:**

   ```bash
   helm install postgresql oci://registry-1.docker.io/bitnamicharts/postgresql \
     --set auth.username=paperless \
     --set auth.password=paperless \
     --set auth.database=paperless
   ```

2. **Install Redis:**

   ```bash
   helm install redis oci://registry-1.docker.io/bitnamicharts/redis \
     --set auth.password=redis
   ```

3. **Install Paperless-ngx:**
   ```bash
   helm install paperless-ngx charts/paperless-ngx \
     --set database.postgresql.host=postgresql \
     --set database.postgresql.password=paperless \
     --set redis.host=redis-master \
     --set redis.password=redis \
     --set config.secretKey="test-key-change-in-production"
   ```

### Upgrading the Chart

```bash
helm upgrade paperless-ngx charts/paperless-ngx \
  --reuse-values \
  --set image.tag=2.14.0
```

### Uninstalling

```bash
helm uninstall paperless-ngx
helm uninstall postgresql
helm uninstall redis
```

## Chart Structure

```
paperless-ngx/
├── Chart.yaml              # Chart metadata
├── values.yaml            # Default configuration values
├── README.md              # Chart documentation
├── templates/             # Kubernetes manifests
│   ├── NOTES.txt         # Post-install notes
│   ├── _helpers.tpl      # Template helpers
│   ├── deployment.yaml   # Main web server deployment
│   ├── worker-deployment.yaml  # Celery worker deployment
│   ├── service.yaml      # Kubernetes service
│   ├── serviceaccount.yaml
│   ├── secret.yaml       # Secret management
│   ├── pvc.yaml          # Persistent volume claims
│   ├── ingress.yaml      # Ingress configuration
│   ├── hpa.yaml          # Horizontal pod autoscaler
│   ├── pdb.yaml          # Pod disruption budget
│   ├── networkpolicy.yaml # Network policies
│   └── servicemonitor.yaml # Prometheus monitoring
├── ci/                    # CI test configurations
│   └── test-values.yaml
└── examples/             # Example configurations
    ├── minimal-values.yaml
    ├── production-values.yaml
    ├── existing-secret-values.yaml
    └── ha-values.yaml
```

## Testing Checklist

Before submitting changes, ensure:

- [ ] `helm lint` passes without errors
- [ ] All templates render correctly with default values
- [ ] All templates render with example configurations
- [ ] Required fields are validated (database host, etc.)
- [ ] Security contexts are properly configured
- [ ] Resource limits are set
- [ ] Health probes are configured
- [ ] Documentation is updated
- [ ] Version is bumped in Chart.yaml

## Common Tasks

### Adding a New Configuration Option

1. Add to `values.yaml` with documentation:

   ```yaml
   ## @param config.newOption Description of new option
   ##
   newOption: "defaultValue"
   ```

2. Use in templates:

   ```yaml
   - name: PAPERLESS_NEW_OPTION
     value: { { .Values.config.newOption | quote } }
   ```

3. Document in README.md

### Adding a New Template

1. Create template file in `templates/` directory
2. Include proper metadata and labels
3. Add conditional rendering if optional
4. Test with `helm template`

### Updating Image Version

1. Update `appVersion` in `Chart.yaml`
2. Update image tag in documentation
3. Test new version

## Release Process

1. Update version in `Chart.yaml`:
   - Increment `version` (chart version)
   - Update `appVersion` (application version)

2. Update CHANGELOG.md with changes

3. Create git tag:

   ```bash
   git tag -a paperless-ngx-0.2.0 -m "Release paperless-ngx chart version 0.2.0"
   git push origin paperless-ngx-0.2.0
   ```

4. Package chart:

   ```bash
   helm package charts/paperless-ngx
   ```

5. Update repository index:
   ```bash
   helm repo index .
   ```

## Troubleshooting Development

### Template Rendering Issues

Use `--debug` flag to see detailed error messages:

```bash
helm install paperless-ngx charts/paperless-ngx --debug --dry-run
```

### Testing Specific Scenarios

Create custom values files for different scenarios:

```bash
helm template paperless-ngx charts/paperless-ngx -f test-scenario.yaml
```

### Checking Generated Resources

```bash
helm get manifest paperless-ngx | kubectl apply --dry-run=client -f -
```

## Best Practices

1. **Always use semantic versioning** for chart versions
2. **Document all values** with `@param` annotations
3. **Provide sensible defaults** that work out of the box
4. **Use helpers** for repeated template logic
5. **Validate required values** using validation helpers
6. **Follow Kubernetes best practices** for security and resource management
7. **Test with multiple Kubernetes versions**
8. **Keep backward compatibility** when possible

## Resources

- [Helm Chart Best Practices](https://helm.sh/docs/chart_best_practices/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Paperless-ngx Documentation](https://docs.paperless-ngx.com/)
