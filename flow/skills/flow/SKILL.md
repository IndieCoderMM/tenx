---
name: flow
description: Structured workflow for agentic coding tasks. Load before running any flow command.
---

# Flow

**Flow** stack is a set of skills designed for effective ADLC workflow which involves 5 phases: 
- intent - the contract layer
- build - the creation layer
- validate - the verification layer
- govern - the human judgment layer
- ship - the release layer

##  Flow docs

`DIR=~/.tenx/flow`

Flow docs are context files written under `DIR` directory. These docs are designed to prevent the failure modes of normal agentic coding: context lost between sessions so each one re-derives the task from scratch, scope creep mid-build, decisions silently reversed or relitigated, "done" claims nobody can check, and review feedback that evaporates instead of becoming tracked work. Only a flow skill's own invocation writes to these files.

### Folder schema

```
<repo-name>/<slug>/
├── contract.md   # problem, done-when, domain, invariants
├── tasks.md      # phases as checkboxes + terse notes
├── qa.md         # manual QA steps
└── logs.tsv      # append-only decision log
```

Full templates, section caps, and the verbatim rules are in `references/schema.md`, beside this file. 
**Read it before writing docs.**

`logs.tsv` rules and the `flow-log` command are in `references/logging.md`, beside this file. 
**Read it before writing a log row or resuming a task.**

### Resolving `<slug>`

Every skill takes an optional slug as its first argument. When omitted, resolve
in this order:

1. A folder under `DIR` whose name appears in the current git branch.
2. The most recently modified folder whose `stage:` is not `archived`.
3. Otherwise list the candidates and ask.

Slugs are kebab-case, prefixed with the issue number when one exists (`123-chat-backend`), otherwise a short descriptive slug (`layout-cap-audit`).

## The flow

1. `/brainstorm` - Discuss the problem, form a hypothesis, and writes `contract.md`.
2. `/architect` - Decisions + phase split + tasks breakdown → `tasks.md`.
3. `/execute <phase>` - Implement the solution per phase (can span multiple cycles based on review feedback).
4. `/review <phase>` - Light pass, this phase's diff only.
5. `/checkpoint <phase>` - User accept: commit, update tasklist and logs.
6. `/validate <phase>` - Deep agent pass over the full branch: contract, business logic, quality.
7. `/verify <phase>` - Generate QA test cases with checkboxes for manual pass -> `qa.md`.
8. `/iterate` - Append iteration phases into `tasks.md` for required changes.  
9. `/ship` - Format, lint, clean up, open PR.

Out of band, at any stage:

- `/revise` - The target moved. Rewrite `contract.md` and log the reversal.

## Related skills

- `craft:unslop` — apply to every message that must land clearly with the user: design questions, proposals, report templates.

Each flow skill may name further related skills. If one is not installed, do not block — continue without it and note `skill <name> not found` in the report.
