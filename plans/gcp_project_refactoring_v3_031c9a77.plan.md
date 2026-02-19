---
name: GCP Project Refactoring v3
overview: Refatorar estrutura de projetos GCP criando modulos gcp-project-config (schema/validacoes), gcp-project-state (remote state), gcp-project-gke (preparacao GKE), e implementar infinitepay-treasury como primeiro projeto no novo padrao.
todos:
  - id: linear-parent-issue
    content: "Create Linear parent issue: feat(terraform): GCP Project Structure Refactoring"
    status: pending
  - id: linear-sub-config
    content: "Create sub-issue: feat(terraform-modules): create gcp-project-config module"
    status: pending
  - id: linear-sub-state
    content: "Create sub-issue: feat(terraform-modules): create gcp-project-state module"
    status: pending
  - id: linear-sub-gke
    content: "Create sub-issue: feat(terraform-modules): create gcp-project-gke module"
    status: pending
  - id: linear-sub-extend
    content: "Create sub-issue: feat(terraform-modules): extend gcp-project outputs"
    status: pending
  - id: linear-sub-treasury
    content: "Create sub-issue: feat(terraform): create infinitepay-treasury project"
    status: pending
  - id: create-gcp-project-config
    content: Create gcp-project-config module with variables, validations, CloudWalk defaults
    status: pending
  - id: create-gcp-project-state
    content: Create gcp-project-state module with remote state reader and validation
    status: pending
  - id: create-gcp-project-gke
    content: Create gcp-project-gke module with APIs, WI Pool, Node SA
    status: pending
  - id: extend-gcp-project
    content: Add org_id and billing_account outputs to gcp-project module
    status: pending
  - id: create-treasury-structure
    content: Create tf-infinitepay-treasury with config/, project/, iam/, secrets/
    status: pending
  - id: create-treasury-readme
    content: Document the new project structure in README.md
    status: pending
---

# GCP Project Structure Refactoring Plan (v3)

## Overview

This plan establishes a new standard for GCP project structure with three complementary modules:

- `gcp-project-config`: Schema, validations, and CloudWalk defaults
- `gcp-project-state`: Remote state reader for project outputs
- `gcp-project-gke`: GKE preparation (APIs, Workload Identity, Node SA)

## Architecture

```mermaid
flowchart TB
    subgraph TerraformModules [terraform-modules/project/]
        GP[gcp-project]
        GPC[gcp-project-config]
        GPS[gcp-project-state]
        GPG[gcp-project-gke]
    end

    subgraph Treasury [tf-infinitepay-treasury/]
        CONFIG[config/]
        PROJECT[project/]
        IAM[iam/]
        SEC[secrets/]
    end

    GPC -->|"schema + defaults"| CONFIG
    GPS -->|"remote state"| CONFIG
    GP -->|"creates project"| PROJECT
    CONFIG -->|"module source"| PROJECT
    CONFIG -->|"module source"| IAM
    CONFIG -->|"module source"| SEC
    PROJECT -->|"state"| STATE[(Central State)]
    GPS -.->|"reads"| STATE
```

---

## Phase 1: Linear Issues Setup

Create parent issue with sub-issues in Linear (team: PLTFRM).

**Parent Issue:**

- Title: `feat(terraform): GCP Project Structure Refactoring`
- Description: Epic for standardizing GCP project patterns with reusable modules

**Sub-Issues:**

1. `feat(terraform-modules): create gcp-project-config module`
2. `feat(terraform-modules): create gcp-project-state module`
3. `feat(terraform-modules): create gcp-project-gke module`
4. `feat(terraform-modules): extend gcp-project outputs`
5. `feat(terraform): create infinitepay-treasury project`

---

## Phase 2: Create gcp-project-config Module

### New Module: [terraform-modules/project/gcp-project-config/](terraform-modules/project/gcp-project-config/)

**Purpose:** Schema definition, input validation, and CloudWalk defaults. No state, no resources.

**File Structure:**

```
project/gcp-project-config/
├── variables.tf    # Input variables with validations
├── main.tf         # Computed locals (CloudWalk defaults)
├── outputs.tf      # All configuration outputs
├── versions.tf     # Provider requirements
└── README.md
```

**variables.tf:**

```hcl
variable "project_id" {
  description = "The GCP project ID"
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{4,28}[a-z0-9]$", var.project_id))
    error_message = "Project ID must be 6-30 chars, lowercase, start with letter."
  }
}

variable "team" {
  description = "The team that owns this project"
  type        = string

  validation {
    condition     = length(var.team) > 0
    error_message = "Team is required."
  }
}

variable "environment" {
  description = "The environment type"
  type        = string

  validation {
    condition     = contains(["production", "staging", "development", "security", "sandbox"], var.environment)
    error_message = "Environment must be: production, staging, development, security, sandbox."
  }
}

variable "region" {
  description = "Default GCP region"
  type        = string
  default     = "us-east4"

  validation {
    condition     = contains(["us-east4", "us-central1", "southamerica-east1"], var.region)
    error_message = "Region must be: us-east4, us-central1, southamerica-east1."
  }
}
```

**main.tf:**

```hcl
locals {
  # CloudWalk organization defaults
  org_id          = "198557259264"
  billing_account = "013DCB-89E5D4-5125D4"

  # Computed values
  state_bucket        = "terraform-state-${var.project_id}"
  central_state_bucket = "terraform-state-storage-tooling"

  project_labels = {
    team        = var.team
    environment = var.environment
    managed_by  = "terraform"
  }
}
```

**outputs.tf:**

```hcl
output "project_id"           { value = var.project_id }
output "team"                 { value = var.team }
output "environment"          { value = var.environment }
output "region"               { value = var.region }
output "org_id"               { value = local.org_id }
output "billing_account"      { value = local.billing_account }
output "state_bucket"         { value = local.state_bucket }
output "central_state_bucket" { value = local.central_state_bucket }
output "project_labels"       { value = local.project_labels }
```

---

## Phase 3: Create gcp-project-state Module

### New Module: [terraform-modules/project/gcp-project-state/](terraform-modules/project/gcp-project-state/)

**Purpose:** Read project outputs from remote state. Use when you need real project values like `project_number`.

**File Structure:**

```
project/gcp-project-state/
├── main.tf         # Remote state data source
├── variables.tf    # Input variables
├── outputs.tf      # Project state outputs
├── versions.tf
└── README.md
```

**variables.tf:**

```hcl
variable "project_id" {
  description = "The project ID to read state from"
  type        = string
}

variable "central_state_bucket" {
  description = "Central state bucket for project bootstrap"
  type        = string
  default     = "terraform-state-storage-tooling"
}
```

**main.tf:**

```hcl
data "terraform_remote_state" "project" {
  backend = "gcs"
  config = {
    bucket = var.central_state_bucket
    prefix = "${var.project_id}/tfstates-project/"
  }
}

resource "terraform_data" "validate" {
  lifecycle {
    precondition {
      condition     = data.terraform_remote_state.project.outputs.project_id != null
      error_message = "Project '${var.project_id}' must be applied first."
    }
  }
}
```

**outputs.tf:**

```hcl
output "project_id"       { value = data.terraform_remote_state.project.outputs.project_id }
output "project_number"   { value = data.terraform_remote_state.project.outputs.project_number }
output "region"           { value = data.terraform_remote_state.project.outputs.region }
output "team"             { value = data.terraform_remote_state.project.outputs.team }
output "environment"      { value = data.terraform_remote_state.project.outputs.environment }
output "project_labels"   { value = data.terraform_remote_state.project.outputs.project_labels }
output "state_bucket_name" { value = data.terraform_remote_state.project.outputs.state_bucket_name }
output "enabled_apis"     { value = data.terraform_remote_state.project.outputs.enabled_apis }
```

---

## Phase 4: Create gcp-project-gke Module

### New Module: [terraform-modules/project/gcp-project-gke/](terraform-modules/project/gcp-project-gke/)

**Purpose:** Prepare an existing GCP project for GKE clusters.

**File Structure:**

```
project/gcp-project-gke/
├── api-services.tf      # GKE-specific APIs
├── workload-identity.tf # WI Pool for GitHub Actions
├── service-account.tf   # Node SA with standard roles
├── variables.tf
├── outputs.tf
├── versions.tf
└── README.md
```

**APIs Enabled:**

```hcl
locals {
  gke_apis = [
    "container.googleapis.com",
    "gkehub.googleapis.com",
    "containeranalysis.googleapis.com",
    "binaryauthorization.googleapis.com",
    "artifactregistry.googleapis.com",
  ]
}
```

**Resources Created:**

- `google_project_service` - GKE APIs
- `google_iam_workload_identity_pool` - GitHub Actions OIDC
- `google_iam_workload_identity_pool_provider` - GitHub provider
- `google_service_account` - GKE node pool SA with roles:
  - `roles/artifactregistry.reader`
  - `roles/logging.logWriter`
  - `roles/monitoring.metricWriter`
  - `roles/cloudtrace.agent`

---

## Phase 5: Extend gcp-project Module

### File: [terraform-modules/project/gcp-project/outputs.tf](terraform-modules/project/gcp-project/outputs.tf)

Add missing outputs for `gcp-project-state` to consume:

```hcl
output "org_id" {
  description = "The GCP Organization ID"
  value       = var.org_id
}

output "billing_account" {
  description = "The GCP Billing Account ID"
  value       = var.billing_account
}
```

---

## Phase 6: Create infinitepay-treasury Project

### Structure: [terraform/terraform-projects/tf-infinitepay-treasury/](terraform/terraform-projects/tf-infinitepay-treasury/)

```
tf-infinitepay-treasury/
├── README.md
├── config/
│   ├── main.tf         # Uses gcp-project-config + gcp-project-state
│   ├── outputs.tf
│   └── versions.tf
├── project/
│   ├── main.tf
│   └── provider.tf
├── iam/
│   ├── permissions/
│   │   ├── bindings.tf
│   │   └── provider.tf
│   └── service-accounts/
│       └── provider.tf
└── secrets/
    └── provider.tf
```

### config/main.tf

```hcl
# Configuration (always available, no state dependency)
module "config" {
  source = "git::https://github.com/cloudwalk/terraform-modules.git//project/gcp-project-config?ref=gcp-project-config@v0.1.0"

  project_id  = "infinitepay-treasury"
  team        = "treasury"
  environment = "production"
  region      = "us-east4"
}

# State (optional - for outputs like project_number)
# Only works after project/ has been applied
module "state" {
  source     = "git::https://github.com/cloudwalk/terraform-modules.git//project/gcp-project-state?ref=gcp-project-state@v0.1.0"
  project_id = module.config.project_id
}
```

### config/outputs.tf

```hcl
# From gcp-project-config (always available)
output "project_id"      { value = module.config.project_id }
output "team"            { value = module.config.team }
output "environment"     { value = module.config.environment }
output "region"          { value = module.config.region }
output "org_id"          { value = module.config.org_id }
output "billing_account" { value = module.config.billing_account }
output "state_bucket"    { value = module.config.state_bucket }
output "project_labels"  { value = module.config.project_labels }

# From gcp-project-state (requires project/ applied)
output "project_number"  { value = module.state.project_number }
output "enabled_apis"    { value = module.state.enabled_apis }
```

### project/main.tf

```hcl
module "config" {
  source = "../config"
}

module "project" {
  source = "git::https://github.com/cloudwalk/terraform-modules.git//project/gcp-project?ref=gcp-project@v0.1.0"

  project_id      = module.config.project_id
  team            = module.config.team
  environment     = module.config.environment
  region          = module.config.region
  org_id          = module.config.org_id
  billing_account = module.config.billing_account
}
```

### project/provider.tf

```hcl
terraform {
  required_version = ">= 1.7.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.14"
    }
  }

  backend "gcs" {
    bucket = "terraform-state-storage-tooling"
    prefix = "infinitepay-treasury/tfstates-project/"
  }
}

provider "google" {
  project = "infinitepay-treasury"
  region  = "us-east4"
}
```

### iam/permissions/provider.tf

```hcl
module "config" {
  source = "../../config"
}

terraform {
  required_version = ">= 1.7.4"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.14"
    }
  }

  backend "gcs" {
    bucket = "terraform-state-infinitepay-treasury"
    prefix = "tfstates-iam-permissions/"
  }
}

provider "google" {
  project = module.config.project_id
  region  = module.config.region
}
```

---

## Module Usage Summary

| Use Case | Module | Requires project/ applied |

| ------------------------------ | ------------------ | ------------------------- |

| Get project_id, region, labels | gcp-project-config | No |

| Get org_id, billing_account | gcp-project-config | No |

| Get project_number | gcp-project-state | Yes |

| Get enabled_apis | gcp-project-state | Yes |

| Prepare for GKE | gcp-project-gke | Yes |

---

## Bootstrap Order

1. Create `config/` - defines project configuration
2. Apply `project/` - creates GCP project and state bucket
3. Apply `iam/` and `secrets/` - can use full config outputs including `project_number`

Note: `project/` uses `config/` but only the `gcp-project-config` outputs (no state dependency).

---

## Final Module Structure

```
terraform-modules/project/
├── gcp-project/           # Creates GCP project (existing)
├── gcp-project-config/    # Schema + validations + defaults (NEW)
├── gcp-project-state/     # Remote state reader (NEW)
├── gcp-project-gke/       # GKE preparation (NEW)
└── ...
```

---

## Backward Compatibility

- Existing projects (`tf-cw-sec`, `tf-cw-oneclick`) continue using `_defaults/`
- New projects should use the `config/` pattern with `gcp-project-config` and `gcp-project-state`
- Migration of existing projects is NOT in scope
