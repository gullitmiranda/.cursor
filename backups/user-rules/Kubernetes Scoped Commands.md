# Kubernetes Scoped Commands

## /k8s-check

**Description**: Safely check Kubernetes resources without applying changes

**Workflow**:

1. Use `kubectl get` and `kubectl describe` to inspect resources
2. Show current state of relevant resources
3. Identify potential issues or conflicts
4. Provide read-only analysis and recommendations
5. Never execute destructive operations

**Safe commands used**:

- `kubectl get <resource>`
- `kubectl describe <resource>`
- `kubectl logs <pod>`
- `kubectl explain <resource>`

---

## /k8s-validate

**Description**: Validate Kubernetes manifests without applying them

**Workflow**:

1. Use `kubectl apply --dry-run=client` to validate syntax
2. Use `kubectl apply --dry-run=server` to validate against cluster
3. Check for resource conflicts and dependencies
4. Validate YAML/JSON syntax and structure
5. Provide detailed validation report with recommendations

**Validation steps**:

- Syntax validation
- Schema validation
- Resource conflict detection
- Security policy compliance
- Best practices check

---

## /k8s-diff

**Description**: Show differences between local manifests and cluster state

**Workflow**:

1. Use `kubectl diff` to show changes that would be applied
2. Highlight critical changes (deletions, resource limits, security contexts)
3. Provide impact analysis of proposed changes
4. Show before/after comparison
5. Recommend safe application strategies

**Safety features**:

- Never automatically apply changes
- Clearly highlight destructive operations
- Show resource dependencies
- Provide rollback strategies

**Blocked operations**:

- `kubectl delete` - Completely blocked by hooks
- `kubectl apply` - Completely blocked by hooks
- Any destructive operations that could affect running workloads

**Alternative workflows**:

- Use /k8s-check to inspect current state
- Use /k8s-validate to validate manifests
- Use /k8s-diff to preview changes
- Manual approval required for any apply operations
