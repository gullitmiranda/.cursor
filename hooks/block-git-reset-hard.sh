#!/bin/bash
# Hook: Block git reset --hard without explicit approval
# Event: beforeShellExecution
# Input: {"command": "<full terminal command>", "cwd": "<current working directory>"}
# Output: {"permission": "allow" | "deny" | "ask", "userMessage": "<message>", "agentMessage": "<message>"}

# Ler input JSON
input=$(cat)
command=$(echo "$input" | jq -r '.command')

# Verificar se deve bloquear git reset --hard
if [[ "$command" =~ git\ reset\ --hard ]]; then
    echo '{"permission": "deny", "userMessage": "🚫 Destructive git reset blocked! Use /git-reset for safe reset with backup.", "agentMessage": "Command blocked by safety hook - use safe reset command"}'
    exit 1
fi

# Permitir comando
echo '{"permission": "allow"}'
exit 0
