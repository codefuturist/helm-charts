# Migrating to Proton Pass from Other Secret Providers

This guide helps teams migrate from existing secret management solutions to Proton Pass.

## From Bitwarden (ESO Provider)

The Proton Pass ESO Provider follows the same webhook pattern as the existing Bitwarden provider, making migration straightforward.

### Key Differences

| Aspect            | Bitwarden          | Proton Pass             |
| ----------------- | ------------------ | ----------------------- |
| Secret reference  | `itemId` + `field` | Item title + field name |
| Vault model       | Collections        | Vaults                  |
| CLI tool          | `bw`               | `pass-cli`              |
| Auth method       | API key + password | Username + password     |
| Secret store name | `bitwarden`        | `protonpass`            |

### Migration Steps

1. **Create equivalent items in Proton Pass**
   - For each Bitwarden item, create a matching Proton Pass item
   - Use the same field names where possible

2. **Update ExternalSecret resources**

   ```yaml
   # Before (Bitwarden)
   secretStoreRef:
     name: bitwarden
     kind: ClusterSecretStore
   data:
     - secretKey: DB_PASS
       remoteRef:
         key: "abc-123-def"        # Bitwarden item ID
         property: "password"

   # After (Proton Pass)
   secretStoreRef:
     name: protonpass
     kind: ClusterSecretStore
   data:
     - secretKey: DB_PASS
       remoteRef:
         key: "MyApp Database"     # Human-readable item title
         property: "password"
   ```

3. **Deploy both providers in parallel** during migration
4. **Switch ExternalSecrets one by one**, verifying each
5. **Decommission Bitwarden provider** when fully migrated

### Advantages Over Bitwarden

- **Human-readable references** — item titles instead of UUIDs
- **Vault-level access control** — restrict by vault name
- **Built-in CLI tooling** — `pass-cli` is maintained by Proton
- **Profile system** — declarative env → secret mappings

## From SOPS-Encrypted Secrets

If you're currently encrypting secrets directly with SOPS:

### Migration Steps

1. **Identify secrets to migrate**

   ```bash
   # Find all SOPS-encrypted secrets
   grep -r "sops:" --include="*.yaml" -l
   ```

2. **Create matching Proton Pass items** for each secret
3. **Replace static secrets with ExternalSecrets**

   ```yaml
   # Before: SOPS-encrypted secret.yaml
   apiVersion: v1
   kind: Secret
   metadata:
     name: my-secret
   stringData:
     password: ENC[AES256_GCM,...]

   # After: ExternalSecret
   apiVersion: external-secrets.io/v1
   kind: ExternalSecret
   metadata:
     name: my-secret
   spec:
     secretStoreRef:
       name: protonpass
       kind: ClusterSecretStore
     data:
       - secretKey: password
         remoteRef:
           key: "My Secret Item"
           property: "password"
   ```

4. **Remove SOPS-encrypted files** from the repository

### When to Keep SOPS

SOPS is still useful for:

- Non-secret configuration that needs encryption
- Secrets that must be in-repo for GitOps
- Environments without External Secrets Operator

## From Environment Variables / .env Files

For teams currently managing `.env` files manually:

1. **Create a Proton Pass vault** for the project
2. **Add each secret** as a Proton Pass item
3. **Create a profile** mapping env vars to vault items:
   ```bash
   just protonpass-profile-create myapp-dev
   ```
4. **Replace manual .env management**:
   ```bash
   # Before: manually editing .env files
   # After:
   just protonpass-env myapp-dev
   ```

## Validation Checklist

After migration, verify:

- [ ] All ExternalSecrets show `SecretSynced` status
- [ ] Application pods start successfully with new secrets
- [ ] Secret rotation works via Proton Pass → auto-refresh
- [ ] Local development workflow works with `just protonpass-env`
- [ ] CI/CD pipelines can access secrets (if applicable)
