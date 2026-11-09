---
name: flow
description: Core rules for the flow workflow — HQ session plus aoe work sessions sharing one plan.md per feature. Load before running any flow command.
---

# Flow

One **HQ** session per feature talks with the user and orchestrates. It runs in
the feature's worktree, which the user creates as usual. **Work sessions** run in
aoe (tmux) in that same worktree and do the hands-on work. They share state
through one file per feature: `plan.md`.

## The loop

```
HQ    /flow:ideate  → (optional) /flow:spawn proto → ticket via dispatch:issue
HQ    /flow:shape <ticket> → plan.md → user says go
HQ    /flow:spawn build → work session runs /flow:build
HQ    /flow:spawn review → work session runs /flow:review → user reads the
      findings in Hunk, adds own notes there, picks fixes
HQ    relays "fix N, M" / "my hunk notes" and "/flow:ship" to the build session
      with `aoe send`
HQ    /flow:board — status of every work session, any time
```

## Roles

| Session | aoe title | Directory | Writes |
|---|---|---|---|
| HQ | (any) | the feature worktree | `plan.md` (all but the sections below), tickets |
| build | `build-<slug>` | HQ's worktree | code, commits, phase ticks, `Resume`, `stage` |
| review | `review-<slug>` | HQ's worktree | `## Review` only — never code |
| proto | `proto-<slug>` | own worktree `<repo>-worktrees/proto-<slug>` (route) or HQ's directory (file) | prototype, `proto/verdict.md` |

- HQ never edits project files or runs git writes, even though it shares the
  worktree. It reads code through an Explore subagent so file dumps stay out of
  its context.
- Only the build session writes code in a worktree. Parallel work happens across
  features (one HQ each), never inside one.
- `/flow:ideate` may run anywhere, including the main checkout. Build and review
  need HQ in a feature worktree.

## Files

`DIR=~/.tenx/flow/<repo>/<slug>/` where `<repo>` is the main checkout's folder name.

```
plan.md            # the feature's single source of truth
review.json        # review findings as Hunk diff notes
proto/             # prototype files, screenshots, verdict.md
shots/             # build screenshots
```

Template and writer rules: `references/plan.md`. **Read it before writing plan.md.**
aoe commands and helper scripts: `references/aoe.md`. **Read it before spawning,
relaying, or waiting.**

These files are local only. Never commit them or mention them in a PR or ticket.

## Resolving `<slug>`

Slugs are kebab-case, prefixed with the ticket id once one exists (`cc-301-bulk-export`).
When omitted:

1. In a work session: the aoe title (`build-<slug>`), else the worktree folder name.
2. In HQ: the most recently modified `DIR` folder containing `plan.md` whose
   `stage` is not `shipped`.
3. Otherwise list the candidates and ask.

Folders without `plan.md` (flow v1 tasks) are ignored.

## When a background wait returns (HQ)

`flow-wait` exits when a work session stops running. Then:

1. Read that feature's `plan.md` (`Resume`, `## Review`, or `proto/verdict.md`).
2. Report what finished, what needs the user, and
   `aoe session attach <title>` when they should look themselves.
3. If the session is `waiting` on a question, show the question; relay the
   user's answer with `aoe send`.

## Reports

Every command ends with one line: `Next: /flow:<command> <slug>` — or the user's
choice, joined with `|`. Write user-facing text through `craft:unslop`.
