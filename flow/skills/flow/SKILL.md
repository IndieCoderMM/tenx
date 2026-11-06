---
name: flow
description: Core rules for the flow workflow — HQ session plus aoe work sessions sharing one plan.md per feature. Load before running any flow command.
---

# Flow

One **HQ** session talks with the user and orchestrates. **Work sessions** run in
aoe (tmux), each in its own directory, and do the hands-on work. They share state
through one file per feature: `plan.md`.

## The loop

```
HQ    /flow:ideate  → (optional) /flow:spawn proto → ticket via dispatch:issue
HQ    /flow:shape <ticket> → plan.md → user says go
HQ    /flow:spawn build → work session runs /flow:build
HQ    /flow:spawn review → work session runs /flow:review → user picks fixes
HQ    relays "fix N, M" and "/flow:ship" to the build session with `aoe send`
HQ    /flow:board — status of every work session, any time
```

## Roles

| Session | aoe title | Directory | Writes |
|---|---|---|---|
| HQ | (any) | repo main checkout | `plan.md` (all but the sections below), tickets |
| build | `build-<slug>` | worktree `<repo>-worktrees/build-<slug>` | code, commits, phase ticks, `Resume`, `stage` |
| review | `review-<slug>` | same worktree as build | `## Review` only — never code |
| proto | `proto-<slug>` | worktree `<repo>-worktrees/proto-<slug>` (route) or main checkout (file) | prototype, `proto/verdict.md` |

- HQ never edits project files. It reads code through an Explore subagent so
  file dumps stay out of its context.
- One session writes code per worktree. Parallel work happens across features,
  never inside one.

## Files

`DIR=~/.tenx/flow/<repo>/<slug>/` where `<repo>` is the main checkout's folder name.

```
plan.md            # the feature's single source of truth
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
2. Report in at most 5 lines: what finished, what needs the user, and
   `aoe session attach <title>` when they should look themselves.
3. If the session is `waiting` on a question, show the question; relay the
   user's answer with `aoe send`.

## Reports

Every command ends with one line: `Next: /flow:<command> <slug>` — or the user's
choice, joined with `|`. Write user-facing text through `craft:unslop`.
