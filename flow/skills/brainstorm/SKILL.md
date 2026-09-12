---
name: brainstorm
description: Start a new flow task — explore a problem with the user, then write contract.md. 
disable-model-invocation: true
---

# Brainstorm

Turn a raw idea into a `contract.md`. Talk first, write last.

Load the `flow` skill first.

## Steps

1. **Explore.** Discuss the idea with the user: what is wrong or missing, for whom,
   and what "done" looks like. Look at the relevant code when it sharpens the
   discussion. Ask one question at a time; stop when Problem and Done when are crisp,
   not when every detail is settled — unknowns go to Open questions.
2. **Propose.** Draft Problem and Done when in chat and get the user's yes.
   Every Done when condition must be checkable by someone who did not write it.
3. **Write.** Resolve the slug (issue-number-prefixed if one exists), create
   `~/.flow/plans/<repo>/<slug>/` and write `contract.md` per the schema with
   `stage: brainstorming`. Fill Domain from what the exploration found; leave
   unresolved items under Open questions.
4. **Close.** Echo the folder path and suggest `/architect <slug>` as the next step.

## Rules

- Never write `contract.md` before the user approves the draft.
- Problem and Done when go in verbatim as approved.
- No plan, no phases, no solution design here — that is `/architect`'s job.

## Related skills

- `research` (mattpocock-skills plugin) — when the exploration needs docs or API facts dug up before Problem and Done when can be pinned.
