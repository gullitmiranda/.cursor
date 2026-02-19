---
name: GCP Cloud CDN Module
overview: Create a reusable Terraform module for GCP Cloud CDN with Backend Bucket, simplifying CDN creation by abstracting 6 resources into a single configurable module.
todos:
  - id: create-main-tf
    content: Create main.tf with all 6 CDN resources (global_address, backend_bucket, managed_ssl_certificate, url_map, target_https_proxy, global_forwarding_rule)
    status: completed
  - id: create-variables-tf
    content: Create variables.tf with required (name, project, bucket_name, domain) and optional (cache settings, labels) variables with validations
    status: completed
  - id: create-outputs-tf
    content: Create outputs.tf exposing ip_address, backend_bucket_id, ssl_certificate_id
    status: completed
  - id: create-readme
    content: Create README.md with usage examples for staging and production
    status: completed
---

# GCP Cloud CDN Module

## Objective

Create a reusable Terraform module in `terraform-modules/project/cdn-bucket/` that encapsulates all Cloud CDN resources (Global IP, Backend Bucket, SSL Certificate, URL Map, HTTPS Proxy, Forwarding Rule), reducing ~60 lines of duplicated code to a simple module call.

## Current Problem

CDN implementations like `jim-app-assets.tf` are duplicated across environments with only 3 values changing:

- `project`
- `bucket_name`
- `domain`

## Module Design

### Location

`terraform-modules/project/cdn-bucket/`

### Resources Encapsulated

1. `google_compute_global_address` - External IP
2. `google_compute_backend_bucket` - Backend with CDN policy
3. `google_compute_managed_ssl_certificate` - Google-managed SSL
4. `google_compute_url_map` - URL routing
5. `google_compute_target_https_proxy` - HTTPS termination
6. `google_compute_global_forwarding_rule` - Load balancer entry point

### Key Variables

```hcl
# Required
variable "name"        {}  # Resource name prefix (e.g., "cdn-jim-app-assets")
variable "project"     {}  # GCP project ID
variable "bucket_name" {}  # Source GCS bucket name
variable "domain"      {}  # Domain for SSL certificate

# Optional (with sensible defaults)
variable "cache_mode"        { default = "CACHE_ALL_STATIC" }
variable "default_ttl"       { default = 3600 }
variable "max_ttl"           { default = 86400 }
variable "serve_while_stale" { default = 86400 }
variable "labels"            { default = {} }
```

### Outputs

```hcl
output "ip_address"         {}  # Global IP for DNS configuration
output "domain"             {}  # Domain configured for SSL certificate
output "backend_bucket_id"  {}
output "ssl_certificate_id" {}
```

## File Structure

```
terraform-modules/project/cdn-bucket/
├── main.tf           # All 6 GCP resources
├── variables.tf      # Input variables with validations
├── outputs.tf        # IP address and resource IDs
└── README.md         # Usage documentation
```

## Usage Example

After module creation, CDN setup reduces to:

```hcl
module "cdn_jim_app_assets" {
  source = "github.com/cloudwalk/terraform-modules//project/cdn-bucket"

  name        = "cdn-jim-app-assets"
  project     = "infinitepay-staging"
  bucket_name = "cdn-jim-app-assets-staging"
  domain      = "assets.jim.capybaras.dev"

  labels = {
    team        = "jimteam"
    application = "jim-app"
  }
}

output "cdn_ip" {
  value = module.cdn_jim_app_assets.ip_address
}
```

## Implementation Reference

Base implementation from existing file:

````55:63:terraform-projects/tf-infinitepay-staging/cdn/jim-app-assets.tf
```

## DNS Configuration (Separate)

The DNS configuration stays in the `terraform` repo, using the existing `dns-record` module. Create a `dns.tf` file alongside the CDN module call:

```hcl
# terraform-projects/tf-infinitepay-staging/cdn/dns.tf
module "cdn_jim_app_assets_dns" {
  source = "../../../cloudflare/modules/dns-record"

  zone_id    = local.zone_id  # From Cloudflare zone
  name       = "assets.jim"   # Subdomain
  content    = module.cdn_jim_app_assets.ip_address
  type       = "A"
  proxied    = false          # Required for Google Managed SSL
  team_owner = "jimteam"
  comment    = "CDN Jim App Assets - managed via terraform"
}
````

This approach:

- Keeps the CDN module in `terraform-modules` focused on GCP resources only
- Uses the existing `dns-record` module from `terraform/cloudflare/modules/`
- Allows DNS configuration in the same `cdn/` folder for organization

## Migration Path (Optional)

After module creation, existing CDN files can be migrated:

1. Import existing resources into module state
2. Replace raw resources with module call
3. Run `terraform plan` to verify no changes
