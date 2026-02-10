# Complete Development Cycle Workflow

This document demonstrates a complete development cycle using Cursor skills (git, pr, plan, k8s, workspace-status), from initial setup to production deployment. The workflows below are implemented by Agent Skills in `.cursor/skills/`.

## 🚀 Scenario: Adding User Authentication Feature

Let's walk through a complete development cycle for adding a user authentication feature to a web application.

### Phase 1: Project Setup and Planning

**1.1 Initial Repository Setup**

```bash
# Clone the repository
git clone https://github.com/yourorg/yourproject.git
cd yourproject

# Set up .cursor (see Quick Start guide)
# Follow: https://github.com/gullitmiranda/.cursor#-quick-start

# Verify setup
/git-status
```

**1.2 Feature Planning**

```bash
# Create project plan
/plan "Add user authentication system"

# Check workspace status
/workspace-status
```

### Phase 2: Development

**2.1 Create Feature Branch**

```bash
# Create feature branch
/git-branch feature/user-authentication

# Verify branch creation
/git-status
```

**2.2 Implement Feature**

```bash
# Make changes to code
# ... implement authentication logic ...

# Stage changes
git add src/auth/

# Commit with conventional format
/commit
```

### Phase 3: Testing and Validation

**3.1 Run Tests**

```bash
# Run project tests
npm test

# Check code quality
npm run lint
```

**3.2 Kubernetes Validation (if applicable)**

```bash
# Validate Kubernetes manifests
/k8s-validate k8s/auth-deployment.yaml

# Check current state
/k8s-check pods
```

### Phase 4: Pull Request

**4.1 Create Pull Request**

```bash
# Create PR
/pr
```

**4.2 Validate PR**

```bash
# Check PR quality
/pr check

# Mark ready for review
/pr ready
```

### Phase 5: Review and Merge

**5.1 Address Review Feedback**

```bash
# Make requested changes
git add .
/commit

# Update PR
git push origin feature/user-authentication
```

**5.2 Final Validation**

```bash
# Final PR check
/pr check

# Confirm ready for merge
/pr ready
```

## 🎯 Key Benefits

- **Consistent Workflow**: Standardized process for all features
- **Safety First**: Hooks prevent dangerous operations
- **Quality Gates**: Automated validation at each step
- **Documentation**: Clear tracking of changes and decisions
- **Integration**: Seamless Linear and GitHub integration

## 💡 Best Practices

- Always use feature branches
- Follow conventional commit format
- Validate changes before committing
- Use safe commands for operations
- Document your work
- Test thoroughly before PR
