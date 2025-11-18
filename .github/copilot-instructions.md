# GitHub Copilot Instructions: Git Flow Default Workflow

## Overview

This repository uses Git Flow as the default branching strategy. All development should follow Git Flow conventions. GitHub Copilot should suggest Git Flow commands and workflows by default.

## Prerequisites

- Git Flow must be installed: `brew install git-flow-avh` (macOS)
- Load Git Flow aliases: `source .zshrc_gitflow`
- Initialize in repo: `git flow init` (use defaults: main/develop)

## Default Branch Strategy

- **main**: Production-ready code only
- **develop**: Integration branch for features
- **feature/\***: Feature development branches
- **release/\***: Release preparation branches
- **hotfix/\***: Emergency production fixes

## Primary Git Flow Commands (Use These By Default)

### Feature Development (Most Common)

```shell
# Start feature
git flow feature start feature-name

# Finish feature (merges to develop)
git flow feature finish feature-name

# Publish feature for collaboration
git flow feature publish feature-name
```

### Release Process

```shell
# Start release
git flow release start v1.2.0

# Finish release (merges to main and develop, creates tag)
git flow release finish v1.2.0
```

### Hotfix Process

```shell
# Start hotfix
git flow hotfix start v1.2.1

# Finish hotfix (merges to main and develop, creates tag)
git flow hotfix finish v1.2.1
```

### Status and Information

```shell
git flow feature list    # List features
git flow release list    # List releases
git flow hotfix list     # List hotfixes
git branch               # Show all branches
```

## GitHub Copilot Default Behaviors

### When User Mentions Starting Work:

- **Always suggest**: `git flow feature start <feature-name>` instead of `git checkout -b`
- **Example**: "To start working on this feature, run: `git flow feature start user-authentication`"

### When User Mentions Finishing Work:

- **Always suggest**: `git flow feature finish <feature-name>` instead of `git merge`
- **Example**: "When ready to merge, run: `git flow feature finish user-authentication`"

### When User Mentions Releases:

- **Always suggest**: Git Flow release commands
- **Example**: "To prepare a release, run: `git flow release start v1.2.0`"

### When User Mentions Bug Fixes:

- **Distinguish between**:
  - Regular fixes: Use feature branches (`git flow feature start fix-bug-name`)
  - Production emergencies: Use hotfix branches (`git flow hotfix start v1.2.1`)

## Code Suggestions Priorities

### 1. Git Flow Commands (Highest Priority)

When suggesting Git commands, always prefer Git Flow commands:

- ✅ `git flow feature start new-feature`
- ❌ `git checkout -b feature/new-feature`

### 2. Makefile Commands for Building

When suggesting build, test, or development commands, always use Makefile targets:

- ✅ `make build`, `make test`, `make dev`
- ❌ `swift build`, `npm run build`, direct tooling commands

**Available Build Commands** (all logs stored in `log/` directory):

- `make build` - Build release version (with linting) → logs to `log/lint.log`
- `make build-debug` - Build debug version (faster, no optimizations) → logs to `log/build-debug.log`
- `make build-clean` - Clean only build artifacts (quick clean for rebuild)
- `make build-verbose` - Build with verbose output → logs to `log/build-verbose.log`
- `make release` - Build optimized release version → logs to `log/lint.log`
- `make dev` - Full development cycle (clean, build debug, run) → logs to `log/build-debug.log`
- `make clean` - Remove build artifacts (including log directory)
- `make clean-all` - Deep clean (build + dependencies)
- `make test` - Run all tests → logs to `log/test.log`
- `make lint` - Run linter (SwiftLint for Swift projects)
- `make install` - Install release binary to ~/.local/bin

### 3. Branch Naming Conventions

- Features: Short, descriptive names (`user-auth`, `payment-system`)
- Releases: Semantic versioning (`v1.2.0`, `v2.0.0-beta`)
- Hotfixes: Patch versions (`v1.2.1`, `v1.2.2`)

### 3. Workflow Reminders

Always remind users to:

1. Start from `develop` branch for features
2. Use semantic commit messages
3. Test before finishing branches
4. Review Git Flow status with `git flow feature list` or `git branch`

## Common Scenarios and Responses

### Scenario: "I want to add a new feature"

**Copilot Response:**

```shell
# Start a new feature branch
git flow feature start your-feature-name

# Make your changes and commit
git add .
git commit -m "feat: implement your feature"

# When ready, finish the feature
git flow feature finish your-feature-name
```

### Scenario: "I need to fix a bug"

**Copilot Response:**

```shell
# For regular bug fixes (not production emergency)
git flow feature start fix-bug-description

# For production emergencies
git flow hotfix start v1.2.1  # Use next patch version
```

### Scenario: "How do I prepare a release?"

**Copilot Response:**

```shell
# Start release preparation
git flow release start v1.2.0

# Make release-specific changes (version bumps, changelog)
git add .
git commit -m "chore: prepare release v1.2.0"

# Finish release (creates tag and merges)
git flow release finish v1.2.0
```

## Integration with Development Tools

### VS Code Integration

- When suggesting terminal commands, prioritize Git Flow commands
- When showing Git branch operations, explain Git Flow context
- Reference documentation files for detailed explanations

### Documentation References

- Point to `QUICKSTART.md` for workflows
- Reference `Git Flow.md` for detailed explanations
- Use diagrams in `diagrams/` folder when explaining flows

## Error Prevention

### Always Check:

1. Current branch before suggesting commands
2. Whether Git Flow is initialized (`git flow init`)
3. Whether user is working from correct base branch

### Never Suggest:

- Direct merges to `main` branch
- Creating branches without Git Flow prefixes
- Bypassing Git Flow finish commands

## Quick Reference for Copilot

| Task           | Command                   |
| -------------- | ------------------------- |
| Start feature  | `git flow feature start`  |
| Finish feature | `git flow feature finish` |
| Start release  | `git flow release start`  |
| Finish release | `git flow release finish` |
| Start hotfix   | `git flow hotfix start`   |
| Finish hotfix  | `git flow hotfix finish`  |
| List features  | `git flow feature list`   |

---

**Remember**: Git Flow is the default and preferred workflow. Always suggest Git Flow commands over standard Git branching operations unless explicitly requested otherwise.

## Constraints

- **DO NOT create any kind of documentation files unless specifically asked to** after completing the primary task, including but not limited
  to:
  - Summary documents (e.g., `*_SUMMARY.md`, `*_REPORT.md`)
  - Implementation guides (e.g., `*_GUIDE.md`, `*_IMPLEMENTATION.md`)
  - Cleanup reports (e.g., `CLEANUP_*.md`, `FINAL_*.md`)
  - Status or completion documents (e.g., `*_STATUS.md`, `*_COMPLETE.md`)
  - Meta-documentation about the work performed
  - Any `.md` files not explicitly requested by the user
- **DO clean up temporary files** after successfully solving the problem, including but not limited to:
  - Temporary test files (e.g., `*_working.py`, `*_temp.py`, `*_debug.py`)
  - Debug/development artifacts (e.g., `test_*.log`, coverage reports, `.coverage` files)
  - Cache directories (e.g., `__pycache__/`, `.pytest_cache/`, `htmlcov/`)
  - Backup files (e.g., `*.bak`, `*~`, `*.orig`)
  - Any files with temporary naming patterns that are not part of the final solution
