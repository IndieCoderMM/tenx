---
name: proof
description: Turn a feature into concrete, observable steps grounded in the real code — acceptance criteria, manual test flows, a PR how-to-test section, or directions to reach the feature in the running app. Use when asked what the acceptance criteria are, how to test or verify something by hand, how to reach a feature in the app, or for a QA checklist or smoke test.
---

# Proof

Claims about software are cheap. This skill produces the observable steps that
settle them — what to do, and what you must see for it to count.

Some behavior only surfaces when a human runs the app: visual states, navigation
feel, multi-step interactions, real external services. The same grounding work
answers several questions, so the method is one and the output shape depends on
what was asked.

## Method

1. **Identify the subject.** From the argument, the recent diff, or the
   conversation. If ambiguous, ask.
2. **Ground it in the real implementation.** Read the code it touches — actual
   routes, screen names, button labels, states, error messages, env or feature
   flags. Never guess at a label or a path; if the code does not show it, say so
   rather than inventing it. Note how to launch the app and reach the starting
   point when the repo makes that derivable.
3. **Choose the output shape** from what was asked (below).
4. **Cover only what applies.** Three sharp items beat ten padded ones. Skip what
   an existing automated test already proves; this exists for what tests cannot
   see, or for readers who need it in words.

## The rule that makes any shape usable

Every step pairs an action with an observable result.

> "Click Save → toast reads `Saved` and the new item appears at the top of the list"

not "verify it works". A step whose failure is ambiguous is not a step. Use the
app's real labels and routes, never paraphrases of them.

## Output shapes

**Acceptance criteria** — conditions, not steps. Each must be checkable by
someone who did not write it, and phrased so pass and fail are unmistakable.

```
- [ ] <condition, stated as an observable fact about the system>
```

**Manual flows** — a walkthrough someone runs by hand. One flow per scenario,
under ~8 steps; split longer journeys. Number them so results come back by
number.

```
### Flow N: <name>
Precondition: <state, data, or login needed>
1. <action> → <expected result>
2. <action> → <expected result>
- [ ] Pass
```

Cover, where the feature allows: happy path, input edges (empty, max length,
invalid, duplicate, unicode), error states (server failure, offline, denied
permission — what the user should see, not just "it errors"), interrupted flows
(refresh mid-flow, back, cancel, re-submit), and state variants (empty state,
first-time vs returning, role differences).

**PR how-to-test** — for a reviewer who has the branch but not the context. Lead
with setup (branch, migrations, env vars, seed data, flags), then the shortest
path that exercises the change, then what to watch for. Prose steps, no
checkboxes.

**How to reach it** — the navigation path only: where to click or what URL to
open, what state or permission is required, and what the entry point looks like
when it is there. No assertions; this answers "where is it", not "does it work".

## Delivering

Present the result in chat. Save to a file only when asked, or when a calling
skill names a destination and format — follow that format rather than these
defaults.

When someone reports a failure back, turn it into a precise bug description:
which item, which step, expected versus actual.
