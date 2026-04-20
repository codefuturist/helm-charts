# Proton Pass Chart Copier Template

Generate a Helm chart pre-configured with **Proton Pass** ExternalSecrets using [Copier](https://copier.readthedocs.io/).

## Usage

```bash
# Generate a new chart
copier copy templates/protonpass-chart-copier charts/apps/my-app

# Update when template evolves
copier update charts/apps/my-app
```

## What It Generates

- `Chart.yaml` — chart metadata with common library dependency
- `values.yaml` — values with external secret configuration
- `templates/externalsecret.yaml` — ExternalSecret pointing to Proton Pass
- `templates/deployment.yaml` — Deployment referencing the generated secret

## Secrets Format

When prompted for secrets, provide comma-separated `ENV_VAR:item/field` pairs:

```
DB_PASSWORD:MyApp Database/password,API_KEY:API Keys/myapp,REDIS_PASS:Redis/password
```

Each pair maps an environment variable to a Proton Pass vault item and field.
