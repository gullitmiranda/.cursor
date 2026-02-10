# Contributing to Cursor Settings

Thank you for your interest in contributing to this Cursor settings repository! This document provides guidelines for contributing skills, documentation, and improvements.

## 🎯 How to Contribute

### Types of Contributions

We welcome several types of contributions:

1. **New Skills** - Add new Agent Skills for development workflows
2. **Skill Improvements** - Enhance existing skills with new guidelines or procedures
3. **Documentation** - Improve documentation and examples
4. **Bug Fixes** - Fix issues in existing skills
5. **Examples** - Add usage examples and templates
6. **Guidelines** - Add or improve development guidelines within skills

### Getting Started

1. **Fork the Repository**

   ```bash
   git clone <your-fork-url>
   cd .cursor
   ```

2. **Create a Feature Branch**

   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/issue-description
   ```

3. **Make Your Changes**

   - Follow the coding standards outlined below
   - Test your changes thoroughly
   - Update documentation as needed

4. **Commit Your Changes**

   ```bash
   git add .
   git commit -m "feat: add new skill for deployment"
   ```

5. **Create a Pull Request**
   - Use the `/pr` command to create a well-formatted PR
   - Or manually create a PR with proper title and description

## 📝 Skill Development Guidelines

### Skill File Structure

Each skill lives in `skills/<skill-name>/SKILL.md` with YAML frontmatter and markdown body. For workflow-style skills, the body can follow a structure like:

````markdown
# Command Name

<task>
Brief description of what the command does
</task>

<context>
Rules, constraints, and context for the command
</context>

<workflow>
1. Step-by-step process
2. Detailed workflow
3. Error handling
</workflow>

<safety_checks>

- ✅ What the command should do
- ❌ What the command should never do
  </safety_checks>

<example_usage>

## Basic Usage

```bash
/command example
```
````

## Advanced Usage

```bash
/command --option value
```

</example_usage>

Arguments: $ARGUMENTS (description of arguments)

```

### Skill Naming Conventions

- Use descriptive, action-oriented names
- Use kebab-case for skill names (e.g. `git`, `linear`, `workspace-status`)
- Frontmatter: `name` and `description` (include "Use when..." for when the agent should load the skill)

### Safety Guidelines

Skills that involve operations must include safety checks:

- **Never execute destructive operations without confirmation**
- **Always validate inputs and environment**
- **Provide clear error messages**
- **Include rollback instructions when applicable**
- **Follow the principle of least privilege**

### Testing Requirements

Before submitting a skill:

1. **Test in Isolation** - Test the command in a clean environment
2. **Test Edge Cases** - Test with invalid inputs, missing dependencies
3. **Test Safety Checks** - Verify safety mechanisms work correctly (for skills that run operations)
4. **Test Documentation** - Ensure examples work as documented

## 📚 Documentation Standards

### README Updates

When adding new skills or features:

1. Update the main README.md with:
   - Skill description and when it applies
   - Usage examples
   - Any new dependencies or requirements

2. Update the skills table with new entries

3. Add any new configuration requirements

### Skill Documentation

Each skill file should include:

- Clear task description
- Complete workflow steps
- Safety checks and validations
- Working examples
- Argument descriptions
- Error handling information

### Examples Directory

Add practical examples in the `examples/` directory:

- `examples/commands/` - Usage examples for skill-driven workflows (e.g. git, pr)
- `examples/configs/` - Configuration examples
- `examples/workflows/` - Complete workflow examples

## 🔧 Code Standards

### Markdown Formatting

- Use proper markdown syntax
- Include code blocks with language specification
- Use consistent heading levels
- Include table of contents for long documents

### Skill Structure

- Keep skills focused on single domains or workflows
- Use clear, descriptive variable names
- Include comprehensive error handling
- Follow the established patterns

### Git Commit Messages

Use conventional commit format:

```

<type>(<scope>): <description>

[optional body]

[optional footer]

````

Types:
- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

## 🚀 Pull Request Process

### Before Submitting

1. **Run Quality Checks**
   ```bash
   # Test your changes
   /pr check
````

2. **Update Documentation**

   - Update README.md if needed
   - Add or update command documentation
   - Include usage examples

3. **Test Thoroughly**
   - Test in different environments
   - Verify safety mechanisms
   - Check error handling

### PR Requirements

1. **Clear Title** - Use conventional commit format
2. **Detailed Description** - Explain what changed and why
3. **Testing Information** - Describe how you tested
4. **Breaking Changes** - Note any breaking changes
5. **Documentation** - Update docs if needed

### PR Template

```markdown
## Description

Brief description of changes

## Type of Change

- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Refactoring
- [ ] Other (please describe)

## Testing

- [ ] Tested in isolation
- [ ] Tested edge cases
- [ ] Verified safety checks
- [ ] Updated documentation

## Breaking Changes

- [ ] No breaking changes
- [ ] Breaking changes (describe below)

## Additional Notes

Any additional information or context
```

## 🐛 Bug Reports

When reporting bugs, include:

1. **Environment Information**

   - Cursor version
   - Operating system
   - Project type

2. **Steps to Reproduce**

   - Clear, numbered steps
   - Expected vs actual behavior
   - Screenshots if applicable

3. **Error Messages**
   - Full error output
   - Console logs
   - Stack traces

## 💡 Feature Requests

When requesting features:

1. **Clear Description** - What should the feature do?
2. **Use Case** - Why is this needed?
3. **Proposed Solution** - How should it work?
4. **Alternatives** - Other approaches considered?

## 📋 Review Process

### Review Criteria

Pull requests are reviewed based on:

1. **Functionality** - Does it work as intended?
2. **Safety** - Are safety checks adequate?
3. **Documentation** - Is it well documented?
4. **Testing** - Has it been tested thoroughly?
5. **Standards** - Does it follow guidelines?

### Review Timeline

- Initial review within 2 business days
- Follow-up reviews within 1 business day
- Merge after approval and CI passes

## 🤝 Community Guidelines

### Code of Conduct

- Be respectful and inclusive
- Provide constructive feedback
- Help others learn and grow
- Follow the golden rule

### Communication

- Use clear, professional language
- Provide context for suggestions
- Ask questions when unclear
- Be patient with newcomers

## 📞 Getting Help

If you need help:

1. **Check Documentation** - Review existing docs first
2. **Search Issues** - Look for similar issues
3. **Ask Questions** - Create an issue with the "question" label
4. **Join Discussions** - Participate in community discussions

## 🎉 Recognition

Contributors will be recognized in:

- README.md contributors section
- Release notes for significant contributions
- Community highlights

Thank you for contributing to make Cursor development workflows better for everyone! 🚀
