---
name: radar
description: HQ — one table of every live flow work session - status, stage, phase progress, and resume line.
disable-model-invocation: true
---

# Radar

Run `flow-board` and show its table as-is.

Below it, list only what needs the user, one line each:

- `waiting` sessions — what they are waiting on (read their pane with
  `aoe session capture <title> -n 30 --strip-ansi`);
- `idle` sessions whose plan has unread results — a new `## Review`, a
  `proto/verdict.md`, or a Resume line ending in a blocker.

Nothing needs the user → say so in one line.
