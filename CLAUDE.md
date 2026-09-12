# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Tenx is a collection of Claude Code plugins (skills) for the agentic development lifecycle (ADLC), curated from the author's workflow. Each top-level directory containing `.claude-plugin/plugin.json` is one plugin. Currently: `flow` (task lifecycle), `craft` (how code and prose get written and verified), and `dispatch` (what gets published for others to read).

## Commands

```bash
./link.sh                              # symlink every plugin into ~/.claude/skills/ (edits are live; re-run after adding a plugin)
claude plugin validate ./flow --strict # validate one plugin — same check CI runs (.github/workflows/validate.yml)
```

`--strict` turns warnings into errors so a misspelled manifest field or bad skill frontmatter fails loudly instead of silently dropping a component.

## Plugin layout convention

```
<plugin>/
├── .claude-plugin/plugin.json   # manifest (discovery hinges on this file existing)
├── skills/<name>/SKILL.md       # the skill entry point
├── skills/<name>/references/    # detail docs the skill loads on demand (schema.md, logging.md)
├── agents/<name>.md             # subagents the skills delegate to (frontmatter: tools, model, effort)
└── bin/                         # executables — the harness puts this dir on PATH, so call them by bare name
```

SKILL.md is kept short; anything with templates, caps, or verbatim rules lives in `references/` and the skill instructs readers to load it before acting.

## The craft plugin

Cross-cutting standards, loaded by name rather than auto-triggered. `principles` is the always-on core — `flow-builder` and `flow-reviewer` load it first. `proof` (manual verification cases), `recover` (failure diagnosis), `navigator` (guided implementation), `unslop` (prose cleanup), and `prompt` (system prompt review and rewrite) load on trigger. Skills here are curated forks, not vendored copies: rewrite them to match these preferences rather than tracking an upstream.

## The dispatch plugin

Outbound artifacts: `commit`, `pr`, `issue`. Plus `monitor`, which is read-only: it prints active tasks, PRs, and issues, then routes to whichever skill acts on them (dashboard rewrites go through `dispatch:issue`). What separates these from `craft` is that they leave the machine — they touch `gh` or Linear and need credentials. `pr` and `issue` draft in chat and post only on approval, and both update in place when given a link rather than creating a duplicate; `commit` skips approval because a commit is local and amendable.

## The flow plugin

Flow defines a 5-phase ADLC workflow (intent → build → validate → govern → ship) driven by slash commands (`/brainstorm`, `/architect`, `/execute`, `/review`, `/checkpoint`, `/validate`, `/verify`, `/iterate`, `/ship`). Per-task state lives in a task folder (`contract.md`, `tasks.md`, `qa.md`, `logs.tsv`) under `~/.flow/plans/<repo>/<slug>/`.

Design rules to preserve when editing flow:

- **Single-writer ownership**: each doc section is written by exactly one command (e.g. `Problem`/`Done when` by `brainstorm`, phases by `architect`, ticks by `checkpoint`, `qa.md` by `verify`). `references/schema.md` is the authority — keep it and SKILL.md consistent.
- **`logs.tsv` is append-only** and written only through `bin/flow-log` (closed kind vocabulary, TSV-safe cleaning, 120-char summary cap). Never let skill prose suggest hand-writing rows. `CLAUDE_PLUGIN_ROOT` is not exported to Bash, so skills must never invoke helpers by path — that is why the script lives in `bin/`.
- **Agent effort is per definition, not per call**: the Agent tool overrides only `model`, so a pass needing different `effort:` needs its own agent file (`flow-reviewer` medium vs `flow-validator` high).
- Resume precedence when sources disagree: `logs.tsv` → `tasks.md` → `contract.md` → git (documented in `references/logging.md`).
