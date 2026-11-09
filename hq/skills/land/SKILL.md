---
name: land
description: HQ — after the feature's PR merges, remove everything it left behind - agent panes, scout worktree, feature worktree and branch - and close HQ's workspace.
disable-model-invocation: true
---

# Land

The last step of a feature. Runs in HQ, from the feature worktree, after the PR
merged. It deletes the worktree and ends this session, so it asks once before
running.

Load the `hq` skill first.

Argument: `<slug>` (resolved as in the `hq` skill).

## Steps

1. **Check.** `plan.md` says `stage: shipped`. If not, say what stage it is in
   and stop unless the user overrides.
2. **Say what goes**, in one list: the agent panes (`builder-<slug>`,
   `reviewer-<slug>`, `scout-<slug>` that exist), the scout worktree and
   `<slug>-scout` branch if any, the feature worktree and branch, and this
   workspace with every pane in it — name panes that are not hq agents (a dev
   server, Hunk). `plan.md` stays. Wait for the user's go.
3. **Run** `hq-land <slug>`. It refuses when the PR is not merged, local HEAD is
   not the merged PR head, or the worktree has uncommitted changes — report its
   message and stop. On success it closes this workspace, so this session ends;
   there is no report after it.

## Rules

- Never pass a refusal by deleting or forcing anything by hand. The user fixes
  the cause, then runs `/hq:land` again.
