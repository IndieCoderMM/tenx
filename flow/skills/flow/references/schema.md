# Flow docs schema

## contract.md

```markdown
# <slug>

stage: brainstorming | building | validating | verifying | shipped | archived
branch: <name>
tracker: <issue url>
pr: <pr url>

## Problem

<1-3 sentences. What is wrong or missing, and for whom.>

## Done when

- [ ] <checkable condition>

## Domain

<Where the relevant code lives and what the terms mean.>

## Invariants

- <constraint later phases must not violate>

## Open questions

- <unresolved question shaping the work>
```

**stage** 
- written by whichever command owns the transition into that stage: `brainstorm` (brainstorming), `architect` and `iterate` (building), `validate` (validating), `verify` (verifying), `ship` (shipped). `revise` may set it back to an earlier stage when the target moves.

**Problem** 
- written by `brainstorm`. Verbatim-protected against every command but `revise` and `iterate`.

**Done when** 
- written by `brainstorm`. Verbatim-protected against every command but `revise` and `iterate`. Each condition must be checkable by someone who did not write it.

> "Layout pipeline is cleaner" — not checkable, reject it.
> "`planComposition` returns a cap-conforming plan for all 14 pattern inputs" — checkable.

`validate` checks the branch against these and nothing else in this file.
`verify` derives its manual steps from them.

Checkboxes are ticked only by `ship`'s gate, from the human-ticked `qa.md` cases covering them.

**Domain** 
- the map, not the design. Under ~200 words.

**Invariants** 
- properties later phases must preserve: "must stay a pure function", "must not touch the render loop", "must work offline".

- This is where `architect` records implementation decisions that **constrain later work**. Decisions that constrain nothing go to the log as `decision` rows.

- Not an architecture section, only constraints. Let the code describe itself.

**Open questions** 
* delete an entry when it resolves and log a `decision` row.
- Never strike it through with the answer appended.

### Revising the contract

Two commands may rewrite an already-written section:

- `revise` — the general case. The target itself moved.
- `iterate` — when a review or QA finding proves the contract wrong mid-cycle,
  so the correction lands with the fixes instead of in a separate pass.

The write is gated, not free, in both:

- the exact edit is proposed in chat and approved before it lands
- a change to `Done when` or `Invariants` gets a `decision` row saying what is
  now true, and a `reversed` row for what it abandons
- ticked `Done when` boxes are never silently unticked or dropped — `ship`'s gate
  reads them, so raise it with the user

Every other command stays read-only on these sections, `stage:` aside.

## tasks.md

```markdown
# <slug> — tasks

**Approach:** <2-3 sentences: the chosen approach and why>

## Phase N — <name>
- [ ] P.N.1 <task name>
  - Files: `src/exact/path.ts:40-62` (modify), `src/exact/new.ts` (create)
  - Decision: <1-4 lines: what changes and why — names, signatures, behavior, edge cases>
  - Check: <input or state → expected result, one per line>
  - Verify: `<exact command>` → <expected result>
- [ ] P.N.2 <task name>
  - …
---
## Iteration N
- [ ] I.N.1 <one line fix>
- [ ] I.N.2 <one line fix>
---
## Backlog
- <unstarted item>
```

### Phases

Written once by `architect`, ticked only by `checkpoint`.

A phase is one unit of accepted work, not one session — it may span several
`execute` runs and light reviews. Size it by asking whether you would sign off
on it as a unit.

`architect` may not add a phase after the fact and `iterate` may not touch this section. 

A task is written so a builder can start it without asking anything:

- **Size** — 2-5 minutes of work. A Decision that needs more than 4 lines is two tasks.
- **Files** — exact repo-relative paths, with line ranges for modifications.
  Every path and line was read while planning. Line ranges are plan-time hints;
  the builder re-locates code by content when an earlier task shifted it.
- **Decision** — what to build and why, not the code. Code appears only where
  the exact text *is* the decision (a regex, a signature, an error string), in
  ≤10 lines.
- **Check** — what proves the task works, specific enough to write the test from:
  `order with no items → 400 "order has no items"`, not "handles empty orders".
- **Verify** — the exact command and its expected result. A manual step when
  nothing can be run.

**Approach** is written once by `architect`, alongside the phases.

> "Update the handler to handle errors" — not a task, reject it.
> "`parseRow` in `src/csv.ts:40-62` throws `RowError(line)` on an unclosed quote" — a Decision.

### Iterations 

Appended by `iterate`, one `## Iteration N` section per cycle, items numbered
`I.N.M` so a log row's `--phase` value is unambiguous.

- Closed the same way a phase is: `checkpoint` ticks and commits.
- Never delete or rewrite a closed block.

### Backlog

Promote into an iteration block when picked up and delete from `Backlog` in the same write.

## qa.md

Written only by `verify`, append new cases for each run, ticked only by the human.

```markdown
# <slug> — verification

## 1. <what this group covers>

generated: YYYY-MM-DD  against: <commit sha>

- [ ] <test case 1>
  - Expected result: <describe the expected result>
  - Feedback: <left empty for human feedback>
```

- Each box is one action and its expected result, phrased so failure is
  unambiguous.

> "Check the form works" — too vague, reject it.
> "Submit with an empty email — inline error under the field, no request fires." — usable.

- Derive steps from `Done when` first, then the accepted phases and iteration
  items, then whatever `validate` flagged as risky.
