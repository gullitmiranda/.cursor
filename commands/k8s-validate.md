# Kubernetes Validate Command

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
