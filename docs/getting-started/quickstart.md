# Quick Start Guide

This guide will help you deploy your first application using the Application chart.

## Deploy a Simple Web Application

### Step 1: Create a values file

Create a file named `my-app-values.yaml`:

```yaml
applicationName: my-web-app

deployment:
  enabled: true
  replicas: 2
  image:
    repository: nginx
    tag: "1.25"
    pullPolicy: IfNotPresent
  
  ports:
    - containerPort: 80
      name: http
      protocol: TCP
  
  resources:
    limits:
      memory: 256Mi
      cpu: 500m
    requests:
      memory: 128Mi
      cpu: 100m

service:
  enabled: true
  type: ClusterIP
  ports:
    - port: 80
      name: http
      protocol: TCP
      targetPort: 80

ingress:
  enabled: true
  ingressClassName: nginx
  hosts:
    - host: my-app.example.com
      paths:
        - path: /
          pathType: Prefix
```

### Step 2: Install the Chart

```bash
helm install my-web-app codefuturist/application -f my-app-values.yaml
```

### Step 3: Verify Deployment

```bash
# Check the deployment status
kubectl get deployments

# Check the pods
kubectl get pods -l app.kubernetes.io/name=my-web-app

# Check the service
kubectl get svc
```

## Common Use Cases

### Deploy a CronJob

```yaml
applicationName: my-cronjob

deployment:
  enabled: false

cronJob:
  enabled: true
  jobs:
    cleanup:
      schedule: "0 2 * * *"  # Run at 2 AM daily
      image:
        repository: busybox
        tag: latest
      command: ["/bin/sh"]
      args: ["-c", "echo 'Running cleanup...'"]
```

### Deploy with ConfigMap and Secret

```yaml
applicationName: my-configured-app

configMap:
  enabled: true
  files:
    app-config:
      DATABASE_HOST: postgres.default.svc
      LOG_LEVEL: info

secret:
  enabled: true
  files:
    db-credentials:
      data:
        DB_PASSWORD: supersecret123

deployment:
  enabled: true
  envFrom:
    app-config:
      type: configmap
      nameSuffix: app-config
    db-credentials:
      type: secret
      nameSuffix: db-credentials
```

### Enable Autoscaling

```yaml
applicationName: my-scalable-app

deployment:
  enabled: true
  replicas: 2

autoscaling:
  enabled: true
  minReplicas: 2
  maxReplicas: 10
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 70
```

## Next Steps

- Browse all [available charts](../charts/index.md)
- Search for specific [values](../reference/search.md)
- Learn about [contributing](../CONTRIBUTING.md)
