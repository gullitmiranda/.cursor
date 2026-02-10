---
name: k8s
description: Safe Kubernetes operations - check resources (read-only), validate manifests (dry-run), and diff changes. Use when inspecting pods/deployments, validating YAML, or previewing apply changes. Never run kubectl delete or apply.
---
# /k8s-check

## Description

Safely check Kubernetes resources without applying changes.

## Workflow

1. Use `kubectl get` and `kubectl describe` to inspect resources
2. Show current state of relevant resources
3. Identify potential issues or conflicts
4. Provide read-only analysis and recommendations
5. Never execute destructive operations

## Safe Commands Used

- `kubectl get <resource>`
- `kubectl describe <resource>`
- `kubectl logs <pod>`
- `kubectl explain <resource>`

## Examples

```bash
# Check all pods
/k8s-check pods

# Check specific namespace
/k8s-check pods -n production

# Check deployments
/k8s-check deployments

# Check services
/k8s-check services

# Check resource usage
/k8s-check top pods
```

## Resource Types

- Pods
- Deployments
- Services
- ConfigMaps
- Secrets
- Ingress
- PersistentVolumes
- Nodes

## Safety Features

- Read-only operations only
- No destructive commands
- Clear resource identification
- Conflict detection
- Resource dependency analysis

## Output Format

```
Resource: pods
Namespace: default
Status: Running (3/3)

POD_NAME                    READY   STATUS    RESTARTS   AGE
app-pod-12345              1/1     Running   0          2h
db-pod-67890               1/1     Running   0          2h
cache-pod-11111            1/1     Running   0          2h

Issues Found:
- No issues detected

Recommendations:
- All pods are healthy
- Consider resource limits optimization
```

## Integration

- Works with kubectl context
- Integrates with monitoring tools
- Supports multiple namespaces
- Compatible with CI/CD pipelines

---

# /k8s-validate

## Description

Validate Kubernetes manifests without applying them.

## Workflow

1. Use `kubectl apply --dry-run=client` to validate syntax
2. Use `kubectl apply --dry-run=server` to validate against cluster
3. Check for resource conflicts and dependencies
4. Validate YAML/JSON syntax and structure
5. Provide detailed validation report with recommendations

## Validation Steps

- Syntax validation
- Schema validation
- Resource conflict detection
- Security policy compliance
- Best practices check

## Examples

```bash
# Validate single manifest
/k8s-validate deployment.yaml

# Validate multiple manifests
/k8s-validate *.yaml

# Validate with server-side validation
/k8s-validate --server deployment.yaml

# Validate specific namespace
/k8s-validate -n production deployment.yaml
```

## Validation Types

- **Client-side**: Local syntax and schema validation
- **Server-side**: Cluster-specific validation
- **Security**: Security policy compliance
- **Best Practices**: Kubernetes best practices

## Output Format

```
Validation Report: deployment.yaml
Status: ✅ VALID

Client-side validation: ✅ PASSED
- YAML syntax: ✅ Valid
- Schema validation: ✅ Valid
- Resource references: ✅ Valid

Server-side validation: ✅ PASSED
- Cluster compatibility: ✅ Compatible
- Resource quotas: ✅ Within limits
- Security policies: ✅ Compliant

Best Practices: ⚠️ WARNINGS
- Missing resource limits: Consider adding CPU/memory limits
- Missing readiness probe: Consider adding readiness probe

Recommendations:
- Add resource limits for better resource management
- Implement health checks for better monitoring
```

## Safety Features

- No changes applied to cluster
- Comprehensive validation coverage
- Clear error reporting
- Best practices recommendations

## Integration

- Works with kubectl context
- Integrates with CI/CD pipelines
- Supports multiple manifest formats
- Compatible with GitOps workflows

---

# /k8s-diff

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
