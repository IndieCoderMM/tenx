# Feature Brief: ADLC role agents

- **Status:** Verified
- **Owner:** Repository maintainer
- **Created:** 2026-11-01
- **Related capabilities:** ADLC implementation, code review, and verification

## Problem
ADLC has focused workflow skills but no reusable agent definitions for bounded implementation and independent review or verification.

## Intended outcome
Add role agents with distinct tool access and connect them to the matching ADLC skills, while keeping decisions and `.adlc/` records with the coordinator.

## Users and scenarios
The repository maintainer uses ADLC for feature work and wants agents to take independent, bounded tasks after the feature scope and plan are approved.

## Desired behavior
The builder implements one approved task within its assigned scope. The reviewer reports findings without edits. The verifier maps acceptance criteria to fresh evidence without editing code or ADLC records.

## Scope
### In scope
- Add `adlc-builder`, `adlc-reviewer`, and `adlc-verifier` definitions under `adlc/agents/`.
- Route implementation, review, and verification through those roles where appropriate.
- Keep the main coordinator as the single writer for ADLC artifacts and approval gates.

### Out of scope
- Add a permanent discovery or architecture agent.
- Change product behavior, approval gates, or the existing Flow agents.
- Parallelize tasks that share files or depend on unresolved decisions.

## Requirements
### Functional
- [x] The builder can edit assigned implementation files but not `.adlc/` records.
- [x] The reviewer and verifier have no write or edit tools.
- [x] ADLC skills describe when and how to delegate to each role.
- [x] The coordinator validates agent reports and owns all ADLC status updates.

### Quality attributes
Agent scopes and tool access must make ownership clear and prevent the roles from making product decisions or silently expanding approved scope.

## Edge cases and failure states
- Stop and return to the coordinator if a task lacks a boundary, requirements conflict, or a new consequential decision appears.
- Report checks as unavailable when they cannot be run safely; do not claim success without output.

## Assumptions
- Confirmed: ADLC is installed as a Tenx plugin and uses the repository's Markdown agent-definition format.
- Confirmed: The user approved these three roles and their boundaries with "go ahead" on 2026-11-01.

## Open questions
None.

## Acceptance criteria
- [x] Three role agents exist with distinct tool permissions and scoped instructions.
- [x] Execution, review, and verification skills delegate to the corresponding role and retain coordinator ownership of ADLC artifacts.
- [x] ADLC documentation states that parallel implementation is only for independent approved tasks.

## Decisions
See [design.md](design.md).

## Change log
- 2026-11-01: User approved creating builder, reviewer, and verifier agents.
