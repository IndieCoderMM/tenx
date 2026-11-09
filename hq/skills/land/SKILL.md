---
name: land
description: HQ — after the feature's PR merges, close its work-session panes, remove the scout worktree, and mark plan.md landed. HQ itself stays.
disable-model-invocation: true
---

# Land

The last step of a feature. Runs in HQ, from the feature worktree, after the PR
merged. Being asked to land is the approval to close and delete.

Load the `hq` skill first.

Argument: `<slug>` (resolved as in the `hq` skill).

## Steps

1. **Check.** `plan.md` says `stage: shipped`. If not, say what stage it is in
   and stop unless the user overrides.
2. **Run** `hq-land <slug>`. It refuses when the PR is not merged — report its
   message and stop.
3. **Report** its output: what was closed and removed, and that HQ, the feature
   worktree, and its branch are left for the user to remove.

## Rules

- Never pass a refusal by deleting or forcing anything by hand.
- Never touch HQ's own pane, workspace, worktree, or branch.
