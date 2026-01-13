# Linear Comment

## Overview

Add a comment to a Linear issue using Linearis CLI.

## Steps

1. **Parse Arguments**:
   - Extract issue ID (required)
   - Extract comment body (required)

2. **Create Comment with Linearis CLI**:

   ```bash
   linearis comments create PLTFRM-123 --body "Comment text here"
   ```

3. **Parse JSON Response**:
   - Confirm comment created
   - Extract comment details

4. **Display Confirmation**:
   - Show comment added
   - Provide issue URL

## Output Format

```markdown
## Comment Added

**Issue**: [PLTFRM-123: Issue Title](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug)

### Comment

> Comment text here...

**View**: [See in Linear](https://linear.app/cloudwalk/issue/PLTFRM-123/issue-slug#comment-xyz)
```

## Examples

```bash
# Add simple comment
/linear-comment PLTFRM-123 "Started working on this"

# Add progress update
/linear-comment PLTFRM-123 "Completed initial implementation. Ready for review."

# Add multi-line comment (use quotes)
/linear-comment PLTFRM-123 "Progress update:
- Implemented feature X
- Fixed bug Y
- Need to add tests"

# Add comment with code reference
/linear-comment PLTFRM-123 "Fixed in commit abc123. See PR #456"
```

## Arguments

Arguments: $ARGUMENTS

- First argument: Issue identifier (required)
  - Format: `PLTFRM-123`
- Second argument: Comment body (required)
  - Supports markdown formatting

## Use Cases

- Progress updates during development
- Questions or clarifications
- Review feedback
- Blockers or dependency notes
- Completion notes
