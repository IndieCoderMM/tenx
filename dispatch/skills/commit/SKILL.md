---
name: commit
description: Write a commit message from the staged diff and commit it. Use this everytime when asked to commit, or when a skill needs a message written for work it is about to commit.
---

# Commit

Write a short, clear and concise commit message from the staged diff and commit.

## Read the diff first

```bash
git status --short
git diff --cached
```

Nothing staged → say so and stop. Never stage on a guess: `git add -A` sweeps in
files the user never meant to commit.

## Subject

`type(scope): summary`

- Types: `feat` `fix` `refactor` `perf` `docs` `test` `chore` `build` `ci` `revert`
- Scope: the subsystem touched, lowercase, one word. Drop it when the change is repo-wide.
- Summary: imperative, lowercase, no period. Whole subject ≤ 50 characters.
- Pick the type of the point of the change: a feature that needed a refactor is `feat`.
- Breaking change takes `!`: `feat(api)!: drop v1 token endpoint`

```
feat(auth): add rate limit to login route
fix(player): stop seek jump on scene switch
refactor(db): extract query builder
```

## Body

Completely unnecessary. Skip it when the subject is the whole story. Most commits are one line.

Add it when the diff touches several things, or when the reason is not visible
in the code. Then: `- ` bullets, five at most, compressed fragments rather than
sentences.

```
refactor(log): move log.py to bin/flow-log

- CLAUDE_PLUGIN_ROOT not exported to Bash, path form broke
- bin/ already on PATH for cache and symlink installs
- docs updated: logging.md, architect, checkpoint
```

Keep file paths, identifiers, flags, and error strings verbatim. Drop articles
and filler.

## Rules

- Run the message through `craft:unslop` at **flat** register before committing.
- Slop free: no "this commit", no "various improvements", no restating the type
  in the summary ("fix: fix the bug"), no praise, no hedging.
- No em dashes or en dashes.
- Every claim traces to a real hunk. A bullet about work not in the diff is a lie
  in the history.
- Never append a generated-by or co-authored-by footer unless the repo's own
  history shows one.
- Never commit local plan or task files.
- Say what changed, not what you did: `add retry to fetch`, not `added retry`.

## Commit

```bash
git commit -F <message-file>
```

Write the message file into the scratchpad directory. Report the subject and the
short SHA.
