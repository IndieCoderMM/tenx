---
name: review
description: Light review of the current phase's diff via a code-review subagent.
disable-model-invocation: true
---

# Review

Light pass over the current diff. Delegate the review, validate the findings, report.

Load the `flow` skill first.

## Steps

1. **Orient.** Resolve the slug. Identify the current phase and its
   diff: everything since the last checkpoint commit — the `ref` on the newest
   `done` row in `logs.tsv`, or the branch point when no `done` row exists yet.
   If there is no diff, say so and stop.
2. **Delegate.** Spawn `flow-reviewer` with the diff range and the task folder
   path. It filters its own findings by confidence.
3. **Report.** Relay the findings as returned. Findings outside the phase's
   scope go to Backlog. End with `Next: /checkpoint <slug>` if clean, otherwise
   `Next: /execute <slug>` to address them.

## Rules

- Never fix anything — report only.
- This phase's diff only; the deep full-branch pass is `/validate`'s job.
- Never tick `tasks.md` boxes or commit.

## Template — findings report

```markdown
diff since <ref>

**Findings**
1. <file:line> — <finding> · <severity> · <suggested fix>
2. …

Dropped as false positives: <n>
To Backlog: <out-of-scope findings, or —>

Next: /checkpoint <slug> | /execute <slug>
```
