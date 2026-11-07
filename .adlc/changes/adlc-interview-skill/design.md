# Technical design: Cross-phase ADLC interview skill

## Summary

Add one focused `adlc-interview` skill and route to it from the coordinator lifecycle and relevant
phase skills. The skill handles discovery, architecture, specification, planning, and implementation
decisions without owning lifecycle state or persistent artifacts.

## Current system context

ADLC has focused skills for discovery, architecture, planning, and execution. The orchestrator's
`references/lifecycle.md` defines specification behavior directly. Existing skills already encourage
focused questions, but their guidance is phase-specific.

## Proposed design

- Store the skill at `adlc/skills/adlc-interview/SKILL.md` so existing plugin discovery and linking
  expose it like other ADLC skills.
- Define a meaningful decision as one that could change feature scope, user-visible behavior,
  architecture, the approved plan, or safe progress.
- Require the coordinator to inspect approved artifacts and relevant evidence before asking. It
  should recommend a course, explain practical trade-offs, and ask one focused question at a time.
- Let phase skills own their existing records. The interview skill returns a decision and any
  remaining assumption; it does not create a transcript or change phase status.
- Add selective handoffs in the orchestrator, lifecycle reference, brainstorm, architecture, planning,
  and execution instructions. Specification mode is routed through the lifecycle's specification
  guidance because ADLC has no separate specification skill.

## Alternatives considered

| Option | Benefits | Costs / risks | Why accepted or rejected |
|---|---|---|---|
| Keep interview guidance only within each phase | No additional skill to maintain | Repeats rules and has no consistent trigger threshold | Rejected because the user asked for a reusable cross-phase capability |
| Add a mandatory interview phase | Makes interviews visible | Adds a gate and encourages unnecessary questions | Rejected because the user explicitly asked for a complementary skill |
| Add an optional cross-phase interview skill | One reusable decision threshold, phase-specific modes | Requires selective routing from phase instructions | Accepted |

## Consequential decisions

No ADR is needed. The change adds workflow guidance without changing system architecture or artifact
contracts.

## Migration and compatibility

No migration. The existing plugin linker discovers individual skills from their directories.

## Risks and mitigations

| Risk | Likelihood / impact | Mitigation |
|---|---|---|
| The skill asks too many questions | Medium / medium | Define the decision threshold, require investigation first, and leave low-impact choices to the coordinator |
| The skill becomes a new approval gate or artifact owner | Low / high | State that it is complementary and return decisions to the existing phase owner |

## Security and privacy

No new data collection or external service. Do not create an interview transcript; record only relevant
decisions in existing ADLC artifacts.

## Open questions

None.

## Approval

- **Approved by:** User, through the direct request to add the skill
- **Date:** 2026-11-01
- **Conditions:** It remains optional and asks only when a meaningful decision is unresolved.
