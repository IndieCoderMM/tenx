---
name: quiz
description: Test previously covered concepts by recall — no hints until the user has attempted — and reschedule reviews from the results. Use when the user says "quiz me", "test me on X", or asks what is due for review.
---

# Quiz

Retrieval practice on concepts the user has already covered. The user answers
cold; hints come only after a wrong attempt.

Load the `tutor` skill first.

Arguments: `[topic] [concept]` — optional. Default: concepts due today across
every topic; if none are due, the current topic's weakest or oldest concepts.

## Steps

1. **Pick.** Read the state file(s). Up to five concepts: due first, then open
   gaps, then the longest unreviewed. List them by name only.
2. **Ask** one question per concept. Make it need reasoning — predict an
   outcome, trace the mechanism, find the bug in a short snippet, choose
   between two designs. Not definitions. Don't repeat a prompt from Exercises.
3. **Grade** each: **pass** (unaided), **hinted** (right after hints), or
   **fail**. On a wrong first attempt, climb the hint ladder, then give the
   answer.
4. **Update** the state per the review schedule: interval, due, level,
   misconceptions, gaps, and one Exercises row per question.
5. **Report** with the summary below.

## Rules

- No hints, and no topic-name clues in the question, before the first attempt.
- Correct, don't reteach. A gap too big to fix in two turns goes to Gaps for the
  next `/tutor` session.

## Summary

```markdown
Quiz — <topic(s)> · <date>

| concept | result | next due |
|---------|--------|----------|

**Gaps** <one line each, or —>
**Misconceptions** <one line each, or —>
```
