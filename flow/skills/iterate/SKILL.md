---
name: iterate
description: Append an iteration block of required changes to a flow task's tasks.md, and revise contract.md when the findings change the contract.
disable-model-invocation: true
---

# Iterate

Turn required changes into the next `## Iteration N` block. Collect, propose, append.

Load the `flow` skill first.

## Steps

1. **Orient.** Resolve the slug. Collect the required changes:
   findings from `/review` or `/validate`, failed `qa.md` cases, user requests,
   and any Backlog items being picked up.
2. **Propose.** Draft the iteration items in chat — one-line fixes, numbered per
   the schema — and get the user's yes. Drop anything that is scope expansion
   rather than a fix; that goes to Backlog instead.
   When a finding changes what the task is aiming at, propose the `contract.md`
   edit in the same message, quoting the current text and the replacement.
3. **Write.** Append one `## Iteration N` block to `tasks.md` per the schema.
   Promoted Backlog items are deleted from Backlog in the same write. Apply the
   approved `contract.md` edits. Set `stage: building`.
4. **Close.** Suggest `/execute <slug>` to work the iteration.

## Rules

- `tasks.md` is append-only — never touch the Phases section or a closed
  iteration block.
- `contract.md` is writable, any section. It is the one command that may revise
  `Problem`, `Done when`, and `Invariants` after `brainstorm` set them — so
  never do it silently: the edit is approved in step 2 or it does not happen,
  and every change to `Done when` or `Invariants` gets a `decision` row naming
  what is now true.
- One block per invocation; the next cycle gets its own.
- No code changes; fixing is `/execute`'s job.
