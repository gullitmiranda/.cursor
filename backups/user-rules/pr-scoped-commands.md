# PR Scoped Commands

## /pr-create

**Description**: Complete PR creation workflow with template support

**Workflow**:

1. Always use `gh` CLI to create PRs, ignoring uncommitted/unstaged changes unless explicitly requested
2. Ensure branch has been created and changes committed before attempting PR creation
3. Ensure PR has correct base branch when creating
4. Ensure PR was pushed to remote repository before creation
5. Generate PR title from main type/scope of committed changes (feat, fix, chore)
6. Format PR title as: `<type>(<scope>): <short summary>`
7. Build pull request description from committed changes

**PR Body Generation**:

- Use `.github/pull_request_template.md` as base if it exists
- If template has issue links and user hasn't provided link, ask for issue link or remove from PR body
- Use temporary markdown file (e.g., `pr_body.md`) to avoid formatting issues
- Do not commit the temporary PR body file
- If generated PR body appears incomplete, ask user for missing information
- Optionally assign PR to author or apply labels based on branch/type

---

## /pr-validate

**Description**: Validate PR format and completeness

**Workflow**:

1. Check if PR description is complete and informative
2. Verify PR title follows conventional commit format
3. Ensure proper labels and assignments are applied
4. Validate that all required checks are passing
5. Suggest improvements for incomplete or unclear PRs
6. Confirm PR is ready for review before submission

**Validation checks**:

- Title format: `<type>(<scope>): <description>`
- Description completeness
- Required template sections filled
- Labels and assignees present
- CI/CD checks status

---

## /pr-prepare

**Description**: Complete preparation workflow (test + commit + PR)

**Workflow**:

1. Run project tests, lints, and other quality checks
2. Ensure all checks pass before proceeding
3. Run smart commit workflow to create conventional commit
4. Create PR using PR creation workflow
5. Provide summary of what was completed and any issues found

**Quality gates**:

- All tests must pass
- Linting must pass
- Build must succeed
- Commit must follow conventions
- PR must be properly formatted

---

## /pr-ready

**Description**: Mark PR as ready for review

**Workflow**:

1. Validate PR using /pr-validate workflow
2. Ensure all checks are passing
3. Remove draft status if applicable
4. Add appropriate reviewers
5. Apply ready-for-review labels
6. Notify relevant team members

**Final checks**:

- No failing CI/CD checks
- All template sections completed
- Proper reviewers assigned
- Appropriate labels applied
