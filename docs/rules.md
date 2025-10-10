# Rules Documentation

This document explains the rules and guidelines that govern the Cursor commands and development workflows in this repository.

## 🎯 Rule Categories

### 1. Safety Rules

### 2. Quality Rules

### 3. Workflow Rules

### 4. Integration Rules

### 5. Documentation Rules

## 🛡️ Safety Rules

### Git Safety

**Branch Protection**

- ❌ Never commit directly to main/master branch
- ✅ Always create feature branches for changes
- ✅ Use `/git-branch` command for safe branch creation
- ✅ Verify branch before committing

**Commit Safety**

- ❌ Never commit unstaged changes without explicit request
- ✅ Always validate conventional commit format
- ✅ Create backups before destructive operations
- ✅ Show what will be committed before execution

**Push Safety**

- ❌ Never push directly to main/master
- ✅ Always create pull requests for main branch changes
- ✅ Use `/pr-create` command for safe PR creation
- ✅ Verify remote branch exists before pushing

### Command Safety

**Destructive Operations**

- ❌ Never execute `kubectl delete` or `kubectl apply`
- ✅ Use `/k8s-check` for safe inspection
- ✅ Use `/k8s-validate` for manifest validation
- ✅ Use `/k8s-diff` for change preview

**Git Reset Safety**

- ❌ Never run `git reset --hard` without explicit approval
- ✅ Use `/git-reset` for safe reset with backup
- ✅ Always create stash before destructive operations
- ✅ Provide recovery instructions

### Data Safety

**Backup Requirements**

- ✅ Always create backups before destructive operations
- ✅ Use git stash for uncommitted changes
- ✅ Document recovery procedures
- ✅ Test backup restoration

## 📊 Quality Rules

### Code Quality

**Conventional Commits**

- ✅ Use format: `<type>(<scope>): <description>`
- ✅ Types: feat, fix, chore, docs, style, refactor, test
- ✅ Present tense, imperative mood
- ✅ Include Linear issue references

**Code Standards**

- ✅ Follow project-specific linting rules
- ✅ Maintain consistent code style
- ✅ Include proper error handling
- ✅ Write clear, self-documenting code

### Documentation Quality

**Command Documentation**

- ✅ Include complete workflow steps
- ✅ Provide safety check lists
- ✅ Include usage examples
- ✅ Document all parameters and options

**README Standards**

- ✅ Clear project overview
- ✅ Installation instructions
- ✅ Usage examples
- ✅ Contributing guidelines

### Testing Quality

**Test Requirements**

- ✅ All commands must be testable
- ✅ Include edge case testing
- ✅ Verify safety mechanisms
- ✅ Test error handling

**Quality Gates**

- ✅ Tests must pass before PR creation
- ✅ Linting must pass
- ✅ Build must succeed
- ✅ Security scans must pass

## 🔄 Workflow Rules

### Development Workflow

**Branch Management**

- ✅ Create feature branches from main/master
- ✅ Use descriptive branch names
- ✅ Keep branches focused on single features
- ✅ Delete merged branches

**Commit Workflow**

- ✅ Make small, focused commits
- ✅ Use conventional commit format
- ✅ Include meaningful commit messages
- ✅ Reference Linear issues when applicable

**PR Workflow**

- ✅ Create PRs for all main branch changes
- ✅ Use descriptive PR titles
- ✅ Include comprehensive descriptions
- ✅ Request appropriate reviewers

### Command Workflow

**Command Structure**

- ✅ Single responsibility per command
- ✅ Clear input validation
- ✅ Comprehensive error handling
- ✅ Consistent output format

**Command Safety**

- ✅ Validate inputs before execution
- ✅ Provide clear error messages
- ✅ Include rollback instructions
- ✅ Follow principle of least privilege

### Integration Workflow

**Linear Integration**

- ✅ Include issue IDs in commit messages
- ✅ Use magic words for auto-linking
- ✅ Reference issues in PR descriptions
- ✅ Keep Linear and GitHub in sync

**GitHub Integration**

- ✅ Use GitHub PR templates
- ✅ Respect CODEOWNERS file
- ✅ Apply appropriate labels
- ✅ Request proper reviewers

## 🔗 Integration Rules

### Linear Integration

**Issue References**

- ✅ Format: `ENG-123`, `PROJ-456`
- ✅ Use in commit messages
- ✅ Include in PR descriptions
- ✅ Use magic words: "Closes", "Fixes", "Resolves"

**Auto-linking Setup**

- ✅ Enable GitHub integration in Linear
- ✅ Configure auto-link patterns
- ✅ Test linking functionality
- ✅ Monitor sync status

### GitHub Integration

**PR Templates**

- ✅ Use `.github/pull_request_template.md`
- ✅ Include required sections
- ✅ Provide clear instructions
- ✅ Remove unused placeholders

**CODEOWNERS**

- ✅ Define code ownership rules
- ✅ Include all critical paths
- ✅ Update when structure changes
- ✅ Test reviewer assignment

**Labels and Milestones**

- ✅ Use consistent labeling
- ✅ Apply change-type labels
- ✅ Set appropriate milestones
- ✅ Use priority labels when needed

## 📋 Command-Specific Rules

### Git Commands

**`/commit` Rules**

- ✅ Only commit staged changes by default
- ✅ Use `/commit all` for all changes
- ✅ Validate conventional commit format
- ✅ Include Linear issue references

**`/git-branch` Rules**

- ✅ Create from main/master by default
- ✅ Use descriptive branch names
- ✅ Switch to new branch after creation
- ✅ Validate branch naming conventions

**`/git-status` Rules**

- ✅ Show multi-repository status
- ✅ Identify repository boundaries
- ✅ Highlight current repository
- ✅ Show staged vs unstaged changes

### PR Commands

**`/pr` Rules**

- ✅ Verify feature branch before creation
- ✅ Ensure commits ahead of base
- ✅ Push branch before PR creation
- ✅ Use conventional commit title format

**`/pr-check` Rules**

- ✅ Run all quality gates
- ✅ Validate PR completeness
- ✅ Check CI/CD status
- ✅ Verify metadata completeness

**`/pr-ready` Rules**

- ✅ Validate all quality gates pass
- ✅ Assign appropriate reviewers
- ✅ Apply relevant labels
- ✅ Remove draft status

### Kubernetes Commands

**`/k8s-check` Rules**

- ✅ Use read-only operations only
- ✅ Show current resource state
- ✅ Identify potential issues
- ✅ Provide analysis and recommendations

**`/k8s-validate` Rules**

- ✅ Use dry-run validation
- ✅ Check syntax and schema
- ✅ Validate against cluster
- ✅ Provide detailed validation report

**`/k8s-diff` Rules**

- ✅ Show changes without applying
- ✅ Highlight critical changes
- ✅ Provide impact analysis
- ✅ Suggest safe application strategies

## 🚨 Error Handling Rules

### Error Prevention

- ✅ Validate inputs before processing
- ✅ Check prerequisites before execution
- ✅ Provide clear error messages
- ✅ Include recovery instructions

### Error Recovery

- ✅ Provide rollback procedures
- ✅ Document recovery steps
- ✅ Test error scenarios
- ✅ Maintain system integrity

### Error Reporting

- ✅ Use consistent error format
- ✅ Include relevant context
- ✅ Provide actionable guidance
- ✅ Log errors appropriately

## 📚 Documentation Rules

### Command Documentation

- ✅ Include complete workflow
- ✅ Document all parameters
- ✅ Provide usage examples
- ✅ Include safety checks

### README Documentation

- ✅ Clear project overview
- ✅ Installation instructions
- ✅ Usage examples
- ✅ Contributing guidelines

### Code Documentation

- ✅ Comment complex logic
- ✅ Document public interfaces
- ✅ Include parameter descriptions
- ✅ Provide usage examples

## 🔄 Maintenance Rules

### Regular Updates

- ✅ Keep dependencies current
- ✅ Update documentation regularly
- ✅ Review and update rules
- ✅ Test all commands periodically

### Version Control

- ✅ Use semantic versioning
- ✅ Tag releases appropriately
- ✅ Maintain changelog
- ✅ Document breaking changes

### Quality Assurance

- ✅ Regular code reviews
- ✅ Automated testing
- ✅ Security audits
- ✅ Performance monitoring

## 📝 Documentation Rules

### Plan Documentation

**Plan Creation Guidelines**

- ✅ Create plans in `./plans/` directory
- ✅ Use clear, actionable task breakdown
- ✅ Include dependencies and prerequisites
- ✅ Format as markdown with clear sections
- ❌ **NEVER include timelines or schedules**
- ❌ **NEVER generate cronograms or time estimates**
- ❌ **NEVER make automatic commits or pushes**
- ✅ Focus on what needs to be done, not when
- ✅ Always wait for explicit instruction before git operations

**Plan Structure**

- ## Objective
- ## Tasks
- ## Dependencies
- ## Acceptance Criteria
- ## Notes

**File Naming**: `./plans/YYYY-MM-DD-plan-name.md`

### Documentation Standards

**Content Guidelines**

- ✅ Clear and concise explanations
- ✅ Practical examples and use cases
- ✅ Consistent formatting and structure
- ✅ Regular updates and maintenance
- ❌ Avoid redundant information
- ❌ Avoid overly complex explanations

## 📖 Reference Materials

### External References

- [Cursor Agent Overview](https://cursor.com/docs/agent/overview)
- [Cursor Agent Hooks](https://cursor.com/docs/agent/hooks)
- [Cursor Commands Documentation](https://cursor.com/docs/agent/chat/commands)
- [Cursor Rules Documentation](https://cursor.com/docs/context/rules#how-rules-work)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Linear GitHub Integration](https://linear.app/docs/github#enable-autolink)
- [GitHub CLI Documentation](https://cli.github.com/)

### Internal References

- [Commands Documentation](commands.md)
- [Contributing Guidelines](../CONTRIBUTING.md)
- [Examples Directory](../examples/)

## 🎯 Rule Enforcement

### Automatic Enforcement

- ✅ Pre-commit hooks validate format
- ✅ CI/CD checks enforce quality
- ✅ Command safety checks prevent issues
- ✅ Automated testing validates functionality

### Manual Enforcement

- ✅ Code review process
- ✅ Documentation review
- ✅ Regular rule audits
- ✅ Community feedback

### Rule Updates

- ✅ Regular review and updates
- ✅ Community input and feedback
- ✅ Version control for rule changes
- ✅ Clear communication of updates

---

**Remember**: These rules are designed to ensure safety, quality, and consistency across all development workflows. When in doubt, prioritize safety and ask for clarification.
