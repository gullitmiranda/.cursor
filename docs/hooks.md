# Cursor Hooks Documentation

This document provides an overview of the Cursor hooks implemented in this repository for enhanced development safety and workflow automation.

## 📋 Overview

Hooks are automated scripts that run at specific points in the Cursor workflow to provide safety checks, validations, and helpful suggestions.

## 🎯 Available Hooks

### `beforeShellExecution` - Command Safety

These hooks run before terminal commands are executed to block dangerous operations:

| Hook                         | Purpose           | Blocks                               |
| ---------------------------- | ----------------- | ------------------------------------ |
| `block-dangerous-kubectl.sh` | Kubernetes safety | `kubectl delete`, `kubectl apply`    |
| `block-git-reset-hard.sh`    | Git safety        | `git reset --hard`                   |
| `block-git-push-main.sh`     | Branch protection | Direct commits/pushes to main/master |

### `beforeSubmitPrompt` - Smart Suggestions

These hooks provide helpful suggestions when submitting prompts:

| Hook                       | Purpose           | Suggests                                |
| -------------------------- | ----------------- | --------------------------------------- |
| `suggest-safe-commands.sh` | Safe alternatives | Feature branches, safe kubectl commands |

### `afterFileEdit` - File Monitoring

These hooks run after files are edited to provide contextual warnings:

| Hook                         | Purpose          | Monitors                                |
| ---------------------------- | ---------------- | --------------------------------------- |
| `check-branch-protection.sh` | Branch awareness | Edits to important files on main/master |

## 🔧 Configuration

Hooks are configured in `~/.cursor/hooks.json`:

```json
{
  "version": 1,
  "hooks": {
    "beforeShellExecution": [
      { "command": "./hooks/block-dangerous-kubectl.sh" },
      { "command": "./hooks/block-git-reset-hard.sh" },
      { "command": "./hooks/block-git-push-main.sh" }
    ],
    "beforeSubmitPrompt": [{ "command": "./hooks/suggest-safe-commands.sh" }],
    "afterFileEdit": [{ "command": "./hooks/check-branch-protection.sh" }]
  }
}
```

## 🚀 How It Works

### Command Blocking

When you try to run a dangerous command in the terminal:

```bash
git commit -m "fix bug"  # On main branch
# ❌ Blocked: Cannot commit directly to main branch!
```

### Smart Suggestions

When you ask Cursor to help with git operations:

```
"Help me commit these changes"  # On main branch
# 💡 Tip: You are on main branch. Consider using /git-branch to create a feature branch first.
```

### File Monitoring

When you edit important files on main/master:

```
# Editing README.md on main branch
# ⚠️ Warning: Editing important files directly on main branch
# 💡 Consider creating a feature branch with /git-branch command
```

## 🛡️ Safety Features

- **Branch Protection**: Prevents direct commits to main/master
- **Command Blocking**: Blocks destructive git and kubectl commands
- **Smart Suggestions**: Guides you to safer alternatives
- **Context Awareness**: Only triggers when relevant

## 📚 Official Documentation

For complete information about Cursor hooks, see the official documentation:

- [Cursor Agent Hooks](https://cursor.com/docs/agent/hooks) - Complete hooks reference
- [Cursor Agent Overview](https://cursor.com/docs/agent/overview) - General agent capabilities

## 🔧 Customization

To modify or add hooks:

1. Create/edit scripts in `~/.cursor/hooks/`
2. Update `~/.cursor/hooks.json` configuration
3. Ensure scripts are executable: `chmod +x hooks/*.sh`
4. Restart Cursor to apply changes

## 📝 Hook Script Format

### beforeShellExecution Scripts

```bash
#!/bin/bash
# Input: {"command": "<terminal command>", "cwd": "<working directory>"}
# Output: {"permission": "allow"|"deny"|"ask", "userMessage": "<message>"}

input=$(cat)
command=$(echo "$input" | jq -r '.command')

# Your logic here
if [[ "$command" =~ dangerous_pattern ]]; then
    echo '{"permission": "deny", "userMessage": "Command blocked!"}'
    exit 1
fi

echo '{"permission": "allow"}'
exit 0
```

### beforeSubmitPrompt Scripts

```bash
#!/bin/bash
# Input: {"prompt": "<user prompt>", "context": "<context>"}
# Output: {"permission": "allow"|"deny"|"ask", "userMessage": "<message>"}

input=$(cat)
prompt=$(echo "$input" | jq -r '.prompt')

# Your logic here
if [[ "$prompt" =~ git_pattern ]]; then
    echo '{"permission": "allow", "userMessage": "💡 Consider using /git-branch"}'
    exit 0
fi

echo '{"permission": "allow"}'
exit 0
```

### afterFileEdit Scripts

```bash
#!/bin/bash
# Input: {"file_path": "<absolute path>", "edits": [...]}
# Output: Exit code only (0 = success, 1 = failure)

input=$(cat)
file_path=$(echo "$input" | jq -r '.file_path')

# Your logic here
echo "File edited: $file_path"

exit 0
```

## 🎯 Best Practices

- **Keep hooks fast**: Avoid long-running operations
- **Provide clear messages**: Help users understand what happened
- **Test thoroughly**: Ensure hooks work as expected
- **Document changes**: Update this file when modifying hooks
- **Use exit codes correctly**: 0 for success, 1 for failure

## 🐛 Troubleshooting

### Hooks Not Running

1. Check if `hooks.json` is valid JSON
2. Verify script paths are correct
3. Ensure scripts are executable
4. Restart Cursor after changes

### Script Errors

1. Check script syntax with `bash -n script.sh`
2. Test scripts manually with sample input
3. Check file permissions
4. Review Cursor logs for error details

---

**Last Updated**: 2024-12-19  
**Version**: 1.0.0
