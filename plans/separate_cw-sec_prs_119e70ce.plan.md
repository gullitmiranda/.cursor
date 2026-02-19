---
name: Separate cw-sec PRs
overview: "Split the current PR into two: first create the GCP project and state bucket, then deploy the remaining resources after the bucket exists."
todos:
  - id: create-linear-issue
    content: Create Linear issue to track cw-sec PR separation
    status: pending
  - id: create-bootstrap-branch
    content: Create feat/cw-sec-project-bootstrap branch from main with project folder only
    status: pending
    dependencies:
      - create-linear-issue
  - id: create-bootstrap-pr
    content: Open PR for bootstrap configuration and get it applied
    status: pending
    dependencies:
      - create-bootstrap-branch
  - id: update-resources-pr
    content: Rebase and update the resources PR after bootstrap is merged
    status: pending
    dependencies:
      - create-bootstrap-pr
---

# Separate cw-sec Project Bootstrap from Resources

## Problem

Atlantis cannot execute plans for `iam`, `networking`, `clouddns`, and `gke` because they depend on the bucket `terraform-state-cw-sec` which is created by the `project` terraform configuration. All 7 projects are in the same PR, creating a chicken-and-egg problem.

```mermaid
flowchart LR
    subgraph PR1 [PR 1 - Bootstrap]
        Project[project/]
    end

    subgraph PR2 [PR 2 - Resources]
        IAM[iam/]
        Network[networking/]
        DNS[clouddns/]
        GKE[gke/]
    end

    Project -->|creates| Bucket[(terraform-state-cw-sec)]
    Bucket -->|used by| IAM
    Bucket -->|used by| Network
    Bucket -->|used by| DNS
    Bucket -->|used by| GKE
```

## Plan

### 1. Create Linear Issue

Create a new Linear issue to track this separation work, linking to the current PR #10126.

### 2. Create Bootstrap Branch

Create a new branch `feat/cw-sec-project-bootstrap` from `main` containing only the project folder changes:

- [terraform-projects/tf-cw-sec/project/](terraform/terraform-projects/tf-cw-sec/project/) (all files)
- [terraform-projects/tf-cw-sec/\_defaults/](terraform/terraform-projects/tf-cw-sec/_defaults/) (dependency)
- Atlantis config entry for `cw-sec-project` only

### 3. Create Bootstrap PR

Open PR with the bootstrap configuration. This PR will:

- Create the GCP project `cw-sec`
- Enable required APIs
- Create the state bucket `terraform-state-cw-sec`

### 4. Update Original PR

After bootstrap PR is merged and applied:

- Rebase `feat/cw-sec-project-setup` on latest `main`
- Remove the already-merged project folder changes
- The remaining resources (iam, networking, clouddns, gke) will now work since the bucket exists

## Files Involved

| PR | Folders ||----|---------|| Bootstrap PR | `_defaults/`, `project/` || Resources PR | `iam/`, `networking/`, `clouddns/`, `gke/` |

## Notes

- The `_defaults` module needs to be in both PRs since all configurations depend on it
