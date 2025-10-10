# Workflow Rules

## Language

- By default always write documentation, comments and code in English

## Integrated Terminal

- Always use the default shell (zsh)
- Prefer terminal commands over GUI operations when possible

## Temporary Files Management

- When creating temporary files, use temporary directories (`./tmp` or system tmp)
- Never commit temporary files to version control

## Workspace & Multi-Repository Rules

### Workspace Structure Awareness

- Always check current working directory and understand repository boundaries
- Never assume single git repository when working in multi-repo workspace
- Always verify which repository operations are targeting before execution

### Multi-Repository Handling

- When working with staged changes, identify which specific repository they belong to
- Navigate to correct repository directory before running git operations
- Treat each repository as separate entity with its own git state

## Branch Management

- Create feature branches from main/master
- Use descriptive branch names
- Keep branches focused on single features
- Delete merged branches

## Commit Workflow

- Only commit when explicitly requested
- Never commit unstaged changes without explicit request
- Never commit directly to main/master branch
- Make small, focused commits
- Use conventional commit format
- Include meaningful commit messages
- Reference Linear issues when applicable

## PR Workflow

- Create PRs for all main branch changes
- Use descriptive PR titles
- Include comprehensive descriptions
- Request appropriate reviewers

## Planning Workflow

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

## Documentation Standards

### Content Guidelines

- Clear and concise explanations
- Practical examples and use cases
- Consistent formatting and structure
- Regular updates and maintenance
- Avoid redundant information
- Avoid overly complex explanations
