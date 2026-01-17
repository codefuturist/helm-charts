# Docker Compose to Helm Chart Converter - Complete System

## 📋 Overview

This is a comprehensive template system for converting Docker Compose files into production-ready Helm charts. The system follows Kubernetes and Helm best practices and provides a complete workflow from conversion to deployment.

## 🎯 Key Features

### Conversion Capabilities

- ✅ **Service to Deployment**: Converts Docker Compose services to Kubernetes Deployments
- ✅ **Port Mapping**: Automatically creates Services from port configurations
- ✅ **Volume Handling**: Converts volumes to PersistentVolumeClaims or HostPath
- ✅ **Environment Variables**: Smart conversion with Secret/ConfigMap support
- ✅ **Health Checks**: Transforms health checks to liveness/readiness probes
- ✅ **Resource Management**: Maps CPU and memory limits/requests
- ✅ **Multi-Service Support**: Handles complex compose files with multiple services

### Generated Chart Features

- ✅ **Complete Chart Structure**: All necessary files and directories
- ✅ **Production-Ready Templates**: Deployment, Service, Ingress, ConfigMap, Secret, PVC
- ✅ **Helper Functions**: Reusable template helpers in \_helpers.tpl
- ✅ **Documentation**: Auto-generated README with examples
- ✅ **Best Practices**: Security contexts, labels, annotations, probes
- ✅ **Customizable Values**: Well-structured values.yaml with sensible defaults
- ✅ **Example Configurations**: Minimal and production example values files

## 📁 Directory Structure

```
tools/compose-converter/
├── compose2helm.py          # Main converter script (700+ lines)
├── setup.sh                 # Quick setup script
├── validate-chart.sh        # Chart validation script
├── Makefile                 # Common operations
├── requirements.txt         # Python dependencies
├── .gitignore              # Git ignore rules
│
├── README.md               # Main documentation
├── BEST_PRACTICES.md       # Helm chart best practices guide
├── MIGRATION_GUIDE.md      # Step-by-step migration guide
├── CHANGELOG.md            # Version history
├── test_compose2helm.py    # Unit tests
│
└── examples/               # Example compose files
    ├── simple-app.yml      # Single service example
    ├── wordpress.yml       # Multi-service (WordPress + MySQL)
    └── fullstack-app.yml   # Complex app (App + PostgreSQL + Redis)
```

## 🚀 Quick Start

### Option 1: Using the Setup Script

```bash
cd tools/compose-converter
./setup.sh
```

### Option 2: Manual Setup

```bash
cd tools/compose-converter

# Install dependencies
pip3 install -r requirements.txt

# Make scripts executable
chmod +x compose2helm.py setup.sh validate-chart.sh

# Convert an example
python3 compose2helm.py -c examples/simple-app.yml -o ../../charts -n simple-app
```

### Option 3: Using Make

```bash
cd tools/compose-converter

# Install and run example
make quick-start

# Or run specific commands
make install
make examples
make validate
```

## 📖 Documentation Structure

### 1. README.md

- **Purpose**: Main documentation for the converter tool
- **Contents**:
  - Features overview
  - Installation instructions
  - Usage examples
  - Supported Compose features
  - Conversion mappings
  - Generated chart structure
  - Post-conversion steps
  - Troubleshooting guide

### 2. BEST_PRACTICES.md

- **Purpose**: Comprehensive guide to Helm chart best practices
- **Contents**:
  - Chart structure guidelines
  - Values organization patterns
  - Template design principles
  - Naming conventions
  - Labels and annotations standards
  - Security best practices
  - Resource management
  - Configuration management
  - Deployment strategies
  - Monitoring and observability
  - Additional recommendations

### 3. MIGRATION_GUIDE.md

- **Purpose**: Step-by-step guide for migrating from Docker Compose to Kubernetes
- **Contents**:
  - Pre-migration checklist
  - Detailed migration steps
  - Common patterns and solutions
  - Environment-specific configurations
  - Database migration strategies
  - Service dependency handling
  - Post-migration tasks
  - Troubleshooting section
  - Migration checklist

### 4. CHANGELOG.md

- **Purpose**: Version history and feature tracking
- **Contents**:
  - Current version features (1.0.0)
  - Planned features
  - Planned improvements
  - Contributing guidelines

## 🛠️ Core Components

### 1. compose2helm.py (Main Converter)

**Key Classes:**

- `ComposeConverter`: Main converter class with all conversion logic

**Key Methods:**

- `load_compose()`: Parse Docker Compose file
- `generate_chart_yaml()`: Create Chart.yaml
- `generate_values_yaml()`: Generate values.yaml from services
- `generate_templates()`: Create all template files
- `_convert_service_to_values()`: Convert service to Helm values
- `_convert_environment()`: Handle environment variables
- `_convert_ports()`: Map port configurations
- `_convert_healthcheck()`: Convert health checks to probes
- `_convert_resources()`: Map resource limits

**Supported Compose Features:**

- Services (image, command, args, ports, environment, volumes, healthcheck, user, deploy.resources)
- Volumes (named volumes, bind mounts)
- Networks (basic support)
- Secrets (basic support)

### 2. Generated Template Files

**Core Templates:**

- `_helpers.tpl`: Template helper functions
- `deployment.yaml`: Main workload
- `service.yaml`: Service for networking
- `ingress.yaml`: Ingress rules
- `configmap.yaml`: Configuration data
- `secret.yaml`: Sensitive data
- `pvc.yaml`: Persistent volume claims
- `NOTES.txt`: Post-installation notes

**Template Features:**

- Conditional rendering based on values
- Checksum annotations for reload on change
- Proper label and selector management
- Support for multiple services
- Resource limits and requests
- Security contexts
- Health probes
- Volume mounts

### 3. Supporting Scripts

**setup.sh:**

- Checks Python installation
- Installs dependencies
- Makes scripts executable
- Shows usage examples

**validate-chart.sh:**

- Runs helm lint
- Tests template rendering
- Checks required files
- Validates Chart.yaml structure
- Tests dry-run installation
- Provides next steps

**Makefile:**

- `install`: Install dependencies
- `test`: Run conversion tests
- `examples`: Convert all examples
- `lint`: Lint Python code
- `clean`: Clean up test files
- `validate`: Validate generated charts
- `quick-start`: Quick installation and demo

## 💡 Usage Examples

### Basic Conversion

```bash
# Convert a simple app
python3 compose2helm.py \
  --compose docker-compose.yml \
  --output ./charts \
  --name myapp
```

### Convert with Custom Options

```bash
# Convert WordPress example
python3 compose2helm.py \
  -c examples/wordpress.yml \
  -o ../../charts \
  -n wordpress
```

### Validate Generated Chart

```bash
# Validate the chart
./validate-chart.sh ../../charts/myapp

# Or use helm directly
helm lint ../../charts/myapp
helm template test ../../charts/myapp --debug
```

### Deploy Generated Chart

```bash
cd ../../charts/myapp

# Review values
cat values.yaml

# Dry run
helm install test-release . --dry-run --debug

# Install
helm install myapp-release .

# Check deployment
kubectl get all -l app.kubernetes.io/name=myapp
```

## 🎨 Customization

### Modifying Generated Charts

After generation, you can customize:

1. **Values.yaml**: Adjust replicas, resources, environment variables
2. **Templates**: Add custom Kubernetes resources
3. **Helpers**: Add custom template functions
4. **Examples**: Create environment-specific values files

### Adding New Template Types

To add support for new Kubernetes resources:

1. Add generation method in `compose2helm.py`
2. Create template file in the generation logic
3. Update values.yaml structure
4. Add documentation

### Extending the Converter

The converter is designed to be extensible:

```python
class ComposeConverter:
    # Add new conversion methods
    def _convert_custom_feature(self, config):
        # Conversion logic
        pass

    # Add new template generators
    def _generate_custom_template(self, chart_path):
        # Template generation
        pass
```

## 🧪 Testing

### Unit Tests

```bash
# Run tests
python3 test_compose2helm.py

# Or using unittest
python3 -m unittest test_compose2helm.py
```

### Integration Tests

```bash
# Test with examples
make test

# Validate generated charts
make validate
```

### Manual Testing

```bash
# Convert and test
python3 compose2helm.py -c test.yml -o test-output -n test-chart
helm install test ./test-output/test-chart --dry-run
```

## 📦 Example Compose Files

### 1. simple-app.yml

- Single nginx service
- Basic configuration
- Health check
- Resource limits

### 2. wordpress.yml

- Multi-service (WordPress + MySQL)
- Service dependencies
- Multiple volumes
- Different resource configurations

### 3. fullstack-app.yml

- Complex application (App + PostgreSQL + Redis)
- Multiple service dependencies
- Various health check types
- Network configuration

## 🔒 Security Considerations

### Implemented Security Features

- Non-root user execution via security context
- Read-only root filesystem support
- Secret management for sensitive data
- ConfigMap for non-sensitive configuration
- Image pull secrets support
- RBAC-ready templates

### Recommendations

- Always use specific image tags (not `latest`)
- Move sensitive data to Kubernetes Secrets
- Enable network policies in production
- Set appropriate resource limits
- Use Pod Security Standards
- Enable security contexts

## 📊 Conversion Mappings

| Docker Compose                  | Kubernetes                       | Notes                           |
| ------------------------------- | -------------------------------- | ------------------------------- |
| `service`                       | `Deployment`                     | One deployment per service      |
| `ports`                         | `Service`                        | ClusterIP service by default    |
| `volumes` (named)               | `PersistentVolumeClaim`          | With configurable storage class |
| `volumes` (bind)                | `hostPath`                       | Not recommended for production  |
| `environment`                   | `env` + `Secret`/`ConfigMap`     | Smart detection of secrets      |
| `healthcheck`                   | `livenessProbe`/`readinessProbe` | HTTP and exec probes            |
| `deploy.resources.limits`       | `resources.limits`               | CPU and memory                  |
| `deploy.resources.reservations` | `resources.requests`             | CPU and memory                  |
| `user`                          | `securityContext.runAsUser`      | User ID mapping                 |
| `command`                       | `command`                        | Array format                    |
| `entrypoint`                    | `command`                        | Combined with args              |

## 🚀 Deployment Workflow

### 1. Development

```bash
# Convert compose file
python3 compose2helm.py -c compose.yml -o charts -n myapp

# Test locally
helm install test charts/myapp --dry-run
```

### 2. Staging

```bash
# Create staging values
cp charts/myapp/values.yaml charts/myapp/values-staging.yaml
# Edit staging-specific settings

# Deploy to staging
helm install myapp-staging charts/myapp -f values-staging.yaml -n staging
```

### 3. Production

```bash
# Create production values
cp charts/myapp/values.yaml charts/myapp/values-production.yaml
# Edit production settings (replicas, resources, ingress, etc.)

# Deploy to production
helm install myapp-prod charts/myapp -f values-production.yaml -n production
```

## 📈 Monitoring and Observability

The generated charts support:

- **Prometheus**: ServiceMonitor templates
- **Logging**: Structured logging configuration
- **Health Checks**: Liveness and readiness probes
- **Metrics**: Application metrics endpoints
- **Tracing**: Distributed tracing configuration

## 🤝 Contributing

Contributions are welcome! Areas for contribution:

- Additional Docker Compose feature support
- New template types (StatefulSet, DaemonSet)
- Enhanced conversion logic
- Additional tests
- Documentation improvements

## 🔧 Troubleshooting

### Common Issues

**Import Error (PyYAML)**

```bash
pip3 install pyyaml
```

**Permission Denied**

```bash
chmod +x compose2helm.py
```

**Chart Validation Failed**

- Check Chart.yaml structure
- Verify template syntax
- Review values.yaml references

**Deployment Issues**

- Check image availability
- Verify environment variables
- Review resource limits
- Check persistent volume configuration

## 📚 Additional Resources

- [Helm Documentation](https://helm.sh/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)
- [Docker Compose Specification](https://docs.docker.com/compose/compose-file/)
- [Twelve-Factor App](https://12factor.net/)

## 📝 License

This project follows the same license as the parent repository.

## 🎓 Learning Path

1. **Start Here**: README.md - Understand the tool
2. **Learn Best Practices**: BEST_PRACTICES.md - Helm chart standards
3. **Migrate**: MIGRATION_GUIDE.md - Step-by-step migration
4. **Practice**: Use example compose files
5. **Customize**: Modify generated charts for your needs
6. **Deploy**: Follow the deployment workflow
7. **Monitor**: Set up observability

## 🌟 Success Criteria

After using this system, you should have:

- ✅ A production-ready Helm chart
- ✅ Proper resource management
- ✅ Security best practices implemented
- ✅ Health checks configured
- ✅ Documentation for your chart
- ✅ Multiple environment support
- ✅ Monitoring and observability

---

**Built with ❤️ following Kubernetes and Helm best practices**

For questions or issues, refer to the documentation or open an issue in the repository.
