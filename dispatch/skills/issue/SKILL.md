---
name: issue
description: Write a vertical-slice issue from a template and post it to GitHub or Linear after approval. Given an issue link or number it updates that issue in place; otherwise it creates a new one. Use when the user asks to create, draft, or write an issue, ticket, or feature request.
---

# Issue write

Turn a feature, bug, or slice of work into a human-readable issue. Behavior over implementation, always drafted in chat before posting.

## Procedure

1. **Resolve the target.** An issue link or number in the invocation means
   **update that issue** — fetch its current title and body and treat them as the
   starting draft, carrying every line forward unless this session gives a reason
   to change it. With none given, create a new issue.
2. **Gather.** The slice comes from the invocation or the conversation. If the end-to-end behavior isn't clear enough to fill the template, ask — don't pad with guesses.
3. **Draft** using the template below.
4. **Unslop.** Load `craft:unslop` and run the draft through it at **flat** register before showing it.
5. **Approve.** Show the full draft in chat — always, never skip straight to posting. Post only after the user confirms; apply edits and re-show until they do.
6. **Post.** Target is `gh` or `linear`, specified by the user; if unspecified, ask (numbered options). GitHub via `gh issue create` or `gh issue edit`, Linear via its MCP tools. Reply with the created issue URL.

## Template

```markdown
## What

<2-4 sentences. The vertical slice from the user's side: who does what,
and what they get back. Written as behavior, never as implementation.
No file paths, no code, no layer talk.>

## Why

<1-2 sentences. The problem this solves or the gap it closes. Skip if
obvious from What.>

## Acceptance criteria

<flat list by default. When the criteria span clearly distinct areas,
group them under a **bold heading** per area — only when grouping
genuinely aids scanning, never for 2-3 criteria.>

- [ ] <observable outcome, checkable by using the app or API>
- [ ] <one behavior per box, concrete enough to demo>
- [ ] <includes the failure/edge behavior that matters, not just happy path>

## Prototype

<1-2 lines: the question a prototype answered and its verdict.>

## Follow up

<1-3 lines naming the next slice, as what it will do. Link the issue when it exists.>
```

`Why`, `Prototype`, and `Follow up` are optional — drop the heading entirely when there's nothing to say.

## Writing rules

- Title: plain imperative, ≤70 chars, no conventional-commit prefix, no "Feature:" label.
- Acceptance criteria are outcomes a reviewer can check by hand, not tasks ("user sees X", not "implement X").
- Max 5 criteria per group (or overall when ungrouped). A slice needing more is two slices — say so and offer to split.
- Group headings are short area names ("**Editor**", "**Sync**"), not sentences.
- Describe end-to-end behavior, never layer-by-layer implementation. No file paths, no code snippets.
- Never reference local plan or quest files.
- Short, direct sentences. State what the slice does, not what it doesn't — no lists of exclusions or caveats.
