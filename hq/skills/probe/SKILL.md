---
name: probe
description: HQ — start a work session as a Claude agent in a Herdr pane (builder, reviewer, or scout), then wait for it in the background.
disable-model-invocation: true
---

# Probe

Start a work session and get woken when it settles.

Load the `hq` skill first and read `references/herdr.md`. Runs in HQ, from the
feature worktree (scout may also run from the main checkout).

Arguments: `builder|reviewer|scout <slug> [...]`.

## Steps

1. **Check.**
   - builder: `plan.md` exists with `stage: shaped`. Pass `--model sonnet` when
     the plan's header says `model: sonnet`.
   - reviewer: a `builder-<slug>` agent exists and its Resume says all phases are done
     (or the user asks for an early review).
   - scout: the user agreed to the question and mode in `/hq:comms`.
2. **Start.** Run `hq-probe` with the arguments and `run_in_background: true`.
   It returns when the agent settles; exit 3 means the agent is blocked at
   startup — tell the user to answer it with `herdr agent focus <name>` and stop.
3. **Report** in two lines: the agent name and `herdr agent focus <name>`. HQ is
   free for discussion while the agent works.

When `hq-probe` returns, follow "When a background wait returns" in the `hq`
skill.

## Relaying

For "fix 1, 3" or "ship it": `herdr agent prompt <name> "<message>" --wait` with
`run_in_background: true`. Send the user's words plus the plan section they
refer to — never paraphrase a decision. A `blocked` agent rejects prompts; answer
it as in `references/herdr.md`.

Next: /hq:radar
