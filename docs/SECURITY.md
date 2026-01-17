# Security Policy

## Supported Versions

We release patches for security vulnerabilities in the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 5.x.x   | :white_check_mark: |
| < 5.0   | :x:                |

## Reporting a Vulnerability

We take the security of our Helm charts seriously. If you believe you have found a security vulnerability in any of our charts, please report it to us as described below.

### Where to Report

**Please do NOT report security vulnerabilities through public GitHub issues.**

Instead, please report them via email to: **hello@allcloud.trade**

### What to Include

Please include the following information in your report:

- Type of issue (e.g., buffer overflow, SQL injection, cross-site scripting, etc.)
- Full paths of source file(s) related to the manifestation of the issue
- The location of the affected source code (tag/branch/commit or direct URL)
- Any special configuration required to reproduce the issue
- Step-by-step instructions to reproduce the issue
- Proof-of-concept or exploit code (if possible)
- Impact of the issue, including how an attacker might exploit it

### What to Expect

- **Acknowledgment**: You should receive an acknowledgment within 48 hours
- **Initial Assessment**: We will provide an initial assessment within 7 days
- **Updates**: We will keep you informed about the progress toward a fix and announcement
- **Credit**: We will credit you in the security advisory (unless you prefer to remain anonymous)

### Security Update Process

1. The security report is received and assigned to a maintainer
2. The problem is confirmed and affected versions are determined
3. Code is audited to find any similar problems
4. Fixes are prepared for all supported versions
5. New versions are released and announcements are made

## Security Best Practices

When using our Helm charts:

### 1. Keep Charts Updated

Always use the latest chart versions to ensure you have the latest security patches:

```bash
helm repo update
helm upgrade <release-name> codefuturist/<chart-name>
```

### 2. Review Values Before Deployment

- Never commit sensitive data (passwords, tokens, keys) to values files
- Use Kubernetes Secrets or external secret management tools
- Review all exposed services and ingress configurations

### 3. Use Image Digests

When possible, specify image digests instead of tags for immutability:

```yaml
image:
  repository: myapp
  digest: sha256:abc123...
```

### 4. Enable Security Features

Configure security contexts, pod security policies/standards, and network policies:

```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 1000
  readOnlyRootFilesystem: true
```

### 5. Scan Images

Regularly scan container images for vulnerabilities using tools like:

- Trivy
- Clair
- Anchore

### 6. Network Policies

Enable network policies to restrict pod-to-pod communication:

```yaml
networkPolicy:
  enabled: true
```

### 7. RBAC

Use minimal RBAC permissions required for your application.

## Known Security Considerations

### Secrets Management

Our charts support multiple secret management approaches:

- Kubernetes native secrets
- Sealed Secrets
- External Secrets Operator
- Azure Key Vault CSI Driver

Choose the method appropriate for your security requirements.

### Service Exposure

By default, services are not exposed externally. When enabling ingress:

- Always use TLS/HTTPS
- Configure proper authentication
- Review ingress annotations for security implications

## Vulnerability Disclosure Timeline

- **Day 0**: Vulnerability reported
- **Day 1-7**: Maintainers assess and confirm the vulnerability
- **Day 7-14**: Fix is developed and tested
- **Day 14-21**: Fix is released and security advisory published
- **Day 21+**: Public disclosure (after users have time to update)

## Security Advisories

Published security advisories can be found at:

- GitHub Security Advisories: https://github.com/codefuturist/helm-charts/security/advisories
- Release Notes: https://github.com/codefuturist/helm-charts/releases

## Additional Resources

- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/)
- [Helm Security Best Practices](https://helm.sh/docs/topics/provenance/)
- [OWASP Kubernetes Security Cheat Sheet](https://cheatsheetseries.owasp.org/cheatsheets/Kubernetes_Security_Cheat_Sheet.html)

## Contact

For security-related questions or concerns, contact: hello@allcloud.trade

---

Thank you for helping keep our Helm charts and users secure!
