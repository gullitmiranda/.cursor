# Blocked commands

```json
{
  "command-block-hooks": [
    {
      "name": "block-dangerous-kubectl",
      "description": "Block dangerous kubectl commands",
      "pattern": "kubectl (delete|apply)",
      "message": "🚫 Dangerous kubectl command blocked! Use /k8s-check or /k8s-validate instead.",
      "block": true
    },
    {
      "name": "block-git-reset-hard",
      "description": "Block git reset --hard without explicit approval",
      "pattern": "git reset --hard",
      "message": "🚫 Destructive git reset blocked! Use /git-reset for safe reset with backup.",
      "block": true
    },
    {
      "name": "block-git-push-main",
      "description": "Block pushes to main/master branch",
      "pattern": "git push.*main|git push.*master",
      "message": "🚫 Direct push to main/master blocked! Create a PR instead with /pr-create.",
      "block": true
    }
  ],
  "pre-commit-hooks": [
    {
      "name": "validate-conventional-commit",
      "description": "Ensure commit messages follow conventional commits",
      "script": "echo 'Validating conventional commit format...'",
      "message": "💡 Use /git-commit for automatic conventional commit formatting."
    },
    {
      "name": "check-branch-protection",
      "description": "Prevent commits directly to main/master",
      "script": "git branch --show-current | grep -E '^(main|master)$' && echo 'ERROR: Direct commits to main/master not allowed' && exit 1 || true",
      "message": "🚫 Cannot commit directly to main/master. Use /git-branch to create a feature branch."
    }
  ]
}
```
