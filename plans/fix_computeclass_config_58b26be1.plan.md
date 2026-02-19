---
name: Fix ComputeClass Config
overview: Add n1 machine family and Linux sysctls to the default ComputeClass for consistency with existing nodepools.
todos:
  - id: update-computeclass
    content: Update stg-1-default-computeclass.yaml with n1 priority and nodeSystemConfig sysctls
    status: completed
---

# Fix ComputeClass Configuration for stg-1

## Problems Identified

1. **Missing n1 machine family**: The GPU nodepool uses `n1-standard-16` but n1 is not in ComputeClass priorities
2. **Missing Linux sysctls**: Auto-provisioned nodepools would lack the kernel tuning from existing nodepools

## Solution

Update [stg-1-default-computeclass.yaml](resources-provisioning/clusters-config/stg-1/auto-provisioning/stg-1-default-computeclass.yaml):

```yaml
apiVersion: cloud.google.com/v1
kind: ComputeClass
metadata:
  name: default
spec:
  priorities:
    - machineFamily: n4
    - machineFamily: n2
    - machineFamily: n1
  nodePoolAutoCreation:
    enabled: true
  nodePoolConfig:
    serviceAccount: gke-nodepool@infinitepay-staging.iam.gserviceaccount.com
  nodeSystemConfig:
    linuxNodeConfig:
      sysctls:
        net.core.somaxconn: "2048"
        net.ipv4.tcp_tw_reuse: "1"
        net.core.netdev_max_backlog: "1000"
        net.core.rmem_max: "16777216"
        net.core.wmem_max: "16777216"
        net.ipv4.tcp_rmem: "4096 12582912 16777216"
        net.ipv4.tcp_wmem: "4096 12582912 16777216"
        vm.max_map_count: "262144"
```

## Changes Summary

- **n1 added to priorities**: Required for T4 GPU support (GPUs only available on n1/a2/g2 families)
- **nodeSystemConfig.linuxNodeConfig.sysctls**: Matches the sysctls from [nodepool.tf](terraform-modules/project/nodepool/nodepool.tf) lines 93-107

## Priority Order Rationale

- **n4 first**: Newest generation, best price/performance for general workloads
- **n2 second**: Current standard for existing nodepools
- **n1 third**: Legacy generation, needed for GPU nodepool compatibility

## Post-Change Verification

After ArgoCD syncs the change:

```bash
kubectl get computeclass/default -o yaml
```

Expected: `status.conditions` should show `type: Health` with `status: "True"`
