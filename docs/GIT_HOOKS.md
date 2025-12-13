# Git Hooks - Developer Guide

Comprehensive guide to RSR's git hooks system with developer-friendly features.

## Quick Start

```bash
# Install hooks
make setup-hooks

# Or manually
npm install  # Installs husky
husky install
pre-commit install

# Test hooks without committing
pre-commit run --all-files
```

## Overview

RSR uses two complementary hook systems:

1. **Husky** - Fast, focused checks on specific files
2. **pre-commit** - Comprehensive checks with auto-fix

Both systems are designed to be **developer-friendly**:
- ✅ Non-blocking warnings (errors only for critical issues)
- ✅ Generous timeouts (30-120 seconds)
- ✅ Auto-fix where possible
- ✅ Easy to skip when needed
- ✅ Clear, helpful output

---

## Husky Hooks

Located in `.husky/` directory. Fast, shell-based hooks.

### pre-commit

**Runs:** Before each commit
**Duration:** ~5-15 seconds (with generous timeouts)
**Can fail:** Yes (for critical errors only)

**Checks:**

| Check | Type | Auto-Fix | Blocking |
|-------|------|----------|----------|
| Registry sync | Critical | No | ✅ Yes |
| Shell syntax | Critical | No | ✅ Yes |
| PowerShell syntax | Warning | No | ❌ No |
| JSON validation | Warning | No | ❌ No |
| YAML validation | Warning | No | ❌ No |
| Trailing whitespace | Auto-fix | ✅ Yes | ❌ No |
| Large files | Warning | No | ❌ No |
| Debug code | Warning | No | ❌ No |

**Skip this hook:**
```bash
git commit --no-verify
# or
HUSKY=0 git commit
```

**Example output:**
```
🔍 Running pre-commit checks...

📋 Checking registry.json sync...
✅ Registry is in sync

🐚 Checking shell script syntax...
✅ All shell scripts have valid syntax

💻 Checking PowerShell script syntax...
✅ All PowerShell scripts have valid syntax

📄 Validating JSON files...
✅ All JSON files are valid

═══════════════════════════════════════════════════════════
✅ All pre-commit checks passed!
═══════════════════════════════════════════════════════════
```

### commit-msg

**Runs:** After commit message is entered
**Duration:** <1 second
**Can fail:** No (warnings only)

**Checks:**
- ✅ Conventional Commits format (warning)
- ✅ Message length (warning)
- ✅ WIP commit detection (warning)
- ✅ Issue reference detection (info)

**Skip this hook:**
```bash
git commit --no-verify
```

**Example output:**
```
📝 Validating commit message...

⚠️  Commit message doesn't follow Conventional Commits format

   Recommended format:
   <type>(<scope>): <subject>

   Example:
   feat(ssh): add key management

   ℹ️  This is just a suggestion - commit will proceed

✅ Commit message validation complete
```

### pre-push

**Runs:** Before push to remote
**Duration:** ~30-120 seconds (with timeouts)
**Can fail:** No (interactive confirmation)

**Checks:**

| Check | Timeout | Blocking |
|-------|---------|----------|
| Tests | 120s | ❌ No (asks) |
| Linters | 60s | ❌ No (asks) |
| Build | 60s | ❌ No (asks) |
| Dependencies | N/A | ℹ️ Info only |

**Features:**
- Runs tests if available
- Runs linters
- Tests build
- Checks dependencies
- **Interactive confirmation** if warnings found

**Skip this hook:**
```bash
git push --no-verify
```

**Example output:**
```
🚀 Running pre-push checks...

ℹ️  Pushing to protected branch: main
   Make sure you have permission to push directly

📊 Pushing 3 commit(s) to origin/main

🧪 Running tests (timeout: 120s)...
✅ Tests passed

🔍 Running linters (timeout: 60s)...
✅ Linters passed

═══════════════════════════════════════════════════════════
✅ Pre-push checks complete - proceeding with push
═══════════════════════════════════════════════════════════
```

### post-merge

**Runs:** After successful merge
**Duration:** <1 second
**Can fail:** No (informational only)

**Detects changes in:**
- 📦 Package dependencies (package.json, etc.)
- 🗄️ Database migrations
- ⚙️ Configuration files
- 🐳 Docker files
- 🪝 Git hooks
- 🔄 CI/CD config
- 📋 Schema/models

**Example output:**
```
🔄 Post-merge checks...

📦 Dependencies changed!
   Run: npm install

⚙️  Configuration files changed!
   Review and update your local config files

═══════════════════════════════════════════════════════════
ℹ️  Review the changes above and take necessary actions
═══════════════════════════════════════════════════════════
```

---

## Pre-commit Framework

Located in `.pre-commit-config.yaml`. Comprehensive checks with auto-fix.

### Configured Hooks

| Hook | Purpose | Auto-Fix | Speed |
|------|---------|----------|-------|
| trailing-whitespace | Remove trailing spaces | ✅ | Fast |
| end-of-file-fixer | Ensure newline at EOF | ✅ | Fast |
| check-yaml | Validate YAML syntax | ❌ | Fast |
| check-json | Validate JSON syntax | ❌ | Fast |
| check-large-files | Prevent >512KB files | ❌ | Fast |
| check-merge-conflict | Detect merge markers | ❌ | Fast |
| mixed-line-ending | Fix line endings | ✅ | Fast |
| shellcheck | Lint shell scripts | ❌ | Medium |
| shfmt | Format shell scripts | ✅ | Fast |
| detect-secrets | Scan for secrets | ❌ | Medium |
| markdownlint | Lint/fix Markdown | ✅ | Fast |
| yamllint | Lint YAML files | ❌ | Fast |

### Running Pre-commit

```bash
# Run all hooks on all files
pre-commit run --all-files

# Run all hooks on staged files only
pre-commit run

# Run specific hook
pre-commit run shellcheck --all-files

# Skip specific hooks
SKIP=shellcheck git commit

# Skip all pre-commit hooks (still runs husky)
git commit --no-verify
```

### Auto-Fix Flow

```bash
# 1. Stage your changes
git add .

# 2. Commit (triggers pre-commit)
git commit -m "feat: add feature"

# 3. Pre-commit auto-fixes issues
# Files are automatically modified and re-staged

# 4. If auto-fix made changes:
#    Commit will fail, asking you to review
#    Just commit again - fixes are already staged

# 5. Commit again
git commit -m "feat: add feature"
```

---

## Timeout Configuration

All hooks have generous timeouts to prevent hanging:

| Hook Type | Default Timeout | Adjustable |
|-----------|----------------|------------|
| Husky pre-commit | 30s per check | Yes |
| Husky pre-push | 120s total | Yes |
| Husky commit-msg | 5s | Yes |
| Pre-commit hooks | Per-hook basis | Yes |

### Adjusting Timeouts

**Husky hooks** - Edit `.husky/<hook-name>`:
```bash
# Change this line
TIMEOUT_SECONDS=30

# To
TIMEOUT_SECONDS=60
```

**Pre-commit** - No built-in timeout, but checks are fast

---

## Developer Workflows

### Fast Development (Skip Hooks)

```bash
# Skip all hooks for rapid iteration
export HUSKY=0

# Make changes
git add .
git commit -m "WIP: testing"
git push --no-verify

# Re-enable hooks when ready
unset HUSKY

# Clean up WIP commits
git rebase -i HEAD~3
```

### Pre-flight Check

Before submitting PR:

```bash
# Run everything locally
make lint
make test
pre-commit run --all-files

# Commit with full checks
git commit -m "feat: final version"

# Push with checks
git push
```

### Fixing Hook Failures

**Registry sync failed:**
```bash
make build-registry
git add rsr scripts/registry.json
git commit --amend --no-edit
```

**Shell syntax error:**
```bash
bash -n scripts/problematic.sh  # Find error
# Fix the syntax error
git add scripts/problematic.sh
git commit --amend --no-edit
```

**Tests failed:**
```bash
make test  # Run tests locally
# Fix failing tests
git add .
git commit --amend --no-edit
```

**Linters failed:**
```bash
make lint-fix  # Auto-fix
make format    # Format code
git add .
git commit --amend --no-edit
```

---

## Skipping Hooks

### When to Skip

✅ **OK to skip:**
- WIP commits on feature branch
- Emergency hotfixes
- Merge commits
- Reverts
- When hooks are broken

❌ **Don't skip:**
- Final commits before PR
- Commits to main/master
- Release commits
- Shared branches

### How to Skip

**Skip specific hook (pre-commit framework):**
```bash
SKIP=shellcheck git commit -m "commit"
SKIP=shellcheck,yamllint git commit -m "commit"
```

**Skip all pre-commit hooks:**
```bash
git commit --no-verify
```

**Skip all husky hooks:**
```bash
HUSKY=0 git commit
HUSKY=0 git push
```

**Disable hooks temporarily:**
```bash
# Disable
mv .git/hooks/pre-commit .git/hooks/pre-commit.disabled

# Re-enable
mv .git/hooks/pre-commit.disabled .git/hooks/pre-commit
```

---

## Troubleshooting

### "Hook timed out"

**Cause:** Check exceeded timeout limit
**Solution:**
1. Increase timeout in `.husky/<hook-name>`
2. Or skip with `--no-verify`

### "Hook failed but I can't see why"

**Cause:** Output may be truncated
**Solution:**
```bash
# Run hook manually to see full output
bash .husky/pre-commit

# Or run individual checks
make lint
make test
pre-commit run --all-files
```

### "Hooks not running"

**Cause:** Hooks not installed
**Solution:**
```bash
make setup-hooks
# or
husky install
pre-commit install
```

### "Permission denied"

**Cause:** Hooks not executable
**Solution:**
```bash
chmod +x .husky/*
```

### "Registry always out of sync"

**Cause:** Circular dependency in build process
**Solution:**
```bash
# Build registry
make build-registry

# Add generated files
git add rsr scripts/registry.json

# Commit without hook check
git commit --no-verify -m "fix: update registry"
```

---

## Configuration Files

| File | Purpose |
|------|---------|
| `.husky/pre-commit` | Fast pre-commit checks |
| `.husky/commit-msg` | Commit message validation |
| `.husky/pre-push` | Pre-push tests & lints |
| `.husky/post-merge` | Post-merge notifications |
| `.pre-commit-config.yaml` | Pre-commit framework config |
| `package.json` | Husky installation config |

---

## Best Practices

1. **Run hooks locally before pushing**
   ```bash
   pre-commit run --all-files
   ```

2. **Keep commits small**
   - Hooks run faster on fewer files
   - Easier to fix issues

3. **Fix auto-fixable issues**
   ```bash
   make lint-fix
   make format
   ```

4. **Use WIP commits on feature branches**
   ```bash
   git commit --no-verify -m "WIP: testing"
   # Squash before merging
   ```

5. **Test changes before committing**
   ```bash
   make lint
   make test
   ```

6. **Review hook output**
   - Warnings are informational
   - Errors must be fixed

---

## Summary

✅ **Husky hooks**: Fast, file-specific checks
✅ **Pre-commit hooks**: Comprehensive auto-fix
✅ **Generous timeouts**: 30-120 seconds
✅ **Non-blocking warnings**: Keep developing
✅ **Easy to skip**: `--no-verify` when needed
✅ **Developer-friendly**: Clear output, helpful errors

**All hooks are designed to help, not hinder development!**
