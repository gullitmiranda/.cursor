# Integration Rules

## Linear Integration

### Team Configuration

- **Default Team**: Self Driven Platform (ID: 94fb9928-3874-464a-9f3d-a354d3364f5c)
- **Alternative Team**: Platform ICEBOX (ID: 7357e730-4a1a-4f1a-8e53-f42a5077dbbd) - available but not default
- Focus on Platform-related teams only

### Default Settings

- **Assignee**: me (current user)
- **Status**: Todo
- **Team**: Self Driven Platform (unless ICEBOX specifically requested)
- **Issue Prefix**: PLTFRM-123, PLTFRM-456
- **Priority**: Based on issue type and urgency
- **Labels**: Auto-assign based on issue content and type

### Issue References and Links

- **Format**: `PLTFRM-123`, `ENG-456`, `PROJ-789`
- **Magic Words**: "Closes", "Fixes", "Resolves"
- **Enhanced Links**: `[PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)`
- **Usage**: PR descriptions, commit messages, documentation
- **Example**: `[PLTFRM-5470: feat(ci): add optimized GitHub workflows for Terraform CI/CD](https://linear.app/cloudwalk/issue/PLTFRM-5470/featci-add-optimized-github-workflows-for-terraform-cicd)`

### Workflow Integration

- Link commits to Linear issues
- Update issue status automatically
- Include issue context in PRs
- Use Linear for project planning
- Configure auto-link patterns in Linear
- Monitor sync status between Linear and GitHub

## GitHub Integration

### GitHub CLI Usage

- **MANDATORY**: Always use GitHub CLI (`gh`) for viewing GitHub logs and repository information
- Use `gh` commands instead of web interface for log access and repository operations
- Prefer `gh` CLI over browser-based GitHub operations when possible

#### Core Commands

- `gh log` - View commit logs and repository history
- `gh pr view` - Pull request information
- `gh issue view` - Issue details
- `gh repo view` - Repository information

#### GitHub Actions

- `gh run list` - View workflow runs
- `gh run view <run-id>` - View specific workflow run details
- `gh run logs <run-id>` - View workflow logs
- `gh workflow list` - List available workflows
- `gh workflow view <workflow-name>` - View workflow details
- `gh run watch <run-id>` - Watch a workflow run in real-time
- `gh run rerun <run-id>` - Rerun failed workflows

### Pull Request Management

- Use `.github/pull_request_template.md`
- Define code ownership rules in `.github/CODEOWNERS`
- Use consistent labeling system (feat, fix, chore, docs)
- Require appropriate number of reviewers
- Assign reviewers based on code ownership

## MCP (Model Context Protocol) Integration

### Server Configuration

- Configure MCP servers in `mcp.json`
- Test server connections regularly
- Monitor server performance
- Document server purposes and usage

### Tool Integration

- Integrate with Linear MCP tools
- Use GitHub MCP tools for repository operations
- Leverage web search capabilities
- Monitor tool usage and performance

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
