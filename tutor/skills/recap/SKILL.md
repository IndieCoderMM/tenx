---
name: recap
description: Close a learning session with a compact record — concepts covered, demonstrated strengths, gaps, misconceptions, next steps — and save it to the topic's state.
disable-model-invocation: true
---

# Recap

End the session with a record the user can read in a minute, and leave the
state file ready for the next session.

Load the `tutor` skill first.

Arguments: `[topic]` — optional; defaults to the topic of this session.

## Steps

1. **Reconcile.** Check every concept touched this session has its level,
   interval, and due set from the evidence, and that new misconceptions and
   gaps are recorded. Fix what is missing.
2. **Log.** Append one Sessions row.
3. **Report** with the template below.

## Rules

- Strengths need evidence: what the user explained or solved, not what was
  covered.
- Next steps name one concept and the date of the next due review — not a list
  of options.

## Template

```markdown
Recap — <topic> · <date>

**Covered** <concepts, with level reached>
**Strengths** <what the user demonstrated>
**Gaps** <one line each, or —>
**Misconceptions** <open ones, or —>
**Next** <next concept> · reviews due <date>
```
