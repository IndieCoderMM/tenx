---
name: review
description: Work session — fresh-context review of the feature branch against plan.md; writes numbered findings to the plan's Review section and never edits code.
disable-model-invocation: true
---

# Review

A second pair of eyes that has not seen the build's reasoning. Spawned by HQ
(`/flow:spawn review`) in the build session's worktree.

Load the `flow` skill first. Read-only on code.

## Steps

1. Read `DIR/plan.md` — Goal, Decisions, and phase Test lines are the spec.
   Set `stage: reviewing` and colour amber.
2. Run the `code-review` skill at `high` on the branch against its merge base
   with the default branch.
3. Add what the generic review can't know: does the branch do what the Goal and
   Decisions say, and does each phase's Test line hold?
4. **Filter.** Keep correctness, security, data loss, and plan mismatches. Drop
   style, naming taste, and "could be cleaner" — a reviewer always finds
   something, and fixing all of it over-engineers the code. At most 8 items.
5. **Write** `## Review` in `plan.md` in the format from `references/plan.md`,
   most severe first. Nothing found → `No findings — <what was checked>`.
6. Colour green. Report the count and the top 3 in one line each.

## Rules

- Never edit code, commit, or tick tasks.
- Every finding names a file and line and a concrete fix.
