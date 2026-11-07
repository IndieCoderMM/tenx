---
name: adlc-brainstorm
description: Collaboratively clarify a feature idea, investigate relevant existing behavior, challenge assumptions, and create a durable feature brief before technical planning.
---

# ADLC Brainstorm

## Goal

Turn an initial idea into an agreed problem, outcome, scope, and observable requirements. This is
a discovery conversation, not a coding or architecture-design phase.

## Method

1. Restate the intent briefly and identify what is already clear.
2. Inspect the relevant application areas, existing capability specs, and user flows before asking
   questions. Report only findings that affect the feature.
3. Identify the user problem, primary scenario, desired outcome, constraints, and likely edge cases.
4. Ask focused questions where the answer changes product behavior or scope. Do not interrogate the
   user about details that can safely be decided later.
   Use `adlc-interview` in discovery mode when a meaningful decision remains unresolved; skip it for
   routine clarifications or when the user's intent is already clear.
5. Offer alternatives when there are genuinely different product directions. Explain trade-offs in
   plain language.
6. Challenge assumptions respectfully. Separate facts from guesses and label unresolved assumptions.
7. Define explicit non-goals to prevent scope creep.
8. Draft acceptance criteria as observable outcomes, not implementation steps.

## Discussion rules

- Do not prematurely choose databases, libraries, state-management patterns, or file structures.
- Do not create implementation tasks.
- Do not treat the first idea as a complete requirement.
- Do not ask every possible question upfront; use progressive clarification.
- If the user wants to proceed with ambiguity, record the assumption and its risk rather than blocking
  on low-impact details.
- If the feature is small and obvious, keep discovery lightweight.

## Artifact

Create/update `.adlc/changes/<slug>/brief.md` using `../../templates/feature-brief.md`.

The brief must distinguish:
- confirmed requirements;
- assumptions;
- open questions;
- in-scope behavior;
- explicit non-goals;
- acceptance criteria.

Set status to `Exploring` until the user confirms the brief. After explicit approval, set it to
`Approved` or `Ready for design` and record the approval date.

## Handoff

Provide a concise summary of:
- problem and intended outcome;
- agreed scope and exclusions;
- acceptance criteria;
- unresolved questions or assumptions;
- next phase: architecture/design.

Do not start implementation planning unless requested by the ADLC orchestrator.
