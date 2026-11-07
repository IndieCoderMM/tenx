---
name: adlc-architecture
description: Investigate the existing codebase and produce a proportionate technical design, recording only consequential, durable architectural decisions as ADRs.
---

# ADLC Architecture and Decisions

## Goal

Translate approved product requirements into a technical design that fits the existing system,
makes trade-offs explicit, and avoids unnecessary complexity.

## Investigation

Before recommending a design:
- Read project instructions and `.adlc/PROJECT.md`.
- Inspect relevant modules, data flow, interfaces, dependencies, tests, and current architecture docs.
- Follow existing conventions unless there is evidence they are inadequate.
- Distinguish observed implementation facts from assumptions.

Do not perform a broad codebase rewrite or produce a file-by-file inventory.

## Design process

1. Identify the system boundaries and components affected.
2. Describe responsibilities and data/control flow.
3. Consider data shape, state ownership, API/event contracts, persistence, error handling, and
   compatibility where relevant.
4. Compare only plausible alternatives. Usually two or three are enough.
5. Recommend the simplest option that meets approved requirements.
6. Identify migration, rollout, failure, security/privacy, and operational concerns when relevant.
7. Define what is intentionally deferred.

Use `adlc-interview` in architecture mode when a consequential choice still requires the user's
judgment. Follow approved decisions and existing conventions for routine implementation choices.

## ADR policy

Create an ADR only when a decision is:
- cross-cutting or likely to affect future features;
- expensive or difficult to reverse;
- a change to a public interface or persistent data contract;
- consequential for security, privacy, reliability, or deployment;
- likely to be questioned by a future maintainer.

Do not create ADRs for ordinary local implementation choices.

Store ADRs at `.adlc/architecture/decisions/ADR-NNN-short-title.md`, using
`../../templates/adr.md`.
Use sequential numbering based on existing files. Include context, drivers, options, decision,
consequences, and revisit conditions. Never silently rewrite an accepted ADR; supersede it with a
new decision and link the two.

## Artifact

Create/update `.adlc/changes/<slug>/design.md` using `../../templates/design.md`. Update
`.adlc/architecture/overview.md` only when the system-level map has materially changed.

Keep the design at the level needed to guide implementation. Avoid speculative classes, interfaces,
or abstractions that are not justified by current requirements.

## Approval boundary

Present the recommendation and meaningful trade-offs. Obtain explicit approval for consequential
choices involving data models, persistence, public contracts, system boundaries, migrations,
security/privacy, or expensive-to-reverse dependencies.

Routine implementation details may be delegated within the approved design.

## Handoff

Summarize the selected approach, rejected alternatives, risks, ADRs created, and unresolved choices.
Then hand off to specification finalization and task planning.
