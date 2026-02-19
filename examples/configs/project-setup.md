# Project Setup Examples

This document provides examples of how to set up Cursor settings for different types of projects and development environments.

## 🏗️ Basic Project Setup

### Standard Web Application

**Project Structure**:

```plaintext
my-web-app/
├── .cursor/
│   ├── skills/
│   ├── docs/
│   └── examples/
├── src/
├── tests/
├── package.json
└── README.md
```

**Setup Steps**:

1. Follow the [Quick Start guide](../../README.md#-quick-start) to set up .cursor
2. Customize skills for your project (edit `skills/<name>/SKILL.md`)
3. Add project-specific rules (e.g. `.cursor/rules.md` in the project)

### Monorepo Setup

**Project Structure**:

```plaintext
my-monorepo/
├── .cursor/
├── packages/
│   ├── frontend/
│   ├── backend/
│   └── shared/
└── tools/
```

**Setup Steps**:

1. Set up .cursor at root level
2. Use workspace-aware skills (e.g. git, workspace-status)
3. Follow multi-repository guidelines in the workflow and safety skills

## 🔧 Environment-Specific Setup

### Development Environment

- Enable all safety hooks
- Use detailed logging
- Enable all quality checks

### Production Environment

- Disable debug commands
- Use minimal logging
- Focus on essential safety checks

## 📝 Customization Examples

### Adding Project-Specific Skills

1. Create a new skill in `skills/<skill-name>/SKILL.md`
2. Use YAML frontmatter (`name`, `description`) and markdown instructions
3. Add to documentation

### Customizing Behavior

1. Edit the relevant `skills/<name>/SKILL.md` file
2. Add project-specific guidelines in skills (or in the project's `.cursor/rules/` or `AGENTS.md` if desired; we use skills as canonical)
3. Update documentation

### Making the agent always respect constraints (e.g. gremlin characters)

Skills are applied when the agent invokes them. For constraints that must apply in **every** conversation in a given project (e.g. no gremlin characters), you can optionally add a project rule with `alwaysApply: true` in that project's `.cursor/rules/` or put the constraint in the project's `AGENTS.md`. Our canonical source is the quality skill; project rules are optional. Use **`/gremlin-clean`** (defined in `commands/gremlin-clean.md`) to strip gremlins from files when they still appear.

## 🚀 Integration Examples

### Linear Integration

- Configure issue references
- Set up auto-linking
- Test integration

### GitHub Integration

- Set up PR templates
- Configure code owners
- Test workflows
