---
name: POC Crossplane Todo
overview: Todo list estruturado para implementacao da POC do Crossplane como alternativa ao Terraform para gerenciar recursos GCP, permitindo autonomia para times de desenvolvimento.
todos:
  - id: crossplane-setup
    content: Setup inicial do Crossplane no cluster tool-1-use4
    status: completed
  - id: crossplane-namespace
    content: Configurar namespace e RBAC para Crossplane
    status: completed
    dependencies:
      - crossplane-setup
  - id: crossplane-auth
    content: Configurar autenticacao Crossplane com GCP
    status: completed
    dependencies:
      - crossplane-namespace
  - id: gcp-providers
    content: Instalar e configurar providers GCP do Crossplane
    status: completed
    dependencies:
      - crossplane-auth
  - id: provider-secretmanager
    content: Configurar provider Secret Manager
    status: completed
    dependencies:
      - gcp-providers
  - id: provider-serviceaccount
    content: Configurar provider Service Account (IAM)
    status: completed
    dependencies:
      - gcp-providers
  - id: provider-cloudsql
    content: Configurar provider CloudSQL
    status: completed
    dependencies:
      - gcp-providers
  - id: provider-artifactregistry
    content: Configurar provider Artifact Registry
    status: completed
    dependencies:
      - gcp-providers
  - id: provider-bucket
    content: Configurar provider Bucket (GCS)
    status: completed
    dependencies:
      - gcp-providers
  - id: kyverno-setup
    content: Instalar e configurar Kyverno
    status: completed
    dependencies:
      - crossplane-setup
  - id: kyverno-policies
    content: Criar politicas Kyverno para limitar recursos e validacoes
    status: completed
    dependencies:
      - kyverno-setup
  - id: xrds-compositions
    content: Criar XRDs e Compositions para recursos GCP
    status: completed
    dependencies:
      - provider-secretmanager
      - provider-serviceaccount
      - provider-cloudsql
      - provider-artifactregistry
      - provider-bucket
  - id: abstractions-cloudsql
    content: Criar abstracoes Crossplane para CloudSQL
    status: completed
    dependencies:
      - xrds-compositions
  - id: abstractions-sa
    content: Criar abstracoes Crossplane para Service Account
    status: completed
    dependencies:
      - xrds-compositions
  - id: abstractions-ar
    content: Criar abstracoes Crossplane para Artifact Registry
    status: completed
    dependencies:
      - xrds-compositions
  - id: abstractions-sm
    content: Criar abstracoes Crossplane para Secret Manager
    status: completed
    dependencies:
      - xrds-compositions
  - id: abstractions-gcs
    content: Criar abstracoes Crossplane para Bucket (GCS)
    status: completed
    dependencies:
      - xrds-compositions
  - id: helm-charts
    content: Criar Helm charts para abstracoes Crossplane
    status: completed
    dependencies:
      - abstractions-cloudsql
      - abstractions-sa
      - abstractions-ar
      - abstractions-sm
      - abstractions-gcs
  - id: helm-docs
    content: Documentar uso dos Helm charts com exemplos praticos
    status: completed
    dependencies:
      - helm-charts
  - id: migration-select
    content: Selecionar recursos Terraform (cw-tooling) para migracao
    status: completed
    dependencies:
      - helm-charts
  - id: migration-execute
    content: Migrar recursos de exemplo para Crossplane
    status: completed
    dependencies:
      - migration-select
  - id: migration-validate
    content: Validar equivalencia com recursos Terraform
    status: completed
    dependencies:
      - migration-execute
  - id: cicd-integration
    content: Integrar Crossplane com pipelines CI/CD existentes
    status: completed
    dependencies:
      - migration-validate
  - id: docs-technical
    content: Criar documentacao tecnica do setup
    status: completed
    dependencies:
      - cicd-integration
  - id: docs-onboarding
    content: Criar guias de uso e onboarding para desenvolvedores
    status: completed
    dependencies:
      - docs-technical
  - id: tests-validation
    content: Executar testes de criacao, atualizacao e delecao de recursos
    status: completed
    dependencies:
      - docs-onboarding
  - id: poc-evaluation
    content: Avaliar resultados da POC e definir proximos passos
    status: completed
    dependencies:
      - tests-validation
---

# POC Crossplane - Todo List

## Visao Geral

Este todo list acompanha a implementacao da POC do Crossplane no cluster `tool-1-use4` para gerenciar 5 tipos de recursos GCP: Secret Manager, Service Account, CloudSQL, Artifact Registry e Bucket (GCS).

## Estrutura das Tasks

### Fase 1: Setup Inicial

- Setup do Crossplane no cluster
- Configuracao de namespace e RBAC
- Autenticacao com GCP

### Fase 2: Providers GCP

- Provider Secret Manager
- Provider Service Account (IAM)
- Provider CloudSQL
- Provider Artifact Registry
- Provider Bucket (GCS)

### Fase 3: Politicas

- Instalacao do Kyverno
- Politicas de validacao e seguranca

### Fase 4: Abstracoes

- XRDs e Compositions para cada tipo de recurso
- CloudSQL, Service Account, Artifact Registry, Secret Manager, Bucket

### Fase 5: Helm Charts

- Charts para abstracoes Crossplane
- Documentacao e exemplos

### Fase 6: Migracao

- Selecao de recursos do Terraform (projeto `cw-tooling`)
- Execucao da migracao
- Validacao de equivalencia

### Fase 7: CI/CD e Documentacao

- Integracao com pipelines existentes
- Documentacao tecnica e guias de onboarding

### Fase 8: Validacao Final

- Testes de recursos
- Avaliacao da POC e proximos passos

## Diagrama de Arquitetura

```mermaid
flowchart TB
    subgraph ToolCluster [Cluster tool-1-use4]
        Crossplane[Crossplane]
        Kyverno[Kyverno]
        HelmCharts[Helm Charts]
    end

    subgraph GCPResources [Recursos GCP]
        SM[Secret Manager]
        SA[Service Account]
        SQL[CloudSQL]
        AR[Artifact Registry]
        GCS[Bucket GCS]
    end

    subgraph TargetClusters [Clusters Alvo]
        Staging[stg-1]
        Production[prd-1]
        Tooling[tool-1-use4]
    end

    Crossplane --> GCPResources
    Kyverno --> Crossplane
    HelmCharts --> Crossplane
    GCPResources --> TargetClusters
```

## Dependencias Criticas

1. Cluster `tool-1-use4` disponivel
2. Acesso aos clusters alvo (stg-1, prd-1, tool-1-use4)
3. Permissoes GCP adequadas
4. Acesso ao repositorio `terraform` e projeto `cw-tooling`

## Criterios de Sucesso

- Crossplane funcionando no cluster
- Pelo menos 3 tipos de recursos GCP gerenciados
- Politicas Kyverno implementadas
- Helm charts criados e documentados
- Pelo menos 2 recursos migrados do Terraform
- Documentacao completa
- Validacao por pelo menos 1 time de desenvolvimento

Referencia: [poc-crossplane-planejamento-do-projeto-05a750f3.plan.md](terraform/.cursor/plans/poc-crossplane-planejamento-do-projeto-05a750f3.plan.md)
