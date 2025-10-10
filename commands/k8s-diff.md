# Kubernetes Diff Command

## Description

Show differences between local manifests and cluster state.

## Workflow

1. Use `kubectl diff` to show changes that would be applied
2. Highlight critical changes (deletions, resource limits, security contexts)
3. Provide impact analysis of proposed changes
4. Show before/after comparison
5. Recommend safe application strategies

## Safety Features

- Never automatically apply changes
- Clearly highlight destructive operations
- Show resource dependencies
- Provide rollback strategies

## Examples

```bash
# Show diff for single manifest
/k8s-diff deployment.yaml

# Show diff for multiple manifests
/k8s-diff *.yaml

# Show diff with specific namespace
/k8s-diff -n production deployment.yaml

# Show diff with context
/k8s-diff --context=5 deployment.yaml
```

## Output Format

```
Diff Report: deployment.yaml
Resource: deployment/app-deployment
Namespace: default

Changes Detected:
- Image updated: app:v1.0.0 → app:v1.1.0
- Replicas changed: 3 → 5
- Resource limits added: CPU: 500m, Memory: 512Mi

Critical Changes:
⚠️  Replica count increase (3 → 5)
⚠️  Resource limits added (may affect scheduling)

Impact Analysis:
- Rolling update will be triggered
- 2 additional pods will be created
- Resource usage will increase
- No data loss expected

Recommendations:
- Monitor resource usage after deployment
- Consider gradual rollout
- Verify application health after update
```

## Change Categories

- **Safe**: Non-destructive changes
- **Warning**: Potentially impactful changes
- **Critical**: Destructive or high-impact changes

## Rollback Strategies

- Previous version restoration
- Resource scaling adjustments
- Configuration rollback
- Emergency procedures

## Integration

- Works with kubectl context
- Integrates with GitOps workflows
- Supports multiple manifest formats
- Compatible with CI/CD pipelines
