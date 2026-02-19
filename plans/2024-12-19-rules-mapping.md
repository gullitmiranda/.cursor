# Mapeamento de Rules para Migração

## 📊 Análise das Rules Existentes

### Rules Identificadas no Backup

1. **core.md** - Regras fundamentais e configurações básicas
2. **Git Scoped Commands.md** - Comandos Git com escopo
3. **Global Commands.md** - Comandos globais
4. **Kubernetes Scoped Commands.md** - Comandos Kubernetes
5. **pr-scoped-commands.md** - Comandos de Pull Request
6. **Blocked commands.md** - Comandos bloqueados por segurança

## 🗺️ Mapeamento para Nova Estrutura

### 1. **core.md** → **rules/safety.md** + **rules/workflow.md**

**Conteúdo atual:**

- Language rules (English by default)
- Terminal preferences (zsh)
- Temporary files management
- Workspace & Multi-Repository rules
- Git Safety rules
- Planning rules

**Migração:**

- **Safety rules**: Git safety, branch protection, destructive operations
- **Workflow rules**: Language, terminal, file management, workspace awareness

### 2. **Git Scoped Commands.md** → **commands/** (parcialmente migrado)

**Status**: 🔄 **Parcialmente migrado**

- `/git-commit` → `commands/commit.md` ✅
- `/git-branch` → `commands/git-branch.md` ❌
- `/git-status` → `commands/git-status.md` ❌
- `/git-reset` → `commands/git-reset.md` ❌

### 3. **Global Commands.md** → **commands/** (não migrado)

**Status**: ❌ **Não migrado**

- `/plan` → `commands/plan.md` ❌
- `/workspace-status` → `commands/workspace-status.md` ❌

### 4. **Kubernetes Scoped Commands.md** → **commands/** (não migrado)

**Status**: ❌ **Não migrado**

- `/k8s-check` → `commands/k8s-check.md` ❌
- `/k8s-validate` → `commands/k8s-validate.md` ❌
- `/k8s-diff` → `commands/k8s-diff.md` ❌

### 5. **pr-scoped-commands.md** → **commands/** (completamente migrado)

**Status**: ✅ **Completamente migrado**

- `/pr-create` → `commands/pr.md` ✅ (contém múltiplos comandos PR)
- `/pr-validate` → `commands/pr.md` ✅ (integrado como `/pr check`)
- `/pr-prepare` → `commands/pr.md` ✅ (integrado no workflow principal)
- `/pr-ready` → `commands/pr.md` ✅ (integrado como `/pr ready`)

### 6. **Blocked commands.md** → **hooks/** (formato corrigido)

**Conteúdo atual:**

- Command block hooks (kubectl, git reset --hard, git push main)
- Pre-commit hooks (conventional commits, branch protection)

**Migração:**

- **hooks.json** - Arquivo de configuração principal
- **hooks/\*.sh** - Scripts shell executáveis
- **Status**: ✅ **Formato corrigido** - Baseado na [documentação oficial](https://cursor.com/docs/agent/hooks)

## 📋 Plano de Migração Detalhado

### Fase 1: Migrar Rules Fundamentais

#### 1.1 Criar `rules/safety.md`

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

#### 1.2 Criar `rules/workflow.md`

```markdown
# Workflow Rules

## Language

- By default always write documentation, comments and code in English

## Integrated Terminal

- Always use the default shell (zsh)
- Prefer terminal commands over GUI operations when possible

## Temporary Files Management

- When creating temporary files, use temporary directories (`./tmp` or system tmp)
- Automatically clean up temporary files after use
- Never commit temporary files to version control

## Workspace & Multi-Repository Rules

- Always check current working directory and understand repository boundaries
- Never assume single git repository when working in multi-repo workspace
- Always verify which repository operations are targeting before execution
- When working with staged changes, identify which specific repository they belong to
- Navigate to correct repository directory before running git operations
- Treat each repository as separate entity with its own git state

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

### Fase 2: Implementar Hooks Corretamente

#### 2.1 Estrutura de Arquivos

```
~/.cursor/
├── hooks.json              # Arquivo de configuração dos hooks
└── hooks/                  # Diretório para scripts shell
    ├── block-dangerous-kubectl.sh
    ├── block-git-reset-hard.sh
    ├── block-git-push-main.sh
    └── check-branch-protection.sh
```

#### 2.2 Formato do `hooks.json`

```json
{
  "version": 1,
  "hooks": {
    "beforeShellExecution": [
      {
        "command": "./hooks/block-dangerous-kubectl.sh"
      },
      {
        "command": "./hooks/block-git-reset-hard.sh"
      },
      {
        "command": "./hooks/block-git-push-main.sh"
      }
    ],
    "afterFileEdit": [
      {
        "command": "./hooks/check-branch-protection.sh"
      }
    ]
  }
}
```

#### 2.3 Scripts Shell Necessários

**beforeShellExecution (Bloqueio de Comandos):**

- [ ] `hooks/block-dangerous-kubectl.sh` - Bloqueia comandos perigosos do kubectl
- [ ] `hooks/block-git-reset-hard.sh` - Bloqueia git reset --hard destrutivo
- [ ] `hooks/block-git-push-main.sh` - Bloqueia push direto para main/master

**afterFileEdit (Validação Pós-Edição):**

- [ ] `hooks/check-branch-protection.sh` - Protege branches main/master

#### 2.4 Formato dos Scripts

**beforeShellExecution Scripts:**

```bash
#!/bin/bash
# Input: {"command": "<full terminal command>", "cwd": "<current working directory>"}
# Output: {"permission": "allow" | "deny" | "ask", "userMessage": "<message>", "agentMessage": "<message>"}

# Ler input JSON
input=$(cat)
command=$(echo "$input" | jq -r '.command')

# Verificar se deve bloquear
if [[ "$command" =~ kubectl\ (delete|apply) ]]; then
    echo '{"permission": "deny", "userMessage": "🚫 Dangerous kubectl command blocked! Use /k8s-check or /k8s-validate instead.", "agentMessage": "Command blocked by safety hook"}'
    exit 1
fi

# Permitir comando
echo '{"permission": "allow"}'
exit 0
```

**afterFileEdit Scripts:**

```bash
#!/bin/bash
# Input: {"file_path": "<absolute path>", "edits": [{"old_string": "<search>", "new_string": "<replace>"}]}
# Output: Não requer output específico, apenas exit code

# Ler input JSON
input=$(cat)
file_path=$(echo "$input" | jq -r '.file_path')

# Validar arquivo editado
if [[ "$file_path" =~ \.md$ ]]; then
    echo "Validating markdown file: $file_path"
    # Lógica de validação aqui
fi

exit 0
```

### Fase 3: Completar Commands

#### 3.1 Migrar Global Commands

- `/plan` → `commands/plan.md`
- `/workspace-status` → `commands/workspace-status.md`

#### 3.2 Migrar Kubernetes Commands

- `/k8s-check` → `commands/k8s-check.md`
- `/k8s-validate` → `commands/k8s-validate.md`
- `/k8s-diff` → `commands/k8s-diff.md`

#### 3.3 Completar PR Commands

- `/pr-validate` → `commands/pr-validate.md`
- `/pr-prepare` → `commands/pr-prepare.md`
- `/pr-ready` → `commands/pr-ready.md`

#### 3.4 Completar Git Commands

- `/git-branch` → `commands/git-branch.md`
- `/git-status` → `commands/git-status.md`
- `/git-reset` → `commands/git-reset.md`

### Fase 4: Criar Rules de Qualidade e Integração

#### 4.1 Criar `rules/quality.md`

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

## Documentation Quality

- Clear and concise explanations
- Practical examples and use cases
- Consistent formatting and structure
- Regular updates and maintenance
- Avoid redundant information
- Avoid overly complex explanations
```

#### 4.2 Criar `rules/integration.md`

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

## 🎯 Resumo da Migração

### ✅ **Parcialmente Migrados (Commands)**

- **Git Commands**: Apenas `commit.md` migrado
- **PR Commands**: Apenas `pr.md` migrado (contém múltiplos comandos PR)
- **Global Commands**: Não migrados
- **Kubernetes Commands**: Não migrados

### 🔄 **Para Migrar (Rules)**

- **core.md** → `rules/safety.md` + `rules/workflow.md` ✅
- **Blocked commands.md** → `hooks/` ⚠️ (pendente correção)

### ➕ **Para Criar (Novas Rules)**

- `rules/quality.md` - Regras de qualidade
- `rules/integration.md` - Regras de integração

## 📊 Status da Migração

| Categoria         | Status     | Arquivo Destino                         | Prioridade |
| ----------------- | ---------- | --------------------------------------- | ---------- |
| Git Commands      | ✅ Migrado | `commands/` (4 comandos)                | -          |
| Global Commands   | ✅ Migrado | `commands/` (2 comandos)                | -          |
| K8s Commands      | ✅ Migrado | `commands/` (3 comandos)                | -          |
| PR Commands       | ✅ Migrado | `commands/pr.md` (comando consolidado)  | -          |
| Core Rules        | ✅ Migrado | `rules/safety.md` + `rules/workflow.md` | -          |
| Blocked Commands  | ✅ Migrado | `hooks/` (5 hooks implementados)        | -          |
| Quality Rules     | ✅ Migrado | `rules/quality.md`                      | -          |
| Integration Rules | ✅ Migrado | `rules/integration.md`                  | -          |

## 🚀 Próximos Passos

### Prioridade Alta (Fase 1)

1. **Implementar Hooks com formato corrigido**:
   - Criar `~/.cursor/hooks.json` com formato oficial
   - Criar diretório `~/.cursor/hooks/` para scripts
   - Implementar 5 scripts shell necessários
   - Testar funcionamento dos hooks

### Prioridade Alta (Fase 2)

2. **Completar migração dos Commands** restantes:
   - Git Commands: `git-branch.md`, `git-status.md`, `git-reset.md`
   - Global Commands: `plan.md`, `workspace-status.md`
   - PR Commands: `pr-validate.md`, `pr-prepare.md`, `pr-ready.md`

### Prioridade Média (Fase 3)

3. **Migrar Kubernetes Commands** para `commands/`
4. **Criar Quality Rules** em `rules/quality.md` ✅
5. **Criar Integration Rules** em `rules/integration.md` ✅

### Validação (Fase 4)

6. **Testar todas as rules** migradas
7. **Remover rules da interface** do Cursor
8. **Validar funcionamento** completo
