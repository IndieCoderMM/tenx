---
name: adlc-executing-plans
description: Execute an approved ADLC task plan incrementally, preserving scope, documenting progress, and coordinating pragmatic tests and review.
---

# ADLC Executing Plans

## Goal

Implement an approved plan with controlled autonomy, small diffs, and reliable progress tracking.

## Before each task

1. Read the feature brief, design, relevant current specs/ADRs, task entry, and project instructions.
2. Inspect the current Git status and existing diff. Do not overwrite or discard user work.
3. Inspect the relevant code and tests; confirm the planned approach still fits.
4. Confirm dependencies and acceptance conditions for this task.

## Agent delegation

Use `adlc-builder` when a bounded task benefits from a separate implementation pass. Provide the
change-folder path, task ID, approved file or component boundaries, dependencies, and verification
conditions. If the host does not load Tenx agent definitions but supports subagents, use
`../../agents/adlc-builder.md` as the role brief; do not assume its frontmatter tool permissions are
enforced. The builder must not edit `.adlc/` artifacts; the coordinator owns them and checks the
builder's diff and reported command output. Handle trivial tasks directly when delegation adds no
value or delegation is unavailable.

Assign separate builder agents only to tasks whose dependencies are complete and whose file or
component boundaries do not overlap. Keep dependent or shared-file tasks sequential. If the agent is
unavailable, implement the task directly under the same scope rules.

## Execution loop

For each task:
1. State the task outcome briefly.
2. Delegate the task to `adlc-builder` when useful, or make the smallest coherent implementation
   directly when delegation adds no value or the agent is unavailable.
3. Follow established project patterns and approved design decisions.
4. Use `adlc-pragmatic-testing` to choose proportionate checks.
5. Run the selected checks and inspect their actual output.
6. Review the diff for scope, correctness, regressions, accidental formatting churn, and secrets.
7. If appropriate, request a focused review using `adlc-code-review`.
8. The coordinator updates the task checkbox and progress log only after checking the diff and
   verification evidence.
9. Summarize what changed, checks run, and any remaining concern.

## Scope control

- Do not implement deferred items.
- Do not opportunistically refactor unrelated code.
- Do not add dependencies without a clear need and user approval when material.
- Do not change accepted product behavior or architecture silently.
- If new evidence invalidates the plan or exposes a meaningful decision the approved artifacts do
  not resolve, pause affected work and use `adlc-interview` in implementation mode. Return to the
  appropriate approval gate before changing scope or design, then update the plan when needed.
  Continue independent work that remains safe and within scope. Handle ordinary implementation
  details using project conventions.

## Autonomy

Continue through approved tasks without asking permission after every edit. Pause for:
- material scope changes;
- destructive or irreversible operations;
- uncertain migrations or data-loss risk;
- security/privacy implications not covered by the design;
- changes to external contracts;
- a blocker that requires a product decision.

## Progress persistence

After each completed task, update `.adlc/changes/<slug>/tasks.md`.
Record meaningful discoveries, deviations, and blockers in `notes.md`.
Never mark a task complete because code was merely written; record the verification performed.

## Completion

When all planned tasks are done, hand off to review and verification. Do not independently claim
the entire feature is complete until acceptance criteria have been checked.
