---
name: ideate
description: HQ step 0 — discuss and brainstorm an idea with the user until it is clear enough to become tickets, optionally settling open questions with a prototype, and end by creating the ticket(s).
disable-model-invocation: true
---

# Ideate

Turn a raw idea into one or more tickets. This step settles **what** to build and
**why**. How to build it belongs to `/flow:shape`.

Load the `flow` skill first. Runs in HQ.

## Steps

1. **Restate.** Say the idea back in two lines: who it is for and what changes
   for them. Name a working slug (kebab-case, no ticket id yet).
2. **Discuss.** Ask what is still open, at most 5 numbered questions per round,
   each with your recommended answer so the user can reply `1. y 2. n`. Bring
   options and trade-offs, not surveys. Keep going round by round until the
   user's answers stop changing the idea.
3. **Check the code when it matters.** When an answer depends on what exists
   (a model, a route, a limit), send an Explore subagent with a narrow question
   and use its conclusion. Never read files into HQ.
4. **Prototype when talk can't settle it.** If a question needs to be seen or
   played with ("which layout reads better", "does this state flow hold up"),
   propose a prototype with the single question it answers and the mode:
   `file` (standalone HTML, no codebase needed) or `route` (needs real
   components or data shapes). On the user's go, `/flow:spawn proto <slug>`.
   Continue the discussion while it runs; read `proto/verdict.md` when it lands.
5. **Write the ticket(s).** Split into vertical slices the user could demo one
   at a time. Hand each to `dispatch:issue`, adding:
   - a `## Prototype` section when one ran: the question and the verdict in one
     or two lines;
   - `## Follow up` instead of `## Out of scope` — name the next slice, positively.
   `dispatch:issue` drafts in chat and posts only on approval.
6. **Rename.** Once a ticket exists, rename `DIR` to `<ticket-id>-<slug>` if a
   prototype created it.

## Rules

- Product decisions only: behavior, scope, wording, priority. No file paths,
  schemas, or task lists — those wait for `/flow:shape`.
- The user may end the discussion at any point by saying "ticket" — go to step 5
  with what is settled, and list what is still open in the draft as questions.

Next: /flow:shape <ticket>
