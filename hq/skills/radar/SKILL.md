---
name: radar
description: HQ — one table of every live hq agent - Herdr state, stage, phase progress, and resume line.
disable-model-invocation: true
---

# Radar

Run `hq-radar` and show its table as-is.

Below it, list only what needs the user, one line each:

- `blocked` agents — what they are asking (read with
  `herdr agent read <name> --lines 30`);
- `idle` or `done` agents whose plan has unread results — a new `## Review`, a
  `proto/verdict.md`, or a Resume line ending in a blocker.

Nothing needs the user → say so in one line.
