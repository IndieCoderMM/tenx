---
name: adlc-writing-plans
description: Convert an approved feature brief and technical design into a dependency-aware, incremental implementation plan with clear outcomes and verification for each task.
---

# ADLC Writing Plans

## Goal

Produce an actionable plan that an agent can execute in small, reviewable increments without
reinterpreting the feature.

## Inputs

Read the approved `brief.md`, `design.md`, affected current specs, relevant ADRs, and project
instructions. Inspect the codebase enough to ground task boundaries in the actual repository.

If the brief/design conflict or a key decision is unresolved, stop and return to the appropriate
ADLC phase rather than inventing an answer.

## Planning rules

- Organize by user-visible capability or coherent dependency, not mechanically by frontend/backend.
- Prefer vertical slices that can be implemented and verified independently.
- Keep tasks small, but do not split work into meaningless microtasks.
- State each task's outcome, likely areas/files, dependencies, and verification method.
- Include integration and error-state work, not just the happy path.
- Include tests only where risk and behavior justify them; do not prescribe a test for every function.
- Include migration, accessibility, security, documentation, and observability tasks only when
  applicable.
- Identify prerequisites and critical sequencing.
- Mark deferred ideas explicitly rather than hiding them in implementation.
- Avoid specifying exact line numbers; they become stale.
- Do not prescribe implementation details already left intentionally open by the design.

## Task quality

A task is ready when:
- its purpose is unambiguous;
- its expected result can be inspected;
- dependencies are known;
- a proportionate verification method exists;
- it can be completed without broad unrelated changes.

If a task is too large, split it along meaningful behavior or integration boundaries. If it is too
small, combine it with a related task.

## Artifact

Create/update `.adlc/changes/<slug>/tasks.md` using `../../templates/tasks.md`.

Use stable task identifiers (`T1`, `T2`, etc.) so progress can be discussed. Include:
- phases or milestones;
- ordered task list;
- dependencies;
- outcome and verification;
- deferred work;
- progress log.

Do not mark tasks complete during planning.

## Approval

Summarize sequencing, risk, task boundaries, and what is deferred. Wait for user approval before
implementation begins. If the user asks to skip formal approval, record that instruction and proceed
within the already approved scope.

## Handoff

Tell the executor which task is first, what context it must read, and what constitutes completion.
