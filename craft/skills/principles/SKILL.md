---
name: principles
description: Coding principles for writing and reviewing code — deletion bias, scope discipline, reader load, root causes, proof of work, type discipline. Load before implementing or reviewing any change.
---

# Principles

## 1. Laziness protocol

**Directive: Aim for the best result with the least code and complexity. Be lazy. Be simple.**

Writing code is cheap for you, which makes over-engineering easy. Borrow a
human maintainer's fatigue. If a developer would find the result exhausting to
maintain, it is a bad solution however elegant it looks.

- Prefer deletion. When asked to refactor or improve, look for removals before additions.
- Maintain a flat hierarchy. Avoid deep abstractions.
- Consolidate decisions. Do not repeat the same choice in several places.
- Minimize the diff. Make the smallest change that solves the problem.

## 2. Substract before adding

**Directive: Remove complexity first before building or evolving a system.** 

Adding to a complex system compounds complexity. Removing first cuts the surface area, reveals the essential structure, and usually makes the next design obvious. Default to subtraction.

- Sequence removal before construction
- Cut before you polish (get to the minimum before investing in quality)
- Design for observed usage, not speculative edge cases
- No speculative validators, parsers, or guards beyond what the spec demands
- Out-of-spec features drag validators behind them. Persistence, retry-on-startup, and schema migration each need guards to defend their inputs.

## 3. No comments

**Directive: Comments are a code smell. Avoid them.**

- **Default zero.** Code should be self-explanatory.
- No reasoning comments, no "why" or "how" comments.
- No section banners, no restating the next line, no "// Step 1".
- Never leave behind commented-out code or migration-narration comments ("previously we...", "changed to...").
- Allowed only when it is truly needed to explain a complicated edge case or decision.

## 4. Be pragmatic

**Directive: Local code changes still have system-level consequences. Own the result beyond the edit.**

### Decision rules

- Be pragmatic, not dogmatic: choose what improves real outcomes, not ceremony or shortcuts.
- Keep one authoritative source for each piece of system knowledge.
- Preserve orthogonality so unrelated concerns, business rules, views, and volatile details do not change together.
- Keep important choices reversible until evidence justifies commitment.
- Learn through thin working slices, prototypes, examples, tests, and fast feedback without fossilizing shortcuts.
- Automate repeatable work, keep it versioned, and favor inspectable text or scripts where longevity and recovery matter.
- Make assumptions, contracts, failure boundaries, diagnostics, resource ownership, cleanup, and ordering explicit.
- Treat shared mutable state, globals, ambient context, and async complexity as visible costs.
- Debug from reproduced facts and measured behavior, not coincidence or blame.
- Run relevant automatic tests before calling work done.
- Dig for real requirements behind stated solutions and current implementation details.
- Leave touched code, docs, tests, tooling, and process in a condition you can stand behind.

### Trigger rules

- When knowledge is copied, choose one owner and derive or trace the rest.
- When changes fan out widely, restore orthogonality.
- When a decision is uncertain or hard to reverse, seek feedback or make the step smaller.
- When manual steps repeat, automate and version them.
- When behavior is unexplained, generated, scaffolded, or tool-derived, inspect and prove it before relying on it.
- When errors, resources, state, locks, or ordering cross boundaries, make recovery and cleanup ownership explicit.
- When requirements sound like implementation details, restate the durable need before building.

