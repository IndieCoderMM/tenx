# Implementation Plan: ADLC role agents

## Execution notes
- Keep each agent's permissions and input scope narrow.
- The coordinator owns `.adlc/` artifacts and verifies agent claims before recording progress.
- User approved this three-role plan with "go ahead" on 2026-11-01.

## Tasks

### Phase 1 — Agent roles
- [x] **T1. Add the builder, reviewer, and verifier definitions**
  - Outcome: Three role agents exist under `adlc/agents/` with distinct permissions and receipts.
  - Likely files/components: `adlc/agents/`
  - Dependencies: None
  - Verification: Inspect frontmatter and boundaries against the design.

### Phase 2 — Workflow integration
- [x] **T2. Route execution, review, and verification through the agents**
  - Outcome: Focused ADLC skills assign the right bounded work and preserve coordinator ownership.
  - Likely files/components: `adlc/skills/adlc-executing-plans/`, `adlc/skills/adlc-code-review/`, `adlc/skills/adlc-verification/`, `adlc/skills/adlc-writing-plans/`
  - Dependencies: T1
  - Verification: Read each skill and confirm delegation, fallback, scope, and artifact ownership instructions.

### Phase 3 — Reconcile
- [x] **T3. Update architecture context and review the complete diff**
  - Outcome: The architecture overview describes optional plugin agents; all acceptance criteria have evidence.
  - Likely files/components: `.adlc/architecture/overview.md`, this change folder
  - Dependencies: T1, T2
  - Verification: Inspect all changed files and map each acceptance criterion to the resulting agent definitions or skill instructions.

## Deferred
- [ ] A discovery/architecture scout agent, pending repeated need.

## Progress log
| Date | Task | Result / follow-up |
|---|---|---|
| 2026-11-01 | T1 | Added scoped builder, reviewer, and verifier definitions. |
| 2026-11-01 | T2 | Wired the roles into ADLC execution, review, and verification; documented bounded parallelism and host fallback behavior. |
| 2026-11-01 | T3 | Updated architecture context and manually checked definitions, skill handoffs, compatibility notes, and diff formatting. See `verification.md`. |

## Plan changes
None.
