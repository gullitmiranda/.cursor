---
name: Prometheus dedicado para OpenTelemetry Collector em prd-1
overview: Criar um Prometheus dedicado e isolado para coletar métricas do OpenTelemetry Collector em prd-1, seguindo o padrão de separação de responsabilidades e isolamento de métricas.
todos:
  - id: "1"
    content: Criar StatefulSet do Prometheus dedicado para otel collector em prd-1
    status: pending
  - id: "2"
    content: Criar ConfigMap com configuração específica para coletar apenas métricas do otel collector
    status: pending
  - id: "3"
    content: Criar Service para expor o Prometheus dedicado
    status: pending
  - id: "4"
    content: Criar Application ArgoCD para gerenciar o deployment
    status: pending
  - id: "5"
    content: Criar VirtualService (opcional) para acesso via Istio Gateway
    status: pending
  - id: "6"
    content: Verificar e ajustar annotations do otel collector para evitar coleta duplicada
    status: pending
---

# Plano: Prometheus Dedicado para OpenTelemetry Collector em prd-1

## Objetivo

Criar um Prometheus dedicado e isolado especificamente para coletar métricas do OpenTelemetry Collector em prd-1, separado do Prometheus principal que coleta métricas de toda a infraestrutura.

## Situação Atual

- **OpenTelemetry Collector em prd-1**: Já existe e está configurado em `clusters-config/prd-1/monitoring/prd-1-opentelemetry-opentelemetrycollector.yaml`
  - Exporter Prometheus configurado na porta 8889
  - Annotations `prometheus.io/scrape: "true"` e `prometheus.io/port: "8889"` configuradas
  - Service `production-collector` expõe a porta 8889

- **Prometheus Principal em prd-1**: Existe em `clusters-config/prd-1/monitoring/prd-1-prometheus-statefulset.yaml`
  - Coleta métricas de toda a infraestrutura via service discovery
  - Atualmente também coleta métricas do otel collector através das annotations

## Arquitetura Proposta

```
┌─────────────────────────────────────┐
│  OpenTelemetry Collector (prd-1)    │
│  Porta 8889 (Prometheus exporter)    │
└──────────────┬───────────────────────┘
               │
               │ Métricas
               │
       ┌───────┴────────┐
       │                │
       ▼                ▼
┌──────────────┐  ┌──────────────┐
│ Prometheus   │  │ Prometheus   │
│ Principal    │  │ Dedicado     │
│ (prd-1)      │  │ (otel-only)  │
└──────────────┘  └──────────────┘
```

## Componentes Necessários

### 1. Prometheus Dedicado StatefulSet

- **Arquivo**: `clusters-config/prd-1/monitoring/prd-1-otel-collector-prometheus-statefulset.yaml`
- **Características**:
  - Replicas: 1 (ou mais conforme necessidade)
  - Storage: Menor que o Prometheus principal (ex: 100-200Gi)
  - Retention: Configurável (ex: 7-14 dias)
  - Recursos: Menores que o Prometheus principal
  - Node selector: Mesmo nodepool de observabilidade (`prd-1-c3dhm60-np-1-ob11y`)

### 2. ConfigMap do Prometheus Dedicado

- **Arquivo**: `clusters-config/prd-1/monitoring/prd-1-otel-collector-prometheus-configmap.yaml`
- **Configuração**:
  - Scrape config específico apenas para o otel collector
  - Target: `production-collector.monitoring.svc.cluster.local:8889`
  - Labels específicos para identificar métricas do otel collector
  - External labels: `cluster=prd-1`, `prometheus=otel-collector`

### 3. Service para o Prometheus Dedicado

- **Arquivo**: `clusters-config/prd-1/monitoring/prd-1-otel-collector-prometheus-service.yaml`
- **Tipo**: ClusterIP (ou LoadBalancer se necessário acesso externo)
- **Porta**: 9090 (padrão Prometheus)

### 4. ServiceMonitor (opcional, se usar Prometheus Operator)

- **Arquivo**: `clusters-config/prd-1/monitoring/prd-1-otel-collector-prometheus-servicemonitor.yaml`
- Para integração com Prometheus Operator se disponível

### 5. Application ArgoCD

- **Arquivo**: `clusters-config/prd-1/monitoring/prd-1-otel-collector-prometheus-application.yaml`
- Para gerenciar o deployment via ArgoCD

### 6. VirtualService (opcional)

- **Arquivo**: `clusters-config/prd-1/monitoring/prd-1-otel-collector-prometheus-virtualservice.yaml`
- Se necessário acesso via Istio Gateway

## Configurações Específicas

### Prometheus Config - Scrape Config

```yaml
scrape_configs:
  - job_name: "otel-collector"
    scrape_interval: 30s
    scrape_timeout: 10s
    static_configs:
      - targets:
          - "production-collector.monitoring.svc.cluster.local:8889"
    metric_relabel_configs:
      - source_labels: [__name__]
        regex: "spanmetrics.*"
        action: keep
```

### Recursos Recomendados

- **CPU**: 2-4 cores
- **Memory**: 8-16Gi
- **Storage**: 100-200Gi (dependendo da retenção)

### Isolamento

- Remover annotations `prometheus.io/scrape` do otel collector para evitar coleta duplicada pelo Prometheus principal
- OU configurar o Prometheus principal para excluir o otel collector do service discovery

## Estrutura de Arquivos

```
clusters-config/prd-1/monitoring/
├── prd-1-opentelemetry-opentelemetrycollector.yaml (existente)
├── prd-1-production-collector-svc.yaml (existente)
├── prd-1-otel-collector-prometheus-statefulset.yaml (novo)
├── prd-1-otel-collector-prometheus-configmap.yaml (novo)
├── prd-1-otel-collector-prometheus-service.yaml (novo)
├── prd-1-otel-collector-prometheus-application.yaml (novo)
└── prd-1-otel-collector-prometheus-virtualservice.yaml (opcional)
```

## Considerações

1. **Service Account**: Usar service account existente ou criar específica
2. **Thanos Sidecar**: Adicionar se necessário integração com Thanos
3. **PersistentVolumeClaim**: Configurar storage class apropriado
4. **Tolerations**: Aplicar tolerations do nodepool de observabilidade
5. **Security Context**: Seguir padrões de segurança existentes

## Próximos Passos (Após Implementação)

1. Verificar coleta de métricas no Prometheus dedicado
2. Configurar Grafana datasource apontando para o novo Prometheus
3. Criar dashboards específicos para métricas do otel collector
4. Configurar alertas se necessário
5. Documentar acesso e uso do novo Prometheus
