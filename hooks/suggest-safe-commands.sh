#!/bin/bash
# Hook: Provide helpful suggestions for git operations
# Event: beforeSubmitPrompt
# Input: {"prompt": "<user prompt>", "context": "<context>"}
# Output: {"permission": "allow" | "deny" | "ask", "userMessage": "<message>", "agentMessage": "<message>"}

# Ler input JSON
input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt')

# Verificar se estamos em um repositório git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    # Não é um repositório git, permitir
    echo '{"permission": "allow"}'
    exit 0
fi

# Obter branch atual
current_branch=$(git branch --show-current 2>/dev/null)

# Sugerir uso de comandos seguros quando apropriado
if [[ "$prompt" =~ (commit|git commit) ]] && [[ "$current_branch" == "main" || "$current_branch" == "master" ]]; then
    echo '{"permission": "allow", "userMessage": "💡 Tip: You are on $current_branch branch. Consider using /git-branch to create a feature branch first.", "agentMessage": "User is on main/master - suggest feature branch"}'
    exit 0
fi

# Sugerir comandos seguros para kubectl
if [[ "$prompt" =~ kubectl\ (delete|apply) ]]; then
    echo '{"permission": "allow", "userMessage": "💡 Tip: For safety, consider using /k8s-check or /k8s-validate commands instead.", "agentMessage": "Suggest safe kubectl alternatives"}'
    exit 0
fi

# Permitir prompt
echo '{"permission": "allow"}'
exit 0
