# Agent Workflow & Rules

## Core Principles
- **NO commits by agent** - Agent gives commands, human executes
- **Single phase at a time** - Wait for user approval before proceeding
- **Human tasks explicitly marked** - Clear separation between agent and human work
- **Test-driven progression** - User provides test cases, agent waits for "all done properly"

---

## Workflow

### Phase Execution Cycle
```
1. Agent: Start Phase N
2. Agent: List files to modify (Human Task)
3. Human: Verify/modify file list
4. Agent: Execute changes
5. Agent: Provide test commands
6. Human: Run tests, verify
7. Human: Say "all done properly"
8. Agent: Give git commands
9. Human: Execute git commands
10. Repeat for next phase
```

---

## Phase Structure

### Each Phase Contains:
1. **Automated Tasks** (Agent does)
   - Create directories
   - Move files
   - Update imports
   - Fix internal references

2. **Human Tasks** (Human does)
   - Verify file list before execution
   - Run build/tests
   - Test navigation manually
   - Confirm "all done properly"

---

## Test Commands

After each phase, run:

```bash
# Quick check
flutter analyze

# Full build
flutter build apk --debug

# iOS (if on Mac)
flutter build ios --debug
```

---

## Git Protocol

After "all done properly":

```bash
# Agent will provide:
git add -A
git commit -m "phase N: description"
git push origin [branch]
```

---

## Communication Format

### Agent Says:
- "Starting Phase N: [Feature]"
- "Files to modify:"
- "Test commands:"
- "Git commands:"

### Human Says:
- "All done properly" - Proceed to next phase
- "Issues found" - Describe problems, agent fixes
- "Modify file list" - Provide changes

---

## Rules

1. Never commit without explicit "all done properly"
2. Wait for user after each phase
3. Provide clear test commands
4. Keep old files as backup until phase verified
5. Update progress in MIGRATION_PLAN.md
