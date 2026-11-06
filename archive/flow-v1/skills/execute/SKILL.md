---
name: execute
description: Execute the current phase of a flow task via a build subagent.
disable-model-invocation: true
---

# Execute

Implement one phase of `tasks.md` through a subagent. Delegate, verify, report.

Load the `flow` skill first.

Arguments: `[slug] [phase] [model]` — all optional. `phase` defaults to the first
phase or iteration block with unticked items; `model` (e.g. `sonnet`, `opus`, `haiku`)
sets the subagent's model, defaulting to `sonnet`.

## Steps

1. **Orient.** Resolve the slug. Read `contract.md` and `tasks.md`,
   and tail `logs.tsv` for the resume signal. Determine the target phase; if all
   its items are already ticked, say so and stop.
2. **Delegate.** Spawn `flow-builder` on the given model. Its prompt is the task
   folder path, the phase id (`2` or `I.1`), and any log notes the builder needs
   (a prior block, a finding an iteration item came from). Paths only — never
   paste contract or task text; the builder reads the files.
3. **Report.** Verify the agent's claims against the working tree, then report:
   what was built, what was verified, anything the agent hit that a future
   session needs (log it as a `note` or `decision` row).

## Rules

- The phase was approved in `/architect` — delegate it as written. An item too
  vague to build without guessing waits for the user before delegating.
- One phase per run; work outside the phase goes to Backlog, not into the prompt.
- No flow-doc edits beyond log rows.

## Template — report

```markdown
Phase N — <name> · model: <model>

**Built** <what changed, file:line refs>
**Verified** <checks run and result>
**Notes** <what the agent hit worth keeping, or —>

Next: /review <slug>
```
