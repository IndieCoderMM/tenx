---
name: architect
description: Plan an approved flow task — settle the approach, split it into phases, write tasks.md.
disable-model-invocation: true
---

# Architect

Turn an approved `contract.md` into phases in `tasks.md`. Decide first, write last.

Load the `flow` skill first.

## Steps

1. **Resolve.** Resolve the slug. Read `contract.md`; if there is no
   approved Problem and Done when, stop and point to `/brainstorm`.
2. **Decide.** Explore the relevant code and settle the implementation approach
   with the user using `/grilling`.
3. **Propose.** Draft the phase split in chat — phase names and their tasks —
   and get the user's yes. Size each phase as one unit of accepted work, not one
   session.
4. **Write.**
   - Phases and tasks into `tasks.md` per the schema (`P.N.M` ids).
   - Decisions that constrain later work → `contract.md` Invariants.
   - Other adopted decisions → `decision` rows via `flow-log`.
   - Delete resolved Open questions and log each resolution as a `decision` row.
   - Set `stage: building`.
5. **Close.** Echo the folder path and suggest `/execute <slug>` as the next step.

## Rules

- Never write before the user approves the phase split.
- Phases are written once — adding work later is `/iterate`'s job, not yours.
- Never touch Problem or Done when.
- No code changes; planning only.

## Related skills

- `grilling` (mattpocock-skills plugin) — stress-test the approach and phase split before proposing.
- `craft:unslop` — on the proposal.
