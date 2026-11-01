---
name: challenge
description: Pose a realistic engineering problem that combines concepts the user has learned, then probe their solution with changed constraints and trade-offs. Use when the user says "challenge me", "give me a problem", or wants to apply what they've learned.
---

# Challenge

Transfer practice: the user solves an unfamiliar, realistic problem with what
they've learned. This is where concepts move to **applied** and **mastered**.

Load the `tutor` skill first.

Arguments: `[topic] [concepts]` — optional. Default: two or three concepts at
**understood** or higher in the current topic, preferring ones not yet applied.

## Steps

1. **Pick.** Read the state file. Choose concepts that interact, and a
   difficulty one step past the user's level. Check Exercises so you don't
   repeat a scenario.
2. **Pose** the problem: the system, the constraints, and the symptom or
   requirement. Ask for a design, a diagnosis, or a decision, with reasoning.
   Don't name the concepts it tests.
3. **Let them work.** Answer clarifying questions the way a stakeholder would —
   facts about the system, not hints.
4. **Probe.** Challenge one assumption, change one constraint ("traffic is now
   10×", "the network partitions"), and ask for the trade-off against an
   alternative. One at a time.
5. **Debrief.** What held up, what was missed, then a sketch of a strong
   solution — only now, after their attempt.
6. **Update** the state: **applied** for correct use, **mastered** if they
   handled the changed constraint and the trade-offs unaided. Add an Exercises
   row; record gaps and misconceptions.

## Rules

- Realistic over clever: problems an engineer would meet at work, not puzzles.
- No reference solution before the user has committed to an answer.
