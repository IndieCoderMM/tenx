# Learning state

One file per topic: `~/.tenx/tutor/<topic-slug>.md`. Edit in place. Never delete a
misconception — mark it resolved.

## Template

```markdown
# <Topic>

goal: <what the user wants to be able to do>
scope: <in / out, one line>
started: <YYYY-MM-DD>

## Roadmap

| # | concept | level | interval | due | notes |
|---|---------|-------|----------|-----|-------|
| 1 | <concept> | — | — | — | <prerequisite of N, etc.> |

## Misconceptions

- <YYYY-MM-DD> <concept>: believed <X>; actually <Y>. [resolved <YYYY-MM-DD>]

## Gaps

- <concept>: <what is missing>

## Exercises

- <YYYY-MM-DD> <quiz|challenge> <concept(s)>: <one-line prompt> — <pass | hinted | fail>

## Sessions

- <YYYY-MM-DD>: covered <concepts>; next <concept or review>
```

## Mastery levels

Set only from evidence in this or an earlier session. What the user says about
their confidence doesn't count.

| level | evidence |
|-------|----------|
| introduced | Has met the concept. |
| understood | Explained the mechanism back, unaided. |
| applied | Used it correctly in a scenario or challenge. |
| mastered | Reasoned unaided about edge cases, trade-offs, or an unfamiliar application. |

## Review schedule

A concept enters review when it reaches **understood**: `interval: 1`,
`due: today + 1`.

After each review:

- **pass** (unaided) → next interval in 1 → 3 → 7 → 14 → 30 → 60 days.
- **hinted** → keep the interval, `due: today + interval`.
- **fail** → `interval: 1`, drop the level by one, record the gap or
  misconception.
