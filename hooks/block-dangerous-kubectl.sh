#!/bin/bash
# Hook: Block dangerous kubectl commands
# Event: beforeShellExecution
# Input: {"command": "<full terminal command>", "cwd": "<current working directory>"}
# Output: {"permission": "allow" | "deny" | "ask", "userMessage": "<message>", "agentMessage": "<message>"}

# Ler input JSON
input=$(cat)
command=$(echo "$input" | jq -r '.command')

# Verificar se deve bloquear comandos perigosos do kubectl
if [[ "$command" =~ kubectl\ (delete|apply) ]]; then
    echo '{"permission": "deny", "userMessage": "🚫 Dangerous kubectl command blocked! Use /k8s-check or /k8s-validate instead.", "agentMessage": "Command blocked by safety hook - use safe alternatives"}'
    exit 1
fi

# Permitir comando
echo '{"permission": "allow"}'
exit 0
