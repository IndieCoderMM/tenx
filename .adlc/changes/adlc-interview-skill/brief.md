# Feature brief: Cross-phase ADLC interview skill

- **Status:** Verified
- **Owner:** Repository maintainer
- **Created:** 2026-11-01
- **Related capabilities:** ADLC discovery, architecture, specification, planning, and execution

## Problem

ADLC has phase-specific guidance for asking questions, but no reusable interview capability for
meaningful decisions that arise at different points in the lifecycle.

## Intended outcome

Provide an optional skill that helps the coordinator ask the user focused questions when a decision
could materially change the feature or block safe progress, while leaving routine implementation
choices to the coordinator.

## Users and scenarios

The ADLC coordinator invokes the skill during discovery, architecture, specification, planning, or
implementation when the relevant artifacts and repository evidence do not resolve a meaningful
decision.

## Desired behavior

The skill is complementary, not a lifecycle phase or approval gate. It investigates first, explains
the concrete decision and consequences, asks focused questions only when needed, and returns the
decision to the owning phase skill for recording.

## Scope

### In scope

- Add `adlc-interview` with discovery, architecture, specification, planning, and implementation
  modes.
- Define when a decision merits user input and when the coordinator should use judgment.
- Connect the skill selectively to the relevant ADLC lifecycle and phase skills.

### Out of scope

- Add a new lifecycle phase or approval gate.
- Create a separate interview artifact or store interview transcripts.
- Ask the user to approve routine, reversible implementation details.

## Requirements

### Functional

- [x] The skill supports the five cross-phase interview modes.
- [x] The skill asks only when an unresolved decision could materially change scope, behavior,
  architecture, the approved plan, or safe progress.
- [x] Phase skills invoke it selectively and retain ownership of existing artifacts and approval
  gates.

### Quality attributes

Keep the instructions short enough to load on demand and clear enough to prevent unnecessary
questions or new workflow gates.

## Edge cases and failure states

- If approved artifacts or repository evidence already resolve the question, continue without asking.
- If only part of implementation is blocked, pause the affected work and continue independent safe
  tasks.
- If the user asks the coordinator to use judgment, decide within approved constraints and record
  any relevant assumption in the phase artifact.

## Assumptions

- Confirmed: The user wants a complementary capability, not another ADLC phase.
- Confirmed: The user wants the skill to avoid questions about minor implementation details.

## Open questions

None.

## Acceptance criteria

- [x] An `adlc-interview` skill describes all five modes and distinguishes meaningful decisions from
  routine details.
- [x] The main lifecycle and relevant phase skills can invoke it without adding a phase, gate, or
  interview log.
- [x] The phase owner remains responsible for recording decisions in existing artifacts.

## Decisions

See [design.md](design.md).

## Change log

- 2026-11-01: User requested a cross-phase interview capability and specified its five modes and
  decision threshold.
