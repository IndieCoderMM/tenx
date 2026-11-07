# Implementation plan: Cross-phase ADLC interview skill

## Execution notes

- Keep the interview optional and cross-phase.
- Do not create a new phase, gate, transcript, or artifact owner.
- User's direct request approves this scope.

## Tasks

### Phase 1: Define the capability

- [x] **T1. Add the interview skill**
  - Outcome: The skill defines its trigger threshold, interview method, five modes, and handoff.
  - Likely files/components: `adlc/skills/adlc-interview/SKILL.md`
  - Dependencies: None
  - Verification: Read the skill against the approved brief and design.

### Phase 2: Route interviews selectively

- [x] **T2. Connect lifecycle and phase guidance**
  - Outcome: The orchestrator and relevant phase skills invoke the interview only when a meaningful
    decision needs the user's input.
  - Likely files/components: `adlc/skills/adlc/SKILL.md`, `adlc/skills/adlc/references/lifecycle.md`,
    and the brainstorm, architecture, planning, and execution skills
  - Dependencies: T1
  - Verification: Inspect each routing point for phase ownership, optional use, and absence of a new
    gate or artifact.

### Phase 3: Reconcile and verify

- [x] **T3. Update bundle documentation and record evidence**
  - Outcome: The README lists the skill and acceptance criteria have evidence.
  - Likely files/components: `adlc/README.md`, this change folder
  - Dependencies: T1, T2
  - Verification: Read the final skill and integrations; check diff formatting.

## Deferred

- [ ] Separate specification skill; the existing lifecycle reference owns specification guidance.

## Progress log

| Date | Task | Result / follow-up |
|---|---|---|
| 2026-11-01 | T1 | Added the optional cross-phase interview skill with five modes and a meaningful-decision threshold. Skill metadata validation passed. |
| 2026-11-01 | T2 | Added selective invocation guidance to the orchestrator, lifecycle, and relevant phase skills. |
| 2026-11-01 | T3 | Listed the skill in the README and inspected final integrations and artifact ownership. See `verification.md`. |

## Plan changes

None.
