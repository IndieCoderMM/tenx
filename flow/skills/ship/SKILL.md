---
name: ship
description: Work session — final checks, push, open the PR, and update the ticket for a built and reviewed feature.
disable-model-invocation: true
---

# Ship

Run in the build session, usually relayed from HQ as `/flow:ship`. Being asked to
ship is the approval to push.

Load the `flow` skill first.

## Steps

1. **Gate.** Every phase ticked, and every `## Review` item marked fixed or
   skipped. If not, list what is left and stop unless the user overrides.
2. **Clean.** Format, lint, and run the project's full test command. Sweep the
   diff for debris: debug output, stray TODOs, dead code from abandoned
   approaches. Commit cleanup with `dispatch:commit` (deletion and formatting
   only — behavior changes go back to `/flow:build`).
3. **Push** with upstream set.
4. **PR.** `dispatch:pr`. Its how-to-test comes from the phases' Test lines.
5. **Ticket.** Link the PR on the ticket and move it to the team's review state
   if it has one.
6. **Close.** `stage: shipped`, Resume `shipped · <pr url>`, colour green.

## Rules

- Never mention `plan.md` or flow in the PR or ticket.
- A failing check blocks the push — fix it in `/flow:build` or ask.

Next: after merge, `aoe remove build-<slug>` and `aoe remove review-<slug>`
