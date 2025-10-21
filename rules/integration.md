# Integration Rules

## Linear Integration

### Team Configuration

- **Default Team**: Self Driven Platform (ID: 94fb9928-3874-464a-9f3d-a354d3364f5c)
- **Alternative Team**: Platform ICEBOX (ID: 7357e730-4a1a-4f1a-8e53-f42a5077dbbd) - available but not default
- Use Self Driven Platform as the primary team for issue creation and management
- Platform ICEBOX available for specific use cases when requested
- Focus on Platform-related teams only

### Available Platform Teams

- **Self Driven Platform** (Ship icon) - Primary development team
- **Platform ICEBOX** - Alternative team for specific use cases
- Focus on Platform-related teams for development work
- Other teams available but not prioritized for default operations

### Issue Reference Format

- Use format: `PLTFRM-123`, `ENG-456`, `PROJ-789`
- **Default prefix**: PLTFRM (Self Driven Platform team)
- Include in commit messages when applicable
- Reference in PR descriptions
- Use magic words: "Closes", "Fixes", "Resolves"
- Enable GitHub integration in Linear settings
- Examples: `Closes PLTFRM-123`, `Fixes PLTFRM-456`

### Auto-linking Configuration

- Configure auto-link patterns in Linear
- Test linking functionality regularly
- Monitor sync status between Linear and GitHub
- Update patterns when project structure changes
- Verify issue status updates

### Workflow Integration

- Link commits to Linear issues
- Update issue status automatically
- Include issue context in PRs
- Track progress through Linear boards
- Use Linear for project planning

### Default Team Operations

- **Primary Team**: Self Driven Platform (94fb9928-3874-464a-9f3d-a354d3364f5c)
- **Team Key**: PLTFRM (for issue references)
- **Issue Prefix**: PLTFRM-123, PLTFRM-456
- Always use Self Driven Platform unless another team is specifically requested
- Platform ICEBOX available when specifically requested
- When creating issues, default to Self Driven Platform team
- When searching issues, prioritize Self Driven Platform team results
- Use PLTFRM prefix in commit messages for auto-linking
- Focus on Platform teams for development work

### Platform Team Workflow

- **Primary Development**: Self Driven Platform team for all new features and fixes
- **ICEBOX Usage**: Platform ICEBOX for experimental or future features
- **Issue Creation**: Default to Self Driven Platform unless ICEBOX specifically requested
- **Team Selection**: When user mentions "platform", default to Self Driven Platform
- **Branch Naming**: Use PLTFRM prefix for Self Driven Platform issues
- **Commit Messages**: Include PLTFRM-XXX references for auto-linking
- **PR Descriptions**: Reference PLTFRM issues in pull request descriptions

## GitHub Integration

### GitHub CLI Usage

- **MANDATORY**: Always use GitHub CLI (`gh`) for viewing GitHub logs and repository information
- Use `gh` commands instead of web interface for log access and repository operations
- Prefer `gh` CLI over browser-based GitHub operations when possible
- Use `gh log` for viewing commit logs and repository history
- Use `gh pr view` for pull request information
- Use `gh issue view` for issue details
- Use `gh repo view` for repository information

#### GitHub Actions

- Use `gh run list` to view workflow runs
- Use `gh run view <run-id>` to view specific workflow run details
- Use `gh run logs <run-id>` to view workflow logs
- Use `gh workflow list` to list available workflows
- Use `gh workflow view <workflow-name>` to view workflow details
- Use `gh run watch <run-id>` to watch a workflow run in real-time
- Use `gh run rerun <run-id>` to rerun failed workflows

### Pull Request Templates

- Use `.github/pull_request_template.md`
- Include all required sections
- Provide clear instructions for contributors
- Remove unused placeholders
- Update template when project evolves

### Code Ownership

- Define code ownership rules in `.github/CODEOWNERS`
- Include all critical paths and directories
- Update when project structure changes
- Test reviewer assignment functionality
- Ensure coverage of all important areas

### Labeling Strategy

- Use consistent labeling system
- Apply change-type labels (feat, fix, chore, docs)
- Set appropriate milestones
- Use priority labels when needed
- Maintain label documentation

### Review Process

- Require appropriate number of reviewers
- Assign reviewers based on code ownership
- Use team-based review assignments
- Set review deadlines when appropriate
- Monitor review completion

## MCP (Model Context Protocol) Integration

### Server Configuration

- Configure MCP servers in `mcp.json`
- Test server connections regularly
- Monitor server performance
- Update server configurations as needed
- Document server purposes and usage

### Tool Integration

- Integrate with Linear MCP tools
- Use GitHub MCP tools for repository operations
- Leverage web search capabilities
- Monitor tool usage and performance
- Update tool configurations

## External Service Integration

### API Integration

- Use consistent error handling
- Implement proper retry logic
- Monitor API rate limits
- Handle service failures gracefully
- Log integration issues

### Authentication

- Use secure authentication methods
- Store credentials securely
- Implement token refresh logic
- Monitor authentication status
- Handle authentication failures

### Data Synchronization

- Ensure data consistency across services
- Handle sync conflicts appropriately
- Monitor sync status
- Implement conflict resolution
- Regular sync validation

## Workspace Integration

### Multi-Repository Support

- Handle multiple git repositories
- Identify repository boundaries
- Manage cross-repository dependencies
- Provide clear repository context
- Support repository-specific configurations

### Environment Management

- Support different environments (dev, staging, prod)
- Use environment-specific configurations
- Handle environment-specific secrets
- Validate environment requirements
- Monitor environment health

### Tool Integration

- Integrate with development tools
- Support IDE extensions
- Work with build systems
- Integrate with CI/CD pipelines
- Support debugging tools

## Monitoring and Observability

### Integration Monitoring

- Monitor integration health
- Track integration performance
- Set up alerts for integration failures
- Log integration events
- Regular integration testing

### Error Handling

- Implement comprehensive error handling
- Provide clear error messages
- Log integration errors
- Implement error recovery
- Monitor error patterns

### Performance Monitoring

- Track integration response times
- Monitor resource usage
- Identify performance bottlenecks
- Optimize slow integrations
- Regular performance reviews

## Security Integration

### Secure Communication

- Use HTTPS for all external communications
- Implement proper certificate validation
- Use secure authentication protocols
- Monitor for security vulnerabilities
- Regular security audits

### Data Protection

- Encrypt sensitive data in transit
- Use secure storage for credentials
- Implement access controls
- Monitor data access patterns
- Regular security reviews

## Documentation and Maintenance

### Integration Documentation

- Document all integrations
- Provide setup instructions
- Include troubleshooting guides
- Update documentation regularly
- Maintain integration examples

### Regular Maintenance

- Review integration configurations
- Update integration versions
- Test integration functionality
- Monitor integration performance
- Plan integration improvements
