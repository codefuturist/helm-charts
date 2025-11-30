# Bitwarden ESO Provider - Project Structure

This project is split into two separate components:

## 1. Python Application (`apps/bitwarden-eso-provider-app/`)

Contains the webhook service application code and container build files.

```
apps/bitwarden-eso-provider-app/
├── app/
│   ├── app.py              # CLI-based implementation
│   ├── app-sdk.py          # SDK-based implementation  
│   ├── requirements.txt    # CLI dependencies
│   └── requirements-sdk.txt # SDK dependencies
├── Dockerfile              # CLI version container
├── Dockerfile.sdk          # SDK version container
├── pyproject.toml          # UV project configuration
└── README.md               # Application documentation
```

**Purpose**: Build and publish container images
**Technology**: Python 3.11, Flask, UV package manager
**Container Registry**: `ghcr.io/codefuturist/bitwarden-eso-provider`

## 2. Helm Chart (`bitwarden-eso-provider/`)

Contains Kubernetes deployment configuration using Helm.

```
bitwarden-eso-provider/
├── Chart.yaml              # Chart metadata
├── values.yaml             # Default configuration
├── README.md               # Chart documentation
├── .helmignore             # Files to exclude from package
├── templates/              # Kubernetes manifests
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── secret.yaml
│   ├── secretstore.yaml
│   └── ...
├── examples/               # Example configurations
│   ├── values-minimal.yaml
│   ├── values-production.yaml
│   └── ...
└── docs/                   # Additional documentation
    ├── ARCHITECTURE.md
    ├── QUICKSTART.md
    └── ...
```

**Purpose**: Deploy the application to Kubernetes
**Technology**: Helm 3, Kubernetes manifests
**Chart Repository**: Published alongside container images

## Workflow

### Development & Build (Python App)

1. Navigate to `apps/bitwarden-eso-provider-app/`
2. Make code changes
3. Build containers:
   ```bash
   docker build -f Dockerfile.sdk -t ghcr.io/codefuturist/bitwarden-eso-provider:sdk .
   docker build -f Dockerfile -t ghcr.io/codefuturist/bitwarden-eso-provider:latest .
   ```
4. Push to registry:
   ```bash
   docker push ghcr.io/codefuturist/bitwarden-eso-provider:sdk
   docker push ghcr.io/codefuturist/bitwarden-eso-provider:latest
   ```

### Deployment (Helm Chart)

1. Navigate to parent directory containing `charts/`
2. Install/upgrade chart:
   ```bash
   helm install bitwarden-eso charts/bitwarden-eso-provider \
     --set image.tag=sdk \
     --set bitwarden.auth.apiKey.clientId=xxx \
     --set bitwarden.auth.apiKey.clientSecret=xxx
   ```

## Benefits of Separation

1. **Clean Packaging**: Helm charts don't include Python code
2. **Independent Versioning**: App and chart can have different versions
3. **Clear Responsibilities**:
   - App directory: Container image builds
   - Chart directory: Kubernetes deployments
4. **Easier CI/CD**: Separate pipelines for app builds vs chart releases
5. **Better Organization**: Clear separation of concerns

## Container Image Tags

Both versions reference the same external registry:

- `ghcr.io/codefuturist/bitwarden-eso-provider:sdk` - SDK version (recommended)
- `ghcr.io/codefuturist/bitwarden-eso-provider:latest` - CLI version
- Custom tags can be specified in values.yaml

## Related Documentation

- **App README**: `apps/bitwarden-eso-provider-app/README.md`
- **Chart README**: `charts/bitwarden-eso-provider/README.md`
- **Architecture**: `charts/bitwarden-eso-provider/docs/ARCHITECTURE.md`
- **Quick Start**: `charts/bitwarden-eso-provider/docs/QUICKSTART.md`
