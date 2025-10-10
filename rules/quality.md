# Quality Rules

## Code Quality

### Commit Standards

- Use conventional commit format: `<type>(<scope>): <description>`
- Types: feat, fix, chore, docs, style, refactor, test
- Present tense, imperative mood
- Include Linear issue references when applicable
- Keep descriptions concise but descriptive

### Code Style

- Follow project-specific linting rules
- Maintain consistent code style across the project
- Use meaningful variable and function names
- Include proper error handling
- Write clear, self-documenting code
- Add comments for complex logic

### Code Organization

- Keep functions small and focused
- Use appropriate design patterns
- Maintain clear separation of concerns
- Follow DRY (Don't Repeat Yourself) principles
- Organize imports and dependencies properly

## Quality Gates

### Pre-commit Checks

- All tests must pass before committing
- Linting must pass without errors
- Build must succeed
- Security scans must pass
- No sensitive data in commits

### Pre-PR Checks

- All quality gates must pass
- Code review requirements met
- Documentation updated
- Tests cover new functionality
- Performance impact assessed

### Testing Requirements

- All commands must be testable
- Include edge case testing
- Verify safety mechanisms work
- Test error handling paths
- Maintain test coverage standards

## Documentation Quality

### Content Standards

- Clear and concise explanations
- Practical examples and use cases
- Consistent formatting and structure
- Regular updates and maintenance
- Avoid redundant information
- Avoid overly complex explanations

### Structure Requirements

- Use proper markdown formatting
- Include table of contents for long documents
- Add code examples with syntax highlighting
- Include troubleshooting sections
- Provide clear navigation

### Maintenance

- Keep documentation up to date
- Review and update regularly
- Remove outdated information
- Add new features to documentation
- Solicit feedback from users

## Performance Quality

### Efficiency Standards

- Optimize for performance when possible
- Avoid unnecessary operations
- Use appropriate data structures
- Monitor resource usage
- Profile critical paths

### Scalability Considerations

- Design for growth
- Consider multi-repository scenarios
- Plan for increased usage
- Optimize for large codebases
- Handle edge cases gracefully

## Security Quality

### Data Protection

- Never commit sensitive information
- Use environment variables for secrets
- Validate all inputs
- Sanitize user data
- Follow security best practices

### Access Control

- Implement proper authentication
- Use least privilege principle
- Audit access patterns
- Monitor for suspicious activity
- Regular security reviews

## Integration Quality

### API Design

- Use consistent naming conventions
- Provide clear error messages
- Include proper status codes
- Document all endpoints
- Version APIs appropriately

### External Services

- Handle service failures gracefully
- Implement proper retry logic
- Monitor external dependencies
- Provide fallback mechanisms
- Log integration issues

## Monitoring and Observability

### Logging Standards

- Use appropriate log levels
- Include relevant context
- Avoid logging sensitive data
- Structure logs for analysis
- Implement log rotation

### Metrics and Monitoring

- Track key performance indicators
- Monitor error rates
- Set up alerts for critical issues
- Regular health checks
- Performance monitoring
