# plan.md

## Template

```markdown
# <slug>

stage: shaped | building | reviewing | shipped
ticket: <url>
branch: <name>
worktree: <HQ's worktree path>
model: opus | sonnet
proto: <branch or file> — <one-line verdict, or —>

## Goal

<1-3 sentences. What changes, for whom. Taken from the ticket.>

## Decisions

1. <decision> — <why, one line>

## Phases

### 1. <name> ⏸
- [ ] <task: what changes, in which file(s)>
- [ ] <task>
- Test: <how a person checks this phase by hand: where to go, what to do, what they should see>

### 2. <name>
- [ ] <task>
- Test: <…>

## Review

<written by the review session>

## Resume

<one line, overwritten after every phase: last done · next step · blocker or —>
```

## Writers

| Section | Written by | Rule |
|---|---|---|
| header, Goal, Decisions, Phases | `/flow:shape` | Rewritten only by `/flow:shape` again, after the user approves the change |
| `stage` | shape → `shaped`, build → `building`, review → `reviewing`, ship → `shipped` | |
| phase ticks, `Resume` | `/flow:build` | Ticks only; never edits task text |
| `## Review` | `/flow:review` | Build session marks items `fixed` or `skipped`, never deletes them |

## Phase rules

- A phase is one thing the user would check by hand. Size it by its Test line:
  if the Test needs two unrelated checks, it is two phases.
- Every phase has a `Test:` line. A phase with no visible behavior (a migration,
  a refactor) names the command that proves it instead.
- Mark a phase `⏸` when the build must stop for the user after it: UI they need
  to see, a judgment call, anything costly to redo.
- Tasks name files and the change, not code. Code only where the exact text is
  the decision (a signature, a regex, an error string).
- `model: sonnet` only when every phase is mechanical (renames, wiring, copying a
  proven pattern). Default `opus`.

## Review item format

```markdown
1. [high] `path/file.ts:42` — <what is wrong> → <suggested fix>
2. [med] …
```

Status is appended by the build session: `— fixed in <sha>` or `— skipped (user)`.
