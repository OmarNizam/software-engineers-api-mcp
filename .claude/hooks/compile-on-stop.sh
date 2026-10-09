#!/bin/bash
# Stop hook: compile when Java sources have uncommitted changes. If the
# compile fails, exit 2 so Claude sees the errors and fixes them. Skips on the
# re-entry pass (stop_hook_active) to avoid looping, and fails open otherwise.
input=$(cat)
case "$input" in *'"stop_hook_active":true'*|*'"stop_hook_active": true'*) exit 0 ;; esac

cd "${CLAUDE_PROJECT_DIR:-.}" || { echo "compile-on-stop: cannot cd to project dir; skipping compile" >&2; exit 0; }
git status --porcelain -- src 2>/dev/null | grep -q '\.java$' || exit 0

out=$(./mvnw -q -B test-compile 2>&1) && exit 0
echo "$out" | tail -40 >&2
echo "Compile failed after Java edits; fix the errors above." >&2
exit 2
