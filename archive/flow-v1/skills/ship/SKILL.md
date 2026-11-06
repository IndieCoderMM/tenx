---
name: ship
description: Close out a flow task — final cleanup, open the PR, mark shipped.
disable-model-invocation: true
---

# Ship

The release step. Clean up, open the PR, close the task out.

Load the `flow` skill first.

## Steps

1. **Gate.** Resolve the slug. Tick each Done when box whose
   `qa.md` cases are all human-ticked — only ship ticks these. Done when boxes
   still unticked or open iteration items mean the task is not ready — report
   what is left and stop unless the user overrides.
2. **Clean.** Format, lint, and sweep the branch for debris (debug output,
   stray TODOs, dead code from reversed approaches). Run the project's full
   checks. Commit any cleanup with `dispatch:commit`.
3. **PR.** Invoke `dispatch:pr` to draft and open the PR from the branch
   diff. Write the PR url into `contract.md`'s `pr:` field.
4. **Close.** Set `stage: shipped` and log a `note` row with the PR url as
   `--ref`.

## Rules

- Never open the PR before the gate passes or the user overrides it.
- Cleanup is deletion and formatting only — behavior changes go through
  `/iterate`.
- Never reference flow docs in the PR — they are local-only.

## Related skills

- `dispatch:pr` — drafts and opens the PR.
- `dispatch:commit` — the cleanup commit.
