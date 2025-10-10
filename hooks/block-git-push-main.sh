#!/bin/bash
# Hook: Block dangerous git commands
# Event: beforeShellExecution
# Input: {"command": "<full terminal command>", "cwd": "<current working directory>"}
# Output: {"permission": "allow" | "deny" | "ask", "userMessage": "<message>", "agentMessage": "<message>"}

# Ler input JSON
input=$(cat)
command=$(echo "$input" | jq -r '.command')

# Verificar se estamos em um repositório git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    # Não é um repositório git, permitir
    echo '{"permission": "allow"}'
    exit 0
fi

# Obter branch atual
current_branch=$(git branch --show-current 2>/dev/null)

# Verificar push direto para main/master
if [[ "$command" =~ git\ push.*(main|master) ]]; then
    echo '{"permission": "deny", "userMessage": "🚫 Direct push to main/master blocked! Create a PR instead with /pr-create.", "agentMessage": "Command blocked by safety hook - use PR workflow"}'
    exit 1
fi

# Verificar commit direto em main/master
if [[ "$current_branch" == "main" || "$current_branch" == "master" ]]; then
    if [[ "$command" =~ git\ commit ]]; then
        echo '{"permission": "deny", "userMessage": "🚫 Cannot commit directly to $current_branch branch! Create a feature branch with /git-branch command.", "agentMessage": "Direct commit to main/master blocked - use feature branch"}'
        exit 1
    fi
fi

# Permitir comando
echo '{"permission": "allow"}'
exit 0
