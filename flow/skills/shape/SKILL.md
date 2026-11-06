---
name: shape
description: HQ step 1 — turn a ticket into plan.md - implementation decisions, phases, and a hand test per phase - ready for a build session.
disable-model-invocation: true
---

# Shape

Turn a ticket into a plan a build session can run without asking. This step
settles **how**. What and why come from the ticket and are not reopened.

Load the `flow` skill first and read `references/plan.md`. Runs in HQ.

Argument: a ticket id or URL (Linear or GitHub). If `plan.md` already exists for
it, this is a re-shape — propose the exact changes and write only after approval.

## Steps

1. **Read.** Fetch the ticket and its comments. If `DIR/proto/verdict.md`
   exists, read it; the prototype's winning variant is a given.
2. **Map.** Send one Explore subagent to find where the change lands: files,
   existing patterns to reuse, tests that cover the area, how to run the app to
   see it. Use its conclusions; never read files into HQ.
3. **Decide.** Ask the implementation questions the ticket leaves open, at most 5
   numbered per round, each with your recommendation. Skip anything with a
   clear default in the codebase — state the default instead.
4. **Write `plan.md`** from the template: header (`stage: shaped`, `model`, and
   `branch`/`worktree` from git — HQ's current branch and directory),
   Goal from the ticket, numbered Decisions, Phases. Every phase gets a `Test:`
   line; mark `⏸` where the build must stop for the user.
5. **Show** the Goal, Decisions, and phase names with their Test lines — not the
   whole file. The user says go, or asks for changes.

## Rules

- Never reopen a product decision the ticket settled; if the code makes one
  impossible, say so and ask whether to update the ticket.
- No phase without a Test line. No task without a file.
- Prefer fewer, larger phases: each phase is a commit and a stop point.

Next: /flow:spawn build <slug>
