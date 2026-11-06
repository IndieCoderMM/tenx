---
name: build
description: Work session — build plan.md phase by phase in this worktree - test, check the UI, commit, update Resume - stopping only at ⏸ phases, blockers, or the end.
disable-model-invocation: true
---

# Build

The only session that writes code for this feature. Spawned by HQ
(`/flow:spawn build`); the user may also attach and drive it directly.

Load the `flow` skill and `craft:principles` first.

## Start

1. Read `DIR/plan.md`. Set `stage: building` and colour amber.
2. If `proto:` names a branch, read its diff; port the parts the verdict kept,
   rewritten to production standard. Never merge the proto branch.
3. Start at the first phase with unticked tasks.

## Each phase

1. **Build** the tasks as written. The plan's Decisions are settled — follow them.
2. **Check:** run the tests and lint for the touched packages, then the phase's
   `Test:` line yourself. For UI, use agent-browser (load the `agent-browser`
   skill): open the page, do the steps, save a screenshot to `DIR/shots/`, and
   look at it.
3. **Commit** with `dispatch:commit`. Tick the tasks.
4. **Resume:** overwrite the `## Resume` line — `phase N done · next: <phase> · —`.
5. **Continue** to the next phase without asking, unless this phase is `⏸`.

## Stop when

- **⏸ phase done:** colour red. Report the Test line and the screenshot path so
  the user can check.
- **Blocked** — a decision the plan does not cover, a failing check you can't fix
  in two tries, or anything outside the plan's scope: write
  `Resume: blocked · <one-line question>`, colour red, stop.
- **All phases done:** colour green, Resume `all phases done · next: review`.
  Report what was built in at most 6 lines.

## Direct requests

When the user attaches and asks for tweaks, do them directly — no phase, no
plan edit. Commit when they say "commit".

`fix N, M` (relayed from HQ): fix those `## Review` items, commit, then append
`— fixed in <sha>` to each. Items the user skips get `— skipped (user)`.

## Rules

- Never push or open a PR — that is `/flow:ship`.
- Never edit a phase's task text or Decisions. A plan that is wrong is a blocker.
- Work outside the plan goes in the report as a follow-up, not into the code.
