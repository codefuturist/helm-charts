# Contributing to Helm Charts

Thank you for your interest in contributing to our Helm charts! This document provides guidelines and instructions for contributing.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Chart Guidelines](#chart-guidelines)
- [Pull Request Process](#pull-request-process)
- [Release Process](#release-process)

## Code of Conduct

We are committed to providing a welcoming and inspiring community for all. Please be respectful and constructive in your interactions.

## How to Contribute

### Reporting Bugs

If you find a bug, please create an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- Chart version and Kubernetes version
- Relevant logs or error messages

### Suggesting Enhancements

Enhancement suggestions are welcome! Please create an issue describing:
- The enhancement you'd like to see
- Why it would be useful
- Any implementation ideas you have

### Contributing Code

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test your changes thoroughly
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Setup

### Prerequisites

- [Helm](https://helm.sh/docs/intro/install/) v3.8+
- [helm-docs](https://github.com/norwoodj/helm-docs) (for documentation generation)
- [chart-testing](https://github.com/helm/chart-testing) (for linting and testing)
- [yamllint](https://github.com/adrienverge/yamllint) (for YAML linting)
- [pre-commit](https://pre-commit.com/) (optional, but recommended)

### Install Development Tools

```bash
# Install helm-docs
brew install norwoodj/tap/helm-docs

# Install chart-testing
brew install chart-testing

# Install yamllint
pip install yamllint

# Install pre-commit hooks (optional)
make install-hooks
```

### Testing Locally

```bash
# Lint all charts
ct lint --config ct.yaml --all

# Test a specific chart
helm lint charts/application

# Template and validate
helm template test charts/application --values charts/application/values.yaml

# Install in a test cluster
helm install test-release charts/application --dry-run --debug
```

## Chart Guidelines

### Chart Structure

Each chart should follow this structure:

```
charts/
└── chart-name/
    ├── Chart.yaml          # Chart metadata
    ├── values.yaml         # Default values
    ├── values-test.yaml    # Test values for CI
    ├── README.md           # Auto-generated documentation
    ├── README.md.gotmpl    # Template for README generation
    ├── .helmignore         # Files to ignore when packaging
    ├── templates/          # Kubernetes manifests
    │   ├── _helpers.tpl    # Template helpers
    │   └── *.yaml          # Resource templates
    └── tests/              # Helm test files
        └── *_test.yaml
```

### Chart.yaml Requirements

- Use semantic versioning (MAJOR.MINOR.PATCH)
- Increment version for every change
- Include meaningful description
- Add relevant keywords
- Specify maintainers
- Include home URL and sources

### values.yaml Best Practices

- Use clear, descriptive names
- Group related settings
- Include comments explaining each value
- Provide sensible defaults
- Document all required values

### Template Best Practices

- Use `_helpers.tpl` for reusable template snippets
- Include resource limits and requests
- Support common configurations (labels, annotations, nodeSelector, etc.)
- Use conditional rendering for optional resources
- Follow Kubernetes API conventions

### Documentation

- Use `helm-docs` to auto-generate README from values.yaml comments
- Keep README.md.gotmpl up to date with chart features
- Document breaking changes in CHANGELOG.md
- Include examples in documentation

### Testing

- Include unit tests in `tests/` directory
- Add `values-test.yaml` for CI testing
- Test upgrades from previous versions
- Verify all templates render correctly

## Pull Request Process

1. **Update Documentation**: Ensure README.md is regenerated with `helm-docs`
2. **Version Bump**: Increment chart version in `Chart.yaml`
3. **Update Changelog**: Add entry to chart's CHANGELOG.md (if it exists)
4. **Pass CI Checks**: Ensure all linting and tests pass
5. **Clear Description**: Explain what changed and why
6. **Link Issues**: Reference any related issues

### PR Title Format

Use conventional commits format:
- `feat(chart-name): add new feature`
- `fix(chart-name): resolve bug`
- `docs(chart-name): update documentation`
- `chore(chart-name): maintenance task`

### Review Process

- At least one maintainer review is required
- Address all comments before merging
- Squash commits when merging (if requested)

## Release Process

Releases are automated via GitHub Actions:

1. Merge PR to `main` or `develop` branch
2. CI will lint and test the charts
3. If version changed, chart-releaser will:
   - Package the chart
   - Create GitHub release
   - Update GitHub Pages with new index
   - Publish to chart repository

### Manual Release (if needed)

```bash
# Package chart
helm package charts/chart-name

# Update index
helm repo index . --url https://codefuturist.github.io/helm-charts

# Commit and push to gh-pages branch
```

## Questions?

If you have questions, feel free to:
- Open an issue
- Reach out to maintainers
- Check existing documentation

Thank you for contributing! 🎉
