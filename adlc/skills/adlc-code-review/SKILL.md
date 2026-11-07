---
name: adlc-code-review
description: Review a focused implementation diff against approved requirements and design, prioritizing correctness, data integrity, security, compatibility, and regressions.
---

# ADLC Code Review

## Goal

Find actionable defects and meaningful risks in a change. Review the implementation, not the author's
intentions or formatting preferences.

## Context to read

Read the approved feature brief, design, relevant tasks, current specs, ADRs, and project conventions.
Inspect the actual diff and enough surrounding code to understand behavior.

## Review priorities

1. Incorrect user-visible behavior or unmet acceptance criteria.
2. Data loss, corruption, invalid persistence, or migration hazards.
3. Security, privacy, authorization, and trust-boundary errors.
4. Regressions, compatibility breaks, and incorrect error handling.
5. Async, state, lifecycle, race, and resource-management defects.
6. Performance problems with a plausible user or operational impact.
7. Maintainability concerns that materially increase future defect risk.

Do not report personal style preferences, speculative hypotheticals, or minor naming suggestions as
blocking defects.

## Review method

- Delegate a focused read-only pass to `adlc-reviewer`, providing the approved artifacts and diff
  scope. If the host does not load Tenx agent definitions but supports subagents, use
  `../../agents/adlc-reviewer.md` as the role brief; do not assume its frontmatter tool permissions
  are enforced. If delegation is unavailable, review directly.
- Trace changed behavior through callers and consumers.
- Check boundary conditions and failure paths.
- Check whether tests cover the highest-risk behavior; do not demand tests for every code path.
- Look for mismatch between docs, code, contracts, and acceptance criteria.
- Verify that unrelated files or dependencies were not changed unnecessarily.
- Do not assume a test passed unless its output is available.

## Findings format

For each finding include:
- **Severity:** Critical / High / Medium / Low.
- **Location:** file and relevant symbol or concise location.
- **Problem:** what is wrong and under what condition.
- **Impact:** concrete consequence.
- **Suggested direction:** minimal corrective approach.

Check each agent finding against the code before reporting it. Only report findings that are
actionable and grounded in the diff. If no findings are identified, say so and state the scope
reviewed; do not imply the change is defect-free.

## Boundaries

Do not edit code during review unless explicitly asked to switch from review to remediation.
Do not execute destructive commands or alter user data.
