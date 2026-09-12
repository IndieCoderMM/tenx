---
name: revise
description: Shift a flow task's target — rewrite any section of contract.md and record the reversal in the log.
disable-model-invocation: true
---

# Revise

The contract was written before the work started, so sometimes the work proves it
wrong. Use this when the target itself moves: an assumption failed, the problem
turned out to be a different problem, a decision has to be taken back, the
priority changed.

Not for adding work toward the existing target — that is `/iterate`.

Load the `flow` skill first.

## Steps

1. **Orient.** Resolve the slug. Read `contract.md`, then the log — the tail and
   every `reversed` row — so you argue against what was actually decided, not
   what you assume was.
2. **Understand the shift.** Discuss with the user what changed and why the
   current contract no longer describes the task. Name the sections it reaches.
   Push back once if the shift looks like scope creep wearing a revision's
   clothes; new work toward the same target belongs in `/iterate`.
3. **Propose.** Draft the change in chat, section by section — current text
   quoted, replacement beneath it — and get the user's yes. Say plainly what
   already-built work each edit invalidates.
4. **Write.**
   - Apply the approved edits to `contract.md`. Any section.
   - A `reversed` row for every abandoned `Done when` condition, invariant, or
     logged decision. Then a `decision` row for what replaces it.
   - Set `stage:` only when the shift moves the task back — a rewritten
     `Done when` usually means `building`.
5. **Close.** Report what moved and route: `/iterate` to add work under the new
   target, `/architect` only if the phase split is now meaningless.

## Rules

- Full write access to `contract.md`, every section, `Problem` and `Done when`
  included. The gate is the user's approval in step 3, never your own judgment.
- The log is the point. A contract edited without a `reversed` row leaves the
  next session unable to tell a corrected plan from a forgotten one.
- `logs.tsv` is append-only through `flow-log`. Revising the contract never means
  editing history.
- A ticked `Done when` box was verified by a human. Never drop or reword one
  silently — surface it and let the user decide.
- No `tasks.md`, no code. Phases are `architect`'s, iteration items are
  `iterate`'s, fixes are `/execute`'s.

## Related skills

- `grilling` (mattpocock-skills plugin) — stress-test the shift before proposing it.
- `craft:unslop` — on the proposal.
