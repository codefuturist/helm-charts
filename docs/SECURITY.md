# Security Policy

## Supported Versions

| Version | Supported          |
|---------|--------------------|
| Latest  | :white_check_mark: |
| < Latest | :x:               |

We only provide security updates for the latest version of each chart. Please ensure you are running the most recent version.

## Reporting a Vulnerability

If you discover a security vulnerability in any of our Helm charts, please report it responsibly:

1. **Do NOT** open a public GitHub issue for security vulnerabilities
2. Email the maintainer directly at: <58808821+codefuturist@users.noreply.github.com>
3. Include the following information:
   - Chart name and version affected
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Any suggested fixes (optional)

### Response Timeline

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 1 week
- **Fix/Patch**: Depends on severity (critical: ASAP, high: 1-2 weeks, medium/low: next release)

## Security Practices

### Container Images

- Charts use **official upstream images** whenever available
- Image tags are pinned to specific versions (not `latest`) in default values
- Users are encouraged to use image digests for production deployments

### Secrets Management

- Sensitive values (passwords, API keys) should be provided via:
  - Kubernetes Secrets (referenced in values)
  - External Secrets Operator integration (where supported)
  - Environment variables from ConfigMaps/Secrets
- Default values never contain real credentials
- Charts support existing secret references to avoid storing secrets in values files

### RBAC and Permissions

- Charts create minimal RBAC permissions required for operation
- ServiceAccounts are created per-release by default
- PodSecurityContext and SecurityContext are configurable
- Many charts support running as non-root by default

### Network Security

- NetworkPolicies are available for charts that support them
- Ingress resources use TLS configuration where applicable
- Service exposure is configurable (ClusterIP, NodePort, LoadBalancer)

## Kubernetes Version Support

Charts are tested against:

- Kubernetes 1.25+
- Helm 3.8+

Older versions may work but are not officially supported.

## Dependency Security

- Chart dependencies are regularly updated via Dependabot
- Third-party chart dependencies are pinned to specific versions
- The `charts/libs/common` library is maintained internally

## Best Practices for Users

1. **Always review values before deploying** - Understand what you're enabling
2. **Use namespaces** - Isolate workloads appropriately
3. **Enable NetworkPolicies** - Restrict network access where supported
4. **Use external secret management** - Don't store secrets in Git
5. **Keep charts updated** - Apply security patches promptly
6. **Scan images** - Use tools like Trivy to scan container images

## Changelog

Security-related changes are noted in chart release notes and GitHub releases.
