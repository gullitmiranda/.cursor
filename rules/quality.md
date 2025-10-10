# Quality Rules

## Code Quality

- Use conventional commit format: `<type>(<scope>): <description>`
- Types: feat, fix, chore, docs, style, refactor, test
- Present tense, imperative mood
- Include Linear issue references
- Follow project-specific linting rules
- Maintain consistent code style
- Include proper error handling
- Write clear, self-documenting code

## Quality Gates

- All tests must pass before PR creation
- Linting must pass
- Build must succeed
- Security scans must pass
- All commands must be testable
- Include edge case testing
- Verify safety mechanisms
- Test error handling

## Documentation Quality

- Clear and concise explanations
- Practical examples and use cases
- Consistent formatting and structure
- Regular updates and maintenance
- Avoid redundant information
- Avoid overly complex explanations

## Plan Documentation

### Plan Creation Guidelines

- Create plans in `./plans/` directory
- Use clear, actionable task breakdown
- Include dependencies and prerequisites
- Format as markdown with clear sections
- **NEVER include timelines or schedules**
- **NEVER generate cronograms or time estimates**
- Focus on what needs to be done, not when

### Plan Structure

- ## Objective
- ## Tasks
- ## Dependencies
- ## Acceptance Criteria
- ## Notes

### File Naming

- Format: `./plans/YYYY-MM-DD-plan-name.md`

## Git Quality

### Commit Quality

- Use conventional commit format
- Include meaningful descriptions
- Reference Linear issues when applicable
- Keep commits focused and atomic
- Test changes before committing

### Branch Quality

- Use descriptive branch names
- Keep branches focused on single features
- Delete merged branches
- Create from main/master branch

### PR Quality

- Use descriptive PR titles
- Include comprehensive descriptions
- Reference Linear issues
- Request appropriate reviewers
- Ensure all checks pass
