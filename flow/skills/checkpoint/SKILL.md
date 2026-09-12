---
name: checkpoint
description: Accept the current phase — verify, commit, tick tasks.md, log the done row.
disable-model-invocation: true
---

# Checkpoint

The accept gate. Invoking it is the acceptance — verify, commit, close.

Load the `flow` skill first.

## Steps

1. **Orient.** Resolve the slug. Identify the phase or iteration
   block being accepted (argument, else the one in progress). If items are
   incomplete, say which and stop — a partial phase is not accepted.
2. **Verify.** Check the diff and stage. Ensure no files outside the scope were touched.
3. **Commit**: Use `dispatch:commit` skill to commit with a concise message.
4. **Docs**: Update `flow` docs.
   - Tick the phase's (or iteration's) boxes in `tasks.md`.
   - Log a `done` row via `flow-log` with `--phase` and the commit SHA as `--ref`
5. **Report.** State what was accepted and name the next open phase or
   iteration item, or suggest `/validate <slug>` when none remain.

## Related skills

- `dispatch:commit` — writes the message and commits.
