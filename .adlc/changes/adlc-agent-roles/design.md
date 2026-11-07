# Technical Design: ADLC role agents

## Summary
Add three Claude Code agent definitions under `adlc/agents/` and connect them to the existing execution, review, and verification skills. Keep the coordinator responsible for approvals, integration, and `.adlc/` records.

## Current system context
Tenx defines agents as Markdown files under each plugin's `agents/` directory. Flow already separates implementation, read-only review, and deep validation into `flow-builder`, `flow-reviewer`, and `flow-validator`. ADLC has matching focused skills but currently no agent definitions.

## Proposed design
- `adlc-builder` receives one approved task and may edit only assigned implementation files. It may use `Skill`, `Read`, `Write`, `Edit`, `Grep`, `Glob`, and `Bash`.
- `adlc-reviewer` reviews an assigned diff and returns findings only. It has no write/edit tools and uses medium effort.
- `adlc-verifier` maps acceptance criteria to fresh evidence and reports gaps. It has no write/edit tools and uses high effort.
- `adlc-executing-plans`, `adlc-code-review`, and `adlc-verification` delegate to those roles when a separate pass adds value, with direct execution as a fallback for small tasks or when an agent is unavailable.
- The main coordinator owns `.adlc/` artifacts and checks reports before updating progress or verification records.
- Parallel builders are allowed only for approved tasks with independent dependencies and disjoint file/component boundaries.

## Data model and contracts
Agent inputs identify the change folder, task or diff scope, and relevant boundaries. Builder output includes changed files, checks actually run, blockers, and out-of-scope findings. Reviewer output follows the ADLC review findings format. Verifier output maps each acceptance criterion to evidence and result.

## Alternatives considered
| Option | Benefits | Costs / risks | Why accepted or rejected |
|---|---|---|---|
| One agent per ADLC phase | Fine-grained specialization | Duplicates the existing skills and adds maintenance | Rejected |
| Three stable execution/review/verification roles | Clear tool boundaries and independent checks | Requires explicit handoffs in three skills | Accepted |
| Keep all work in the main agent | No handoff overhead | No independent reviewer and no scoped tool boundary | Rejected |

## Consequential decisions
No durable system architecture decision is introduced. The three roles follow the existing Tenx agent convention.

## Migration and compatibility
No migration. Existing Flow agents and workflows remain unchanged.

## Risks and mitigations
| Risk | Likelihood / impact | Mitigation |
|---|---|---|
| Agents edit shared ADLC records or exceed scope | Medium / medium | Deny builder access to ADLC records by instruction; reviewer and verifier have no write tools; coordinator owns records. |
| Parallel tasks conflict | Medium / medium | Parallelize only after approval and only with disjoint boundaries and no dependency ordering. |
| Agent reports unobserved checks | Low / high | Require actual command output and coordinator review before recording results. |

## Security and privacy
No new external services or data access. Builder write access is bounded by the assigned task. Reviewer and verifier have no write/edit tools.

## Approval
- **Approved by:** User, via "go ahead" on the proposed three roles
- **Date:** 2026-11-01
- **Conditions:** Coordinator retains approval gates and ADLC artifact ownership.
