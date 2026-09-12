---
name: execute
description: Execute the current phase of a flow task via a build subagent.
disable-model-invocation: true
---

# Execute

Implement one phase of `tasks.md` through a subagent. Brief, delegate, verify, report.

Load the `flow` skill first.

Arguments: `[slug] [phase] [model]` — all optional. `phase` defaults to the first
phase with unticked items; `model` (e.g. `sonnet`, `opus`, `haiku`) sets the
subagent's model, defaulting to `sonnet`.

## Steps

1. **Orient.** Resolve the slug. Read `contract.md` and `tasks.md`,
   and tail `logs.tsv` for the resume signal. Determine the target phase; if all
   its items are already ticked, say so and stop.
2. **Propose.** Turn the phase's items into a concrete execution todo list in
   chat — files to touch, order of work, how it will be verified — and get the
   user's yes.
3. **Delegate.** Write a self-contained brief to a tmp file: the Problem, the
   relevant Done when conditions, the Invariants, the approved todo list, and
   the paths it needs. Spawn `flow-builder` on the given model with the brief
   path as its prompt.
4. **Report.** Verify the agent's claims against the working tree, then report:
   what was built, what was verified, anything the agent hit that a future
   session needs (log it as a `note` or `decision` row). Suggest `/review <slug>`
   as the next step.

## Rules

- Never spawn the subagent before the user approves the todo list.
- One phase per run; work outside the phase goes to Backlog, not into the brief.
- No flow-doc edits beyond log rows.

## Templates

Todo proposal:

```markdown
Phase N — <name> · model: <model>

**Todos**
1. <todo> — <files>
2. …

Verify by: <how the result will be checked>
```

Report:

```markdown
Phase N — <name>

**Built** <what changed, file:line refs>
**Verified** <checks run and result>
**Notes** <what the agent hit worth keeping, or —>

Next: /review <slug>
```
