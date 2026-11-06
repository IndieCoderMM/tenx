---
name: spawn
description: HQ — start a flow work session in aoe (build, review, or proto), then wait for it in the background.
disable-model-invocation: true
---

# Spawn

Start a work session and get woken when it stops.

Load the `flow` skill first and read `references/aoe.md`. Runs in HQ, from the
feature worktree (proto may also run from the main checkout).

Arguments: `build|review|proto <slug> [...]`.

## Steps

1. **Check.**
   - build: `plan.md` exists with `stage: shaped`. Pass `--model sonnet` when
     the plan's header says `model: sonnet`.
   - review: a `build-<slug>` session exists and its Resume says all phases are done
     (or the user asks for an early review).
   - proto: the user agreed to the question and mode in `/flow:ideate`.
2. **Start.** Run `flow-spawn` with the arguments. On exit 3, give the user the
   attach command and stop.
3. **Wait.** Run `flow-wait <title>` with `run_in_background: true`.
4. **Report** in two lines: the session title and the attach command. HQ is
   free for discussion while the session works.

When the wait returns, follow "When a background wait returns" in the `flow`
skill.

## Relaying

For "fix 1, 3", answers to a waiting session, or "ship it": `aoe send <title>
"<message>"`, then a new background `flow-wait <title>`. Send the user's words
plus the plan section they refer to — never paraphrase a decision.

Next: /flow:board
