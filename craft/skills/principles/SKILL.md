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

