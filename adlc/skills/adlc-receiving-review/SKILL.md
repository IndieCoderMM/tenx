---
name: adlc-receiving-review
description: Evaluate code-review feedback objectively, verify each claim against the repository and approved design, and apply valid fixes without blindly accepting suggestions.
---

# ADLC Receiving Code Review

## Goal

Treat review feedback as hypotheses to investigate. Neither accept nor reject it automatically.

## Process

For each finding:
1. Restate the claimed defect and expected impact.
2. Inspect the cited code and relevant call paths.
3. Compare the claim with approved requirements, design, ADRs, and project conventions.
4. Reproduce or otherwise verify the behavior where practical.
5. Classify the feedback:
   - Valid: defect is confirmed.
   - Partially valid: concern exists but proposed fix is too broad or inaccurate.
   - Not applicable: premise is incorrect or behavior is intentional and documented.
   - Needs decision: resolving it changes product scope or architecture.
6. Apply the smallest safe correction for valid findings.
7. Add or adjust a focused test only when it protects meaningful behavior or a regression.
8. Re-run relevant verification and inspect the resulting diff.

## Communication

Respond to feedback with evidence:
- what was inspected;
- whether the issue was reproduced;
- what changed or why no change was made;
- which checks were run.

Do not dismiss feedback because it is inconvenient. Do not blindly implement a suggestion that conflicts
with requirements, architecture, security, or data integrity.

## Escalation

Return to the user when feedback implies:
- a product behavior change;
- a consequential architectural decision;
- a breaking contract or migration;
- a security/privacy trade-off;
- a material scope expansion.

Update the task plan and design when the agreed implementation direction changes.
