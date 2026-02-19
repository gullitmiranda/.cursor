# Plano de Migração: Rules do Cursor para Estrutura de Arquivos

## 🎯 Objetivo

Migrar as regras existentes configuradas através da interface do Cursor para a nova estrutura de arquivos em `~/.cursor`, aproveitando a capacidade de configurar rules, commands e hooks de forma específica e organizada.

## Table of Contents

- [🎯 Objetivo](#-objetivo)
- [Table of Contents](#table-of-contents)
- [📊 Análise da Situação Atual](#-análise-da-situação-atual)
  - [Estrutura Atual](#estrutura-atual)
  - [Problemas Identificados](#problemas-identificados)
- [🏗️ Nova Estrutura Proposta](#️-nova-estrutura-proposta)
- [📋 Plano de Migração](#-plano-de-migração)
  - [Fase 1: Preparação e Backup (1-2 horas)](#fase-1-preparação-e-backup-1-2-horas)
    - [1.1 Backup da Configuração Atual](#11-backup-da-configuração-atual)
    - [1.2 Análise de Rules Existentes](#12-análise-de-rules-existentes)
  - [Fase 2: Criação da Nova Estrutura (2-3 horas)](#fase-2-criação-da-nova-estrutura-2-3-horas)
    - [2.1 Criar Estrutura de Diretórios](#21-criar-estrutura-de-diretórios)
    - [2.2 Migrar Rules por Categoria](#22-migrar-rules-por-categoria)
    - [2.3 Criar Hooks de Automação](#23-criar-hooks-de-automação)
    - [2.4 Configurações Específicas](#24-configurações-específicas)
  - [Fase 3: Implementação de Scripts de Migração (3-4 horas)](#fase-3-implementação-de-scripts-de-migração-3-4-horas)
    - [3.1 Script de Migração Automática](#31-script-de-migração-automática)
    - [3.2 Script de Validação](#32-script-de-validação)
  - [Fase 4: Testes e Validação (2-3 horas)](#fase-4-testes-e-validação-2-3-horas)
    - [4.1 Testes de Funcionalidade](#41-testes-de-funcionalidade)
    - [4.2 Testes de Integração](#42-testes-de-integração)
    - [4.3 Validação de Performance](#43-validação-de-performance)
  - [Fase 5: Documentação e Treinamento (1-2 horas)](#fase-5-documentação-e-treinamento-1-2-horas)
    - [5.1 Documentação Técnica](#51-documentação-técnica)
    - [5.2 Documentação de Usuário](#52-documentação-de-usuário)
- [🔄 Processo de Rollback](#-processo-de-rollback)
  - [Rollback Automático](#rollback-automático)
  - [Rollback Manual](#rollback-manual)
- [📊 Cronograma](#-cronograma)
- [🎯 Critérios de Sucesso](#-critérios-de-sucesso)
  - [Funcionais](#funcionais)
  - [Não Funcionais](#não-funcionais)
- [🚨 Riscos e Mitigações](#-riscos-e-mitigações)
  - [Riscos Identificados](#riscos-identificados)
  - [Plano de Contingência](#plano-de-contingência)
- [📈 Próximos Passos](#-próximos-passos)

## 📊 Análise da Situação Atual

### Estrutura Atual

- **Rules**: Configuradas através da interface do Cursor (não versionadas)
- **Commands**: Já migrados para arquivos `.md` em `~/.cursor/commands/`
- **Hooks**: Não configurados (oportunidade de melhoria)
- **Configurações**: Misturadas entre interface e arquivos

### Problemas Identificados

1. **Rules não versionadas**: Regras importantes perdidas entre sessões
2. **Falta de organização**: Tudo misturado em um local
3. **Sem hooks**: Perda de funcionalidades de automação
4. **Difícil manutenção**: Mudanças não rastreáveis

## 🏗️ Nova Estrutura Proposta

```
~/.cursor/
├── rules/                    # Rules específicas por categoria
│   ├── safety.md            # Regras de segurança
│   ├── quality.md           # Regras de qualidade
│   ├── workflow.md          # Regras de workflow
│   ├── integration.md       # Regras de integração
│   └── project-specific.md  # Regras específicas do projeto
├── commands/                # Commands existentes (já migrados)
│   ├── commit.md
│   ├── pr.md
│   └── ...
├── hooks/                   # Hooks de automação
│   ├── pre-commit.md        # Hooks de pre-commit
│   ├── post-commit.md       # Hooks de post-commit
│   ├── pre-push.md          # Hooks de pre-push
│   └── session-start.md     # Hooks de início de sessão
├── config/                  # Configurações específicas
│   ├── mcp.json            # MCP servers (já existe)
│   ├── git.json            # Configurações Git
│   ├── linear.json         # Configurações Linear
│   └── github.json         # Configurações GitHub
├── templates/               # Templates reutilizáveis
│   ├── pr-template.md      # Template de PR
│   ├── commit-template.md  # Template de commit
│   └── issue-template.md   # Template de issue
└── docs/                   # Documentação (já existe)
    ├── commands.md
    ├── rules.md
    └── ...
```

## 📋 Plano de Migração

### Fase 1: Preparação e Backup (1-2 horas)

#### 1.1 Backup da Configuração Atual

```bash
# Criar backup completo da configuração atual
cp -r ~/.cursor ~/.cursor.backup.$(date +%Y%m%d_%H%M%S)

# Exportar rules da interface (se possível)
# Nota: Pode ser necessário fazer manualmente
```

#### 1.2 Análise de Rules Existentes

- [ ] Identificar todas as rules ativas na interface
- [ ] Categorizar por tipo (safety, quality, workflow, integration)
- [ ] Documentar dependências entre rules
- [ ] Identificar rules específicas do projeto vs globais

### Fase 2: Criação da Nova Estrutura (2-3 horas)

#### 2.1 Criar Estrutura de Diretórios

```bash
mkdir -p ~/.cursor/{rules,hooks,config,templates}
```

#### 2.2 Migrar Rules por Categoria

**2.2.1 Safety Rules (`~/.cursor/rules/safety.md`)**

```markdown
# Safety Rules

## Git Safety

- Never commit directly to main/master branch
- Always create feature branches for changes
- Use `/git-branch` command for safe branch creation
- Verify branch before committing
- Never commit unstaged changes without explicit request
- Always validate conventional commit format
- Create backups before destructive operations
- Show what will be committed before execution
- Never push directly to main/master
- Always create pull requests for main branch changes
- Use `/pr-create` command for safe PR creation
- Verify remote branch exists before pushing

## Command Safety

- Never execute `kubectl delete` or `kubectl apply`
- Use `/k8s-check` for safe inspection
- Use `/k8s-validate` for manifest validation
- Use `/k8s-diff` for change preview
- Never run `git reset --hard` without explicit approval
- Use `/git-reset` for safe reset with backup
- Always create stash before destructive operations
- Provide recovery instructions

## Data Safety

- Always create backups before destructive operations
- Use git stash for uncommitted changes
- Document recovery procedures
- Test backup restoration
```

**2.2.2 Quality Rules (`~/.cursor/rules/quality.md`)**

```markdown
# Quality Rules

## Code Quality

- Use conventional commit format: `<type>(<scope>): <description>`
- Types: feat, fix, chore, docs, style, refactor, test
- Present tense, imperative mood
- Include Linear issue references
- Follow project-specific linting rules
- Maintain consistent code style
- Include proper error handling
- Write clear, self-documenting code

## Quality Gates

- All tests must pass before PR creation
- Linting must pass
- Build must succeed
- Security scans must pass
- All commands must be testable
- Include edge case testing
- Verify safety mechanisms
- Test error handling
```

**2.2.3 Workflow Rules (`~/.cursor/rules/workflow.md`)**

```markdown
# Workflow Rules

## Branch Management

- Create feature branches from main/master
- Use descriptive branch names
- Keep branches focused on single features
- Delete merged branches

## Commit Workflow

- Make small, focused commits
- Use conventional commit format
- Include meaningful commit messages
- Reference Linear issues when applicable

## PR Workflow

- Create PRs for all main branch changes
- Use descriptive PR titles
- Include comprehensive descriptions
- Request appropriate reviewers
```

**2.2.4 Integration Rules (`~/.cursor/rules/integration.md`)**

```markdown
# Integration Rules

## Linear Integration

- Format: `ENG-123`, `PROJ-456`
- Use in commit messages
- Include in PR descriptions
- Use magic words: "Closes", "Fixes", "Resolves"
- Enable GitHub integration in Linear
- Configure auto-link patterns
- Test linking functionality
- Monitor sync status

## GitHub Integration

- Use `.github/pull_request_template.md`
- Include required sections
- Provide clear instructions
- Remove unused placeholders
- Define code ownership rules
- Include all critical paths
- Update when structure changes
- Test reviewer assignment
- Use consistent labeling
- Apply change-type labels
- Set appropriate milestones
- Use priority labels when needed
```

#### 2.3 Criar Hooks de Automação

**2.3.1 Pre-commit Hook (`~/.cursor/hooks/pre-commit.md`)**

```markdown
# Pre-commit Hook

## Validation Tasks

- Check if on main/master branch (prevent direct commits)
- Validate conventional commit format
- Run linting checks
- Run tests (if applicable)
- Check for sensitive data
- Validate file permissions
```

**2.3.2 Post-commit Hook (`~/.cursor/hooks/post-commit.md`)**

```markdown
# Post-commit Hook

## Post-commit Tasks

- Update Linear issue status (if referenced)
- Send notifications to team
- Update project documentation
- Trigger CI/CD pipeline
- Log commit metrics
```

**2.3.3 Pre-push Hook (`~/.cursor/hooks/pre-push.md`)**

```markdown
# Pre-push Hook

## Pre-push Validation

- Ensure all tests pass
- Check for merge conflicts
- Validate PR requirements
- Run security scans
- Check branch protection rules
```

#### 2.4 Configurações Específicas

**2.4.1 Git Config (`~/.cursor/config/git.json`)**

```json
{
  "defaultBranch": "main",
  "conventionalCommits": {
    "enabled": true,
    "types": ["feat", "fix", "chore", "docs", "style", "refactor", "test"],
    "requireScope": false
  },
  "branchNaming": {
    "pattern": "^(feat|fix|chore|docs|style|refactor|test)/[a-z0-9-]+$",
    "examples": [
      "feat/user-authentication",
      "fix/login-bug",
      "chore/update-dependencies"
    ]
  }
}
```

**2.4.2 Linear Config (`~/.cursor/config/linear.json`)**

```json
{
  "enabled": true,
  "autoLink": true,
  "magicWords": ["Closes", "Fixes", "Resolves"],
  "issuePattern": "^[A-Z]+-[0-9]+$",
  "teams": {
    "ENG": "Engineering",
    "PROJ": "Project Management"
  }
}
```

**2.4.3 GitHub Config (`~/.cursor/config/github.json`)**

```json
{
  "prTemplate": ".github/pull_request_template.md",
  "codeOwners": ".github/CODEOWNERS",
  "labels": {
    "feat": "enhancement",
    "fix": "bug",
    "chore": "maintenance",
    "docs": "documentation"
  },
  "reviewers": {
    "autoAssign": true,
    "required": 2,
    "teams": ["engineering", "product"]
  }
}
```

### Fase 3: Implementação de Scripts de Migração (3-4 horas)

#### 3.1 Script de Migração Automática

```bash
#!/bin/bash
# migrate-cursor-rules.sh

set -e

echo "🚀 Iniciando migração das rules do Cursor..."

# Backup
echo "📦 Criando backup..."
cp -r ~/.cursor ~/.cursor.backup.$(date +%Y%m%d_%H%M%S)

# Criar estrutura
echo "🏗️ Criando nova estrutura..."
mkdir -p ~/.cursor/{rules,hooks,config,templates}

# Migrar rules (manual - requer input do usuário)
echo "📝 Migrando rules..."
echo "⚠️  ATENÇÃO: Esta parte requer migração manual das rules da interface"
echo "   Por favor, copie suas rules atuais para os arquivos correspondentes:"
echo "   - ~/.cursor/rules/safety.md"
echo "   - ~/.cursor/rules/quality.md"
echo "   - ~/.cursor/rules/workflow.md"
echo "   - ~/.cursor/rules/integration.md"

# Validar migração
echo "✅ Validando migração..."
./validate-migration.sh

echo "🎉 Migração concluída!"
```

#### 3.2 Script de Validação

```bash
#!/bin/bash
# validate-migration.sh

echo "🔍 Validando migração..."

# Verificar estrutura
required_dirs=("rules" "hooks" "config" "templates")
for dir in "${required_dirs[@]}"; do
    if [ ! -d "~/.cursor/$dir" ]; then
        echo "❌ Diretório ~/.cursor/$dir não encontrado"
        exit 1
    fi
done

# Verificar arquivos obrigatórios
required_files=("rules/safety.md" "rules/quality.md" "rules/workflow.md" "rules/integration.md")
for file in "${required_files[@]}"; do
    if [ ! -f "~/.cursor/$file" ]; then
        echo "❌ Arquivo ~/.cursor/$file não encontrado"
        exit 1
    fi
done

# Verificar sintaxe JSON
for json_file in ~/.cursor/config/*.json; do
    if [ -f "$json_file" ]; then
        if ! jq empty "$json_file" 2>/dev/null; then
            echo "❌ Erro de sintaxe JSON em $json_file"
            exit 1
        fi
    fi
done

echo "✅ Validação concluída com sucesso!"
```

### Fase 4: Testes e Validação (2-3 horas)

#### 4.1 Testes de Funcionalidade

- [ ] Testar commands existentes
- [ ] Validar rules aplicadas
- [ ] Verificar hooks funcionando
- [ ] Testar configurações JSON

#### 4.2 Testes de Integração

- [ ] Testar integração com Linear
- [ ] Testar integração com GitHub
- [ ] Verificar MCP servers
- [ ] Testar workflows completos

#### 4.3 Validação de Performance

- [ ] Medir tempo de carregamento
- [ ] Verificar uso de memória
- [ ] Testar com projetos grandes
- [ ] Validar responsividade

### Fase 5: Documentação e Treinamento (1-2 horas)

#### 5.1 Documentação Técnica

- [ ] Atualizar README.md
- [ ] Criar guia de migração
- [ ] Documentar nova estrutura
- [ ] Criar troubleshooting guide

#### 5.2 Documentação de Usuário

- [ ] Guia de uso das novas features
- [ ] Exemplos de customização
- [ ] FAQ sobre migração
- [ ] Video tutorial (opcional)

## 🔄 Processo de Rollback

### Rollback Automático

```bash
#!/bin/bash
# rollback-migration.sh

echo "🔄 Iniciando rollback..."

# Restaurar backup
if [ -d "~/.cursor.backup" ]; then
    rm -rf ~/.cursor
    mv ~/.cursor.backup ~/.cursor
    echo "✅ Rollback concluído"
else
    echo "❌ Backup não encontrado"
    exit 1
fi
```

### Rollback Manual

1. Parar Cursor
2. Restaurar backup: `mv ~/.cursor.backup ~/.cursor`
3. Reiniciar Cursor
4. Verificar funcionamento

## 📊 Cronograma

| Fase                    | Duração   | Responsável | Status |
| ----------------------- | --------- | ----------- | ------ |
| 1. Preparação e Backup  | 1-2h      | Dev         | ⏳     |
| 2. Criação da Estrutura | 2-3h      | Dev         | ⏳     |
| 3. Scripts de Migração  | 3-4h      | Dev         | ⏳     |
| 4. Testes e Validação   | 2-3h      | Dev         | ⏳     |
| 5. Documentação         | 1-2h      | Dev         | ⏳     |
| **Total**               | **9-14h** |             |        |

## 🎯 Critérios de Sucesso

### Funcionais

- [ ] Todas as rules migradas e funcionando
- [ ] Commands existentes mantidos
- [ ] Hooks implementados e funcionando
- [ ] Configurações JSON válidas
- [ ] Integrações (Linear, GitHub) funcionando

### Não Funcionais

- [ ] Performance mantida ou melhorada
- [ ] Estrutura organizada e escalável
- [ ] Documentação completa
- [ ] Processo de rollback testado
- [ ] Zero downtime durante migração

## 🚨 Riscos e Mitigações

### Riscos Identificados

1. **Perda de rules personalizadas**
   - _Mitigação_: Backup completo antes da migração
2. **Incompatibilidade com versão do Cursor**
   - _Mitigação_: Testar em ambiente de desenvolvimento
3. **Performance degradada**
   - _Mitigação_: Monitoramento e otimização
4. **Falha na migração**
   - _Mitigação_: Processo de rollback testado

### Plano de Contingência

1. Manter backup por 30 dias
2. Testar em ambiente isolado primeiro
3. Migração gradual (por categoria)
4. Suporte técnico disponível

## 📈 Próximos Passos

1. **Aprovação do Plano**: Revisar e aprovar este plano
2. **Preparação do Ambiente**: Configurar ambiente de teste
3. **Execução da Fase 1**: Iniciar backup e análise
4. **Desenvolvimento Iterativo**: Implementar por fases
5. **Testes Contínuos**: Validar cada fase
6. **Deploy Gradual**: Migrar por categorias
7. **Monitoramento**: Acompanhar performance e uso

---

**Data de Criação**: 2024-12-19  
**Versão**: 1.0  
**Status**: Em Revisão
