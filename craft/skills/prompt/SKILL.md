---
name: prompt
description: Engineer the system prompts an agentic app sends to a model. Reviews the prompts on the current branch, reports each flaw and the change it intends, then rewrites them. Use when asked to review, tighten, improve, or rewrite a system prompt, agent instructions, or tool descriptions.
---

# Prompt

A system prompt is read by a capable model. It does not need to be told what it
already does; it needs targets, decision criteria, the context it cannot infer,
and an exact output contract. Most prompts in the wild are walls of prohibitions
and CRITICAL markers around a missing core. This skill finds the gaps and fills
them.

Two passes, in order: review and report, then rewrite. The report exists so the
author sees the intended changes before the text moves, and so questions only
the author can answer get asked before guessing.

## Finding the prompts

"Prompt" covers every string the app sends as instruction: `system` strings and
the templates that build them, agent definition files, tool and function
descriptions, few-shot blocks, and markdown files loaded at runtime.

- **Named by the user.** Those files, nothing else.
- **Otherwise, the branch.** Files changed since the merge base with the default
  branch that contain prompt text. On the default branch, or when the diff has
  none, scan the whole repo: grep for `system`, `prompt`, `instructions`,
  `SYSTEM_PROMPT`, `role: "system"`, and directories named `prompts/` or
  `agents/`.
- **Nothing found.** Say what was searched and ask where the prompts live.

For each prompt also read the code around it. It answers questions the prompt
text cannot: which variables get interpolated and what they contain, how the
output is consumed (parsed, schema-validated, shown to a human), which tools the
model has, and what other prompt sits next to it in the same conversation.

## Review pass

Read each prompt against these eight checks. Each names the signal, why it
fails, and what replaces it.

1. **Prohibitions where a target belongs.** "Never leave gaps" tells the model
   where the wall is, not where to walk. Replace with the behavior wanted: "fill
   remaining space by expanding the last item to the container edge". Where a
   constraint must hold absolutely, say so once, and note whether a schema or
   validator should enforce it, since prose caps get violated.
2. **Procedures where judgment is needed.** A fixed step sequence breaks on the
   first case that does not fit the author's imagined order. Turn it into a
   stated tradeoff and name the signals that favor each branch. Keep a fixed
   sequence only where order genuinely matters (auth before request, read before
   write).
3. **Missing context.** Domain terms, the shape of the data, why a constraint
   exists, what matters more when two goals conflict. This is usually the
   largest gap and the one that separates a working prompt from a generic one.
   Add as much as the task needs. Rank competing goals explicitly.
4. **Loose output contract.** Format, meaning of each field, and whether anything
   may precede or follow the payload. If the output is machine-read, name the
   parser or schema that backs it, and make the prompt match it exactly.
5. **No behavior under uncertainty.** Ambiguous input, missing data, constraints
   that cannot all be satisfied. Define what happens: a specific error shape, a
   clarifying question, or a documented default. Without it the model
   improvises and the failure is hard to trace.
6. **Edge-case lists that should be examples.** Long rule lists generalize
   poorly. Replace with two to four canonical examples that differ from each
   other meaningfully, sourced from real data in the repo: fixtures, test cases,
   logged inputs, seed data. Never invent example data. If none exists, record
   in the report what is needed.
7. **Text that does nothing.** Restatements of behavior a capable model already
   exhibits, adjectives with no observable meaning, sections wrapping nothing,
   instructions that contradict others. Cut only these. Keep whatever earns its
   place, however long it runs; length is not the flaw.
8. **Emphasis on everything.** When every line is CRITICAL or MUST the marking
   stops carrying information. Reserve it for the few rules that are truly
   absolute, and demote the rest to plain statements.

Weigh, do not tally. A prompt with one missing output contract and a machine
reader is in worse shape than one with ten stray adjectives.

## Report

Deliver in chat before touching a file.

```markdown
## <path>

Purpose: <one line: who sends it, to which model, what the output feeds>

Flaws
1. <quoted line or section> · <check number and name> · <what it becomes>
2. …

Keep: <sections that earn their place and stay as-is, or —>
Enforce outside the prompt: <constraints better held by a schema/validator, or —>
Needs from the author: <context only they know, or real data for examples, or —>
```

One block per prompt. Then decide whether to continue:

- **Nothing under "Needs from the author"** across all prompts: proceed to the
  rewrite pass in the same turn.
- **Something is listed there**: stop and wait. Guessing at a goal ranking or
  inventing example data produces a confident prompt that is wrong, which is
  worse than the original.

## Rewrite pass

Rewrite each prompt in place, applying the report. Rules that hold during the
rewrite:

- **Preserve what the code depends on.** Interpolation placeholders, exact
  delimiters or field names a parser reads, section markers another prompt or
  tool refers to. Read the consumer before changing any of these.
- **One absolute rule reads as absolute.** Everything else reads as a target,
  a criterion, or context.
- **Examples come from the repo.** Cite the source file in a comment where the
  prompt format allows one. If the report asked for data and none arrived,
  leave that section out rather than fabricating.
- **Flat register.** A prompt is read for instructions, not voice. The `unslop`
  patterns apply with no soul added.
- **Do not shorten for its own sake.** A rewrite that adds context and examples
  can be longer than the original and still be the better prompt.

When a schema or validator should carry a constraint and none exists, do not
write one. Name it in the closing summary as work for the author.

If the repo has tests or evals that exercise the prompt, run them after the
rewrite and report the result.

## Closing summary

```markdown
Rewrote: <paths>
Per prompt: <two lines on what changed and why>
Now enforced by schema: <constraints moved out of prose, or —>
Still needs: <validator to add, data for examples, author decisions, or —>
Tests: <command and result, or none found>
```

## Example

Source: the checks above applied to a layout instruction.

Before:

```
CRITICAL: Never leave gaps in the grid. NEVER exceed 12 columns.
Always make sure items are aligned. Do NOT invent new sizes.
```

After:

```
Fill remaining space by expanding the last item to the container edge.
Items snap to the 12-column grid; the renderer rejects wider spans, so
stay within it. Sizes come from the `size` enum in the request schema.
When the requested items cannot fit in one row, wrap to a new row rather
than shrinking below the enum's smallest size.
```

The wall became a target, the absolute rule names its enforcer, the size
constraint points at the schema that already holds it, and the overflow case
now has a defined behavior.
