# Basic Usage Examples

This document provides practical examples of how to use the skill-driven workflows (git, pr, k8s, plan) in real development scenarios. Behavior is implemented by Agent Skills in `.cursor/skills/`.

## 🚀 Getting Started

Follow the [Quick Start guide](../../README.md#-quick-start) to set up .cursor, then test basic functionality:

```bash
# Check git status
/git-status

# Create a feature branch
/git-branch feature/example
```

## 📝 Git Workflow Examples

### Feature Development

**Scenario**: Adding a new authentication feature

```bash
# 1. Create feature branch
/git-branch feature/auth-jwt

# 2. Make changes and stage them
git add src/auth/jwt.js

# 3. Commit with conventional format
/commit

# 4. Create pull request
/pr
```

### Bug Fix Workflow

**Scenario**: Fixing a login bug

```bash
# 1. Create fix branch
/git-branch fix/login-bug

# 2. Make changes
git add src/auth/login.js

# 3. Commit
/commit

# 4. Create PR
/pr
```

## 🔧 Kubernetes Examples

### Safe Resource Inspection

```bash
# Check pods
/k8s-check pods

# Validate manifests
/k8s-validate deployment.yaml

# Show differences
/k8s-diff deployment.yaml
```

## 📋 Planning Examples

### Project Planning

```bash
# Create project plan
/plan "Implement user authentication system"

# Check workspace status
/workspace-status
```

## 🎯 PR Management

### Complete PR Workflow

```bash
# Create PR
/pr

# Validate PR
/pr check

# Mark ready for review
/pr ready
```

## 💡 Tips and Best Practices

- Always use feature branches for new work
- Use conventional commit format
- Validate changes before committing
- Use safe commands for Kubernetes operations
- Plan your work before starting
