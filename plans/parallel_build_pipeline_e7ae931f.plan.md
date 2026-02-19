---
name: Parallel Build Pipeline
overview: Replace sequential GoReleaser builds with parallel matrix builds to reduce CI time from ~13min to ~3-4min, while maintaining separate platform-specific artifacts compatible with the existing install.sh script.
todos:
  - id: create-parallel-workflow
    content: Create new release.yml with parallel matrix builds
    status: pending
  - id: test-snapshot
    content: Test snapshot build on a feature branch
    status: pending
  - id: test-release
    content: Test release build with a test tag
    status: pending
  - id: verify-install
    content: Verify install.sh works with new artifact structure
    status: pending
---

# Parallel Build Pipeline for github-builder

## Context

Current state:

- GoReleaser builds 4 targets sequentially (~13 min total)
- Local build takes < 1 min (M1/M2/M3 is much faster than GitHub runners)
- [install.sh](github-builder/install.sh) already supports downloading individual platform binaries via `download_platform_binary()` function

## Architecture

```mermaid
flowchart TB
    subgraph phase1 [Phase 1: Parallel Builds]
        direction LR
        B1[darwin_amd64]
        B2[darwin_arm64]
        B3[linux_amd64]
        B4[linux_arm64]
    end

    subgraph phase2 [Phase 2: Package]
        P[Create archives and checksums]
    end

    subgraph phase3 [Phase 3: Release]
        R[Upload to GitHub Release]
    end

    phase1 --> phase2
    phase2 --> phase3
```

## Changes Required

### 1. Create new parallel release workflow

Create [.github/workflows/release-parallel.yml](github-builder/.github/workflows/release-parallel.yml) with:**Job: build (matrix)**

- Matrix: `goos: [darwin, linux]` x `goarch: [amd64, arm64]`
- Each job uploads artifact named `github-builder_{Os}_{arch}` (e.g., `github-builder_Darwin_amd64`)
- Uses `CGO_ENABLED=0` and ldflags `-s -w` for smaller binaries
- Injects version info via ldflags (same as current GoReleaser)

**Job: package (needs: build)**

- Downloads all 4 artifacts
- Creates `.tar.gz` for each binary
- Generates `checksums.txt` with SHA256
- Uploads consolidated artifact `release-artifacts`

**Job: release (needs: package, only on tags)**

- Downloads `release-artifacts`
- Creates GitHub Release using `softprops/action-gh-release`
- Uploads all `.tar.gz` files and `checksums.txt`

### 2. Keep snapshot workflow for branches

The snapshot job will also use matrix builds but upload to workflow artifacts instead of releases. This maintains the current behavior for branch builds that [install.sh](github-builder/install.sh) uses.

### 3. Artifact naming convention

Match current GoReleaser naming for compatibility:

- Binary: `github-builder_Darwin_amd64` (note: capital D/L for OS)
- Archive: `github-builder_Darwin_amd64.tar.gz`
- This matches what `download_platform_binary()` expects in install.sh

### 4. Version injection

Replace GoReleaser's automatic version with manual ldflags:

```bash
go build -ldflags="-s -w \
  -X github.com/cloudwalk/github-builder/cmd.version=${VERSION} \
  -X github.com/cloudwalk/github-builder/cmd.commit=${COMMIT} \
  -X github.com/cloudwalk/github-builder/cmd.date=${DATE}" \
  -o github-builder main.go
```

For snapshots: `VERSION=v3.0.0-alpha+YYYYMMDD-shortsha`

For releases: `VERSION=${GITHUB_REF_NAME}` (the tag)

## Files to Modify

| File | Action |

|------|--------|

| [.github/workflows/release.yml](github-builder/.github/workflows/release.yml) | Replace with parallel build version |

| [.goreleaser.yaml](github-builder/.goreleaser.yaml) | Keep for reference, but no longer used |

## Expected Results

| Metric | Before | After |

|--------|--------|-------|

| Build time | ~13 min | ~3-4 min |

| Artifacts | 1 zip with all | 4 separate per target |

| install.sh compatibility | Yes | Yes (same naming) |

## Rollback Plan
