# Docker Compose to Helm Chart Converter

A comprehensive tool to convert Docker Compose files into production-ready Helm charts following Kubernetes best practices.

## Features

✨ **Comprehensive Conversion**
- Converts Docker Compose services to Kubernetes Deployments
- Maps container ports to Kubernetes Services
- Transforms volumes into PersistentVolumeClaims
- Converts environment variables with support for Secrets and ConfigMaps
- Handles health checks (liveness and readiness probes)
- Maps resource limits and requests
- Supports multiple services in a single compose file

🎯 **Best Practices**
- Generates production-ready Helm templates
- Includes proper label management
- Implements security contexts
- Supports rolling updates
- Creates reloadable deployments on config changes
- Includes pod disruption budgets considerations
- Follows Kubernetes naming conventions

📦 **Complete Chart Structure**
- Chart.yaml with metadata
- values.yaml with sensible defaults
- Comprehensive template files (deployment, service, ingress, configmap, secret, pvc)
- Helper functions in _helpers.tpl
- NOTES.txt for post-installation instructions
- Example values files (minimal, production)
- Generated README.md

## Installation

### Quick Start with UV (Recommended) ⚡

[UV](https://github.com/astral-sh/uv) is a fast Python package manager (10-100x faster than pip).

```bash
# Install uv (if not already installed)
curl -LsSf https://astral.sh/uv/install.sh | sh

# Sync dependencies (creates .venv automatically)
uv sync

# Run the converter
uv run python compose2helm.py -c docker-compose.yml -o charts -n myapp

# Run tests
uv run python test_compose2helm.py -v
```

**Benefits**: Faster installs, automatic virtual environment, lock files for reproducibility.

See [UV_GUIDE.md](UV_GUIDE.md) for detailed uv usage.

### Alternative: Traditional pip

```bash
# Install dependencies
pip3 install -r requirements.txt

# Run the converter
python3 compose2helm.py -c docker-compose.yml -o charts -n myapp
```

### Using the Setup Script

```bash
# Automatic setup (installs uv and dependencies)
./setup.sh
```

### Prerequisites

- Python 3.8+ (Python 3.12+ recommended)
- PyYAML library (installed automatically)

## Usage

### Basic Usage

**With UV (recommended):**
```bash
uv run python compose2helm.py --compose docker-compose.yml --output charts --name myapp
```

**With Python:**
```bash
python compose2helm.py --compose docker-compose.yml --output charts --name myapp
```

**Using Make:**
```bash
make examples  # Convert all example files
make test      # Run tests and convert examples
```

### Command Line Options

```
-c, --compose   Path to Docker Compose file (required)
-o, --output    Output directory for the Helm chart (default: ./charts)
-n, --name      Name of the Helm chart (required)
--version       Show version information
```

### Examples

#### Convert a simple application

```bash
python compose2helm.py \
  --compose examples/simple-app/docker-compose.yml \
  --output ../../charts \
  --name simple-app
```

#### Convert a multi-service application

```bash
python compose2helm.py \
  --compose examples/wordpress/docker-compose.yml \
  --output ../../charts \
  --name wordpress
```

#### Specify custom output location

```bash
python compose2helm.py \
  -c ~/projects/myapp/docker-compose.yml \
  -o ~/helm-charts \
  -n myapp
```

## Docker Compose Support

### Supported Features

The converter supports the following Docker Compose features:

**Service Configuration:**
- ✅ `image` - Container image and tag
- ✅ `command` - Override default command
- ✅ `entrypoint` - Override entrypoint
- ✅ `args` - Command arguments
- ✅ `ports` - Port mappings
- ✅ `environment` - Environment variables
- ✅ `volumes` - Volume mounts (named volumes and bind mounts)
- ✅ `healthcheck` - Health check configuration
- ✅ `user` - Run as specific user
- ✅ `deploy.resources` - CPU and memory limits/reservations
- ✅ `deploy.replicas` - Number of replicas

**Top-Level Configuration:**
- ✅ `volumes` - Named volume definitions
- ✅ `networks` - Network configuration (basic support)
- ✅ `secrets` - Secret definitions

### Conversion Mappings

| Docker Compose | Kubernetes | Notes |
|----------------|------------|-------|
| `service` | `Deployment` | Each service becomes a deployment |
| `ports` | `Service` | Port mappings create ClusterIP services |
| `volumes` (named) | `PersistentVolumeClaim` | Named volumes become PVCs |
| `volumes` (bind) | `hostPath` | Bind mounts use hostPath (not recommended for production) |
| `environment` | `env` / `Secret` / `ConfigMap` | Env vars can reference secrets |
| `healthcheck` | `livenessProbe` / `readinessProbe` | HTTP and exec probes supported |
| `deploy.resources.limits` | `resources.limits` | CPU and memory limits |
| `deploy.resources.reservations` | `resources.requests` | CPU and memory requests |
| `user` | `securityContext.runAsUser` | User ID mapping |

## Generated Chart Structure

```
myapp/
├── Chart.yaml                      # Chart metadata
├── values.yaml                     # Default values
├── README.md                       # Chart documentation
├── examples/
│   ├── values-minimal.yaml        # Minimal configuration
│   └── values-production.yaml     # Production configuration
└── templates/
    ├── _helpers.tpl               # Template helpers
    ├── NOTES.txt                  # Post-install notes
    ├── deployment.yaml            # Main deployment
    ├── service.yaml               # Kubernetes service
    ├── ingress.yaml               # Ingress configuration
    ├── configmap.yaml             # ConfigMap for configuration
    ├── secret.yaml                # Secret for sensitive data
    └── pvc.yaml                   # PersistentVolumeClaim
```

## Post-Conversion Steps

After conversion, you should:

1. **Review the values.yaml**
   - Verify image tags and repositories
   - Check resource limits and requests
   - Configure environment variables
   - Set up proper secrets

2. **Customize Templates**
   - Add service-specific configurations
   - Configure ingress rules
   - Set up monitoring and observability
   - Add backup strategies

3. **Test the Chart**
   ```bash
   # Lint the chart
   helm lint myapp

   # Dry run installation
   helm install test-release myapp --dry-run --debug

   # Install the chart
   helm install myapp-release myapp

   # Check the deployment
   kubectl get all -l app.kubernetes.io/name=myapp
   ```

4. **Security Review**
   - Move sensitive data to Kubernetes Secrets
   - Configure RBAC if needed
   - Set up Network Policies
   - Review security contexts

## Best Practices Applied

### 1. Labels and Selectors
- Uses standard Kubernetes labels (`app.kubernetes.io/name`, `app.kubernetes.io/instance`)
- Implements consistent label management
- Supports custom labels via `additionalLabels`

### 2. Configuration Management
- Separates configuration (ConfigMap) from secrets (Secret)
- Supports reload on config changes via annotations
- Uses tpl function for dynamic value substitution

### 3. Resource Management
- Defines resource requests and limits
- Supports horizontal pod autoscaling
- Includes pod disruption budget considerations

### 4. Health and Readiness
- Converts Docker health checks to Kubernetes probes
- Supports both HTTP and exec probes
- Configurable timing and thresholds

### 5. Storage
- Uses PersistentVolumeClaims for data persistence
- Supports multiple access modes
- Allows storage class customization

### 6. Networking
- Creates ClusterIP services by default
- Supports LoadBalancer and NodePort
- Includes Ingress configuration with TLS support

### 7. Security
- Implements security contexts
- Supports running as non-root
- Includes image pull secrets
- Secret management for sensitive data

## Example Docker Compose Files

### Simple Application

```yaml
version: '3.8'
services:
  web:
    image: nginx:1.21
    ports:
      - "8080:80"
    environment:
      - NGINX_HOST=localhost
      - NGINX_PORT=80
    volumes:
      - web-data:/usr/share/nginx/html
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:80"]
      interval: 30s
      timeout: 5s
      retries: 3

volumes:
  web-data:
```

### Multi-Service Application

```yaml
version: '3.8'
services:
  app:
    image: myapp:latest
    ports:
      - "3000:3000"
    environment:
      DB_HOST: db
      DB_PORT: 5432
      DB_NAME: myapp
    depends_on:
      - db
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 512M
        reservations:
          cpus: '0.5'
          memory: 256M

  db:
    image: postgres:14
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:
```

## Troubleshooting

### Common Issues

**Issue: Unsupported compose version**
- Solution: The tool supports Compose v2 and v3 formats. Use a compatible version.

**Issue: Complex port mappings not converted correctly**
- Solution: Manually review and adjust the Service configuration in the generated chart.

**Issue: Environment variables referencing other services**
- Solution: Update the environment variables to use Kubernetes Service DNS names (e.g., `db` becomes `myapp-db`).

**Issue: Bind mounts using hostPath**
- Solution: For production, replace hostPath volumes with PersistentVolumeClaims.

## Advanced Configuration

### Custom Templates

You can extend the generated templates by:

1. Adding custom resource types (StatefulSet, DaemonSet)
2. Including additional Kubernetes resources (NetworkPolicy, ServiceMonitor)
3. Implementing custom hooks (pre-install, post-upgrade)

### Multi-Environment Support

Create environment-specific values files:

```bash
# Development
helm install myapp ./myapp -f values-dev.yaml

# Staging
helm install myapp ./myapp -f values-staging.yaml

# Production
helm install myapp ./myapp -f values-production.yaml
```

## Contributing

Contributions are welcome! Areas for improvement:

- Support for more Docker Compose features
- Additional template types (StatefulSet, DaemonSet)
- Advanced networking configurations
- Integration with other tools (Skaffold, Tilt)

## License

MIT License - See LICENSE file for details

## Support

For issues, questions, or contributions:
- Open an issue in the repository
- Submit a pull request
- Contact the maintainers

---

**Happy Helming! ⛵**
