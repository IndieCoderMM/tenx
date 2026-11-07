---
name: adlc-interview
description: Facilitate a focused ADLC interview when a meaningful unresolved decision affects feature intent, architecture, behavior, planning, or safe implementation progress.
---

# ADLC interview

## Purpose

Use this skill as a complementary capability at any ADLC phase. It is not a lifecycle phase, an
approval gate, or a separate artifact. Invoke it only when a decision still needs the user's input
and the answer could change scope, user-visible behavior, architecture, the approved plan, or whether
work can safely continue.

Do not ask the user to choose routine, low-impact implementation details. Follow existing project
conventions for reversible choices. Record a useful assumption when it affects later work. If the
approved artifacts and repository evidence already settle a question, proceed without asking.

## Method

1. Identify the current ADLC phase and read its relevant approved artifacts. Inspect current behavior
   or code when that can answer the question without user input.
2. State the specific unresolved decision and why it matters. Separate known facts from assumptions.
3. Offer a recommendation and the few plausible alternatives that change the outcome. Explain each
   option's practical consequence in plain language.
4. Ask one focused question at a time. Combine questions only when the choices depend on each other.
5. After the answer, summarize the decision. Ask a follow-up only if a consequential ambiguity
   remains. Stop once the decision is clear enough for the phase to continue.
6. Return the decision to the phase owner. The phase owner updates its existing artifact; this skill
   does not create an interview log or change phase status.

If the user asks the agent to use its judgment, choose within approved constraints and continue. If a
decision blocks only part of the work, identify the affected work and continue with independent tasks
that remain safe and within scope.

## Interview modes

Choose the mode that matches the current phase. Do not run all modes as a checklist.

- **Discovery:** Clarify the user, problem, desired outcome, constraints, and scope. Ask what we are
  building only where the answer materially changes the brief.
- **Architecture:** Compare viable approaches when a choice changes system boundaries, data, public
  contracts, persistence, security, or another consequential design concern. Leave routine local
  implementation choices to the engineering convention.
- **Specification:** Resolve ambiguity in observable behavior. Use a concrete scenario or example to
  clarify defaults, edge cases, and failure behavior only where different answers change what the
  product does.
- **Planning:** Surface meaningful choices about scope, task boundaries, sequencing, dependencies, or
  deferred work. Let the user review and approve the plan through the existing planning gate; do not
  turn every task detail into a separate question.
- **Implementation:** Use only when new evidence reveals a meaningful conflict, scope change, or
  blocker that the approved brief, design, or plan does not resolve. Present the evidence and
  options, pause the affected work, and return to the appropriate approval gate before changing
  approved behavior. Do not ask about ordinary coding details.

## Handoff

Return the confirmed decision, any remaining assumption, and the artifact the phase owner should
update. If no meaningful decision needs the user's input, say so briefly and let the phase continue.
