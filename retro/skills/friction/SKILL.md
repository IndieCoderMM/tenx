---
name: friction
description: Capture one workflow friction note — a blocker, an annoying gate, something Claude keeps getting wrong — for the weekly retro.
disable-model-invocation: true
---

# Friction

Record the user's note for the next `/retro`. One command, no questions.

## Steps

1. Run `retro friction "<the user's text, verbatim>"` from the current working
   directory, so the row picks up the repo and branch.
2. Reply with one line: `Logged.` Nothing else — the user is mid-task.

## Rules

- Capture verbatim. Don't reword, summarise, or ask what they meant.
- With no text, ask once: "What got in the way?" and log the answer.
- Never write `~/.tenx/retro/friction.tsv` by hand — only through `retro friction`.
