---
name: architect
description: Plan an approved flow task — settle the approach, split it into phases, write build-ready tasks into tasks.md.
disable-model-invocation: true
---

# Architect

Turn an approved `contract.md` into phases of build-ready tasks in `tasks.md`.
Decide first, write last.

Load the `flow` skill first, then read the `tasks.md` section of `references/schema.md` —
it defines the task format this skill writes.

## Steps

1. **Resolve.** Resolve the slug. Read `contract.md`; if there is no
   approved Problem and Done when, stop and point to `/brainstorm`.
2. **Decide.** Explore the relevant code and settle the implementation approach
   with the user using `/grilling`.
3. **Propose.** Draft the Approach and the phase split in chat — phase names and
   one line per task — and get the user's yes. Size each phase as one unit of
   accepted work, not one session.
4. **Detail.** Expand every task into the schema's task format: Files, Decision,
   Check, Verify. Read the code behind each path and line range — a fact you
   cannot point to at a `file:line` is unverified: read until you can, or drop
   the task that rests on it.
5. **Self-check.** Fix every gap in place before writing:
   - **Coverage** — every Done when condition maps to at least one task. A
     condition with no task gets one now.
   - **Concrete** — every task has Files, Decision, Check, and Verify. No `TBD`,
     "handle errors", "as needed", or "same as P.N.M"; replace each with the
     actual decision.
   - **Consistent** — a name, signature, or path introduced in one task matches
     its use in every later task.
   - **Review Focus** — list up to 5 inputs the contract implies but never names
     (the empty list, the duplicate, the rerun), per the schema. Pin each with a
     Check in the task that owns the code; none found → `None found — <why>`.
6. **Write.**
   - Approach, Review Focus, phases, and tasks into `tasks.md` per the schema (`P.N.M` ids).
   - Decisions that constrain later work → `contract.md` Invariants.
   - Other adopted decisions → `decision` rows via `flow-log`.
   - Delete resolved Open questions and log each resolution as a `decision` row.
   - Set `stage: building`.
7. **Close.** Echo the `tasks.md` path and end with `Next: /execute <slug>`.

## Rules

- Never write before the user approves the phase split.
- Phases are written once — adding work later is `/iterate`'s job, not yours.
- Never touch Problem or Done when.
- No code changes; planning only.
- Carried-over claims from earlier tasks or the contract get re-read, not trusted.

## Related skills

- `grilling` (mattpocock-skills plugin) — stress-test the approach and phase split before proposing.
- `craft:unslop` — on the proposal.
