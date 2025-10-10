# Kubernetes Check Command

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
