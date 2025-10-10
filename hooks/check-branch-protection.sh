#!/bin/bash
# Hook: Check branch protection after file edit
# Event: afterFileEdit
# Input: {"file_path": "<absolute path>", "edits": [{"old_string": "<search>", "new_string": "<replace>"}]}
# Output: Apenas exit code (0 = sucesso, 1 = falha)

# Ler input JSON
input=$(cat)
file_path=$(echo "$input" | jq -r '.file_path')

# Verificar se estamos em um repositório git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    # Não é um repositório git, permitir
    exit 0
fi

# Obter branch atual
current_branch=$(git branch --show-current 2>/dev/null)

# Verificar se estamos tentando editar arquivos diretamente na branch main/master
if [[ "$current_branch" == "main" || "$current_branch" == "master" ]]; then
    # Verificar se é um arquivo importante (não temporário)
    if [[ ! "$file_path" =~ \.(tmp|temp|log|cache)$ ]] && [[ ! "$file_path" =~ /(tmp|temp|cache)/ ]]; then
        echo "⚠️  Warning: Editing important files directly on $current_branch branch"
        echo "💡 Consider creating a feature branch with /git-branch command"
        echo "📁 File: $(basename "$file_path")"
    fi
fi

# Verificar se o arquivo editado é um arquivo de configuração importante
if [[ "$file_path" =~ \.(json|yaml|yml|toml|ini|md)$ ]] && [[ ! "$file_path" =~ \.(tmp|temp|log|cache)$ ]]; then
    echo "📝 Configuration file edited: $(basename "$file_path")"
    echo "💡 Consider reviewing changes before committing"
fi

# Sempre permitir edição
exit 0
