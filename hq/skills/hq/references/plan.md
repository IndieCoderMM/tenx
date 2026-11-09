# plan.md

## Template

```markdown
# <slug>

stage: shaped | building | reviewing | shipped
ticket: <url>
branch: <name>
worktree: <HQ's worktree path>
model: opus | sonnet
size: <XS-XL> <bar> — <driver, from craft:size>
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

<written by the reviewer>

## Resume

<one line, overwritten after every phase: last done · next step · blocker or —>
```

## Writers

| Section | Written by | Rule |
|---|---|---|
| header, Goal, Decisions, Phases | `/hq:chart` | Rewritten only by `/hq:chart` again, after the user approves the change |
| `stage` | chart → `shaped`, builder → `building`, reviewer → `reviewing`, launch → `shipped` | |
| phase ticks, `Resume` | `/hq:builder` | Ticks only; never edits task text |
| `## Review` | `/hq:reviewer` | Build session marks items `fixed` or `skipped`, never deletes them |

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

Status is appended by the builder: `— fixed in <sha>` or `— skipped (user)`.

## Hunk notes — `DIR/review.json`

The reviewer also writes its findings as a Hunk sidecar, so the user sees
them inline in the diff. Same numbers and text as `## Review`; paths are
repo-relative; `newRange` is the finding's line (`oldRange` for a deleted line).

```json
{"version": 1, "files": [
  {"path": "apps/web/src/file.ts", "annotations": [
    {"id": "1", "newRange": [42, 42], "summary": "1. [high] <what is wrong> → <suggested fix>"}
  ]}
]}
```

User notes written in Hunk (`c`) live only in the open Hunk window. The build
session reads them with `hunk session comment list --repo <worktree> --type user --json`.
