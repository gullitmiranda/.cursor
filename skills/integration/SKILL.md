---
name: integration
description: Linear, GitHub, Trunk, MCP, and external service integration rules. Use when using Linearis, gh CLI, Trunk, MCP servers, or external APIs.
---
# Integration Rules

## Linear Integration

See the **linear** skill for full Linear rules and CLI commands (skills/linear/).

Quick reference:
- **CLI Tool**: Linearis (`linearis` command)
- **Default Team**: Self Driven Platform (PLTFRM)
- **Default Status**: Backlog
- **Issue URLs**: Always use full markdown format

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

## Trunk Integration

### Tool Configuration

- Prefer configuring tools and linters using their standard configuration files in default paths (e.g., `.eslintrc`, `pyproject.toml`, `.prettierrc`) instead of configuring exclusively in `.trunk/`
- Keep `.trunk/trunk.yaml` minimal - use it only for Trunk-specific settings like enabled linters and actions
- This ensures tools work consistently whether run via Trunk or directly

### Ignore Configuration

- Prefer using each tool's native ignore mechanism (inline comments or ignore files) instead of Trunk's ignore system
- Examples:
  - ESLint: `// eslint-disable-next-line` or `.eslintignore`
  - Prettier: `// prettier-ignore` or `.prettierignore`
  - Ruff: `# noqa` or `pyproject.toml` exclude patterns
- This maintains compatibility when tools are run outside of Trunk

## MCP (Model Context Protocol) Integration

### Server Configuration

- Configure MCP servers in `mcp.json`
- Test server connections regularly
- Monitor server performance
- Document server purposes and usage

### Tool Integration

- **Linear**: Use Linearis CLI as primary tool; MCP only as fallback for unsupported operations
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
