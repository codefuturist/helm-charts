# Local Kubernetes Development

Run a local Kubernetes cluster for chart development and testing using [k3d](https://k3d.io).

## Prerequisites

```bash
brew install k3d kubectl
```

Docker Desktop must be running.

## Workflow

```bash
# 1. Create cluster (~20 seconds)
just local-up

# 2. Test a specific chart
just test my-chart

# 3. Install-test all changed charts (chart-testing)
just local-ct-test

# 4. For operator-dependent charts, start Tilt
tilt up

# 5. Tear down when done
just local-down
```

## Available Commands

| Command | Description |
|---------|-------------|
| `just local-up` | Create k3d cluster (`helm-dev`) with ports 80/443 |
| `just local-down` | Delete the cluster |
| `just local-ct-test` | Run chart-testing install against all changed charts |

## Known Limitations

**`just local-ct-test` and `file://` dependencies:** `ct install` copies charts to a
temporary directory before running `helm dependency build`, which breaks the relative
`file://../../libs/common` dependency path used by all app charts. This is a
[known chart-testing limitation](https://github.com/helm/chart-testing/issues/101),
not a k3d issue.

Workarounds:
- Use `just ct-lint` (lint-only) — this works fine locally
- Test individual charts with `just test <chart>` instead of `ct install`
- CI uses `ct install --target-branch main` on changed charts only, which works
  because chart-testing resolves dependencies differently for targeted charts

## Notes

- The cluster name is `helm-dev` (kubectl context: `k3d-helm-dev`)
- Ports 80 and 443 are mapped to localhost via the k3d load balancer
- The existing `Tiltfile` works with k3d — just run `tilt up` after `just local-up`
- CI continues to use **kind** (via `helm/kind-action`) — no changes there
