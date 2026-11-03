---
name: validate
description: Deep pass over the full branch — code quality plus business logic against the contract.
disable-model-invocation: true
---

# Validate

Two-agent deep pass over the whole branch: one reviews the code, one checks the
work against the contract. Delegate, cross-check, report.

Load the `flow` skill first.

## Steps

1. **Orient.** Resolve the slug. Read `contract.md` and determine
   the full-branch diff (branch point to HEAD). Set `stage: validating`.
2. **Delegate.** Spawn two agents in parallel:
   - `flow-reviewer` — pure code review over the full-branch diff.
   - `flow-validator` — the deep pass: traces the system end to end and
     confirms it against Done when, Invariants, and the Review Focus lines.
3. **Cross-check.** Merge both reports: dedupe, and drop anything the other
   agent's evidence contradicts.
4. **Report.** Two sections: per Done when condition — met, not met, or needs
   manual QA; then confirmed findings with file:line and severity. End with
   `Next: /iterate <slug>` when changes are required, `Next: /verify <slug>` when clean.

## Rules

- Full branch review.
- The contract check covers Done when and Invariants, nothing else in the file.
- Never fix anything — report only.
- No flow-doc edits beyond `stage:` and log rows.

## Template — validation report

```markdown
<branch>, <n> commits

**Done when**
- ✅ met — <condition>
- ❌ not met — <condition>: <why>
- ✋ manual QA — <condition>

**Findings**
1. <file:line> — <finding> · <severity>
2. …

Next: /iterate <slug> | /verify <slug>
```
