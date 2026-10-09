---
name: ship
description: Branch, test, commit, PR, review, merge, and clean up
---
1. Create a git worktree + feature branch off latest main.
2. Run `./mvnw test` and the unit-tester subagent (include JaCoCo coverage).
3. Commit in logically separated commits with conventional messages.
4. Push and open a PR with `gh pr create --fill`.
5. Run the code-reviewer subagent on the diff; fix any blocking findings and amend.
6. On a passing verdict run `gh pr merge --squash --delete-branch`.
7. Remove the worktree and local branch, then report the final state.
