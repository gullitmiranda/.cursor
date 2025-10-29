# Global Commands

## /plan

**Description**: Create or update project plan in .cursor/plans/ directory

**Workflow**:

1. Always create or update plan file based on proposed plan inside .cursor/plans/ folder
2. Use clear, actionable task breakdown
3. Don't add time estimation unless explicitly requested
4. Format as markdown with clear sections and checkboxes
5. Include dependencies and prerequisites
6. Maintain plan history and versioning

**Plan structure**:

- ## Objective
- ## Tasks
- ## Dependencies
- ## Acceptance Criteria
- ## Notes

**File naming**: `.cursor/plans/YYYY-MM-DD-plan-name.md`

---

## /workspace-status

**Description**: Multi-repository workspace status overview

**Workflow**:

1. Always check current working directory and understand repository boundaries
2. Never assume single git repository when working in multi-repo workspace
3. Always verify which repository operations are targeting
4. Identify which specific repository changes belong to
5. Navigate to correct repository directory before running git operations
6. Treat each repository as separate entity with its own git state

**Multi-repository handling**:

- When working with staged changes, identify which specific repository they belong to
- Provide clear indication of repository boundaries
- Show status for each repository found in workspace
- Highlight any cross-repository dependencies or conflicts

**Error prevention**:

- Always ask for clarification when workspace structure is unclear
- Confirm target repository before running git commands
- Use non-destructive git commands first (git stash, git log) to understand situation
