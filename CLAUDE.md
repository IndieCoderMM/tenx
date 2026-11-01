# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Tenx is a collection of Claude Code plugins (skills) for the agentic development lifecycle (ADLC), curated from the author's workflow. Each top-level directory containing `.claude-plugin/plugin.json` is one plugin. Currently: `flow` (task lifecycle), `adlc` (approval-gated feature lifecycle), `craft` (how code and prose get written and verified), `dispatch` (what gets published for others to read), `retro` (weekly review of the workflow itself), and `tutor` (learning technical topics in depth).

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

Flow, retro, and tutor state lives under `~/.tenx/<plugin>/`. ADLC artifacts live in the project-local `.adlc/` directory.

SKILL.md is kept short; anything with templates, caps, or verbatim rules lives in `references/` and the skill instructs readers to load it before acting.

## The craft plugin

Cross-cutting standards, loaded by name rather than auto-triggered. `principles` is the always-on core — `flow-builder` and `flow-reviewer` load it first. `proof` (manual verification cases), `recover` (failure diagnosis), `navigator` (guided implementation), `unslop` (prose cleanup), and `prompt` (system prompt review and rewrite) load on trigger. Skills here are curated forks, not vendored copies: rewrite them to match these preferences rather than tracking an upstream.

## The dispatch plugin

Outbound artifacts: `commit`, `pr`, `issue`. Plus `monitor`, which is read-only and runs in two passes: a **scan** — one batch of five list queries across Linear and GitHub, paired issue-to-PR from the payload alone and reported as in-progress/stale/new — then a **drill** into one named item on request, which is the only place per-item calls like `gh pr view` are allowed. Keeping the fan-out out of the scan is the point; it routes to whichever skill acts on the item (tracker rewrites go through `dispatch:issue`). It queries `gh` and the Linear MCP tools directly — there is no helper script. What separates these from `craft` is that they leave the machine — they touch `gh` or Linear and need credentials. `pr` and `issue` draft in chat and post only on approval, and both update in place when given a link rather than creating a duplicate; `commit` skips approval because a commit is local and amendable.

## The retro plugin

A weekly check on the workflow, not on any one task. `/friction <text>` captures a note mid-work; `/retro` measures the last 7 days, judges last week's experiments, proposes at most five changes, records the picked ones, and renders `~/.tenx/retro/dashboard.html`. All data lives in `~/.tenx/retro/` (`friction.tsv`, `weeks/<week>.json` from the script, `weeks/<week>.review.json` from the skill). `bin/retro` is the only reader of Claude Code's own files (`~/.claude/history.jsonl`, session transcripts) and of flow's `~/.tenx/flow/` — it reads, never writes them. Skill names stay unique across tenx because `link.sh` flattens them into `~/.codex/skills/`.

## The tutor plugin

A personal technical tutor for learning topics in depth — general technical knowledge, not the current codebase. The spec it implements lives outside the repo (`personal-technical-tutor-agent-specification.docx`). `tutor` is the core: the teaching method (context → mental model → mechanism → reasoning → application → evaluation → connection, stages picked per concept), the interaction rules, and the start/resume lifecycle for a topic. `/quiz` is hint-free recall on covered concepts, `/challenge` a realistic problem combining them, `/recap` the session record. State is one markdown file per topic in `~/.tenx/tutor/<topic-slug>.md` (roadmap with mastery level and review schedule, misconceptions, gaps, exercises, sessions); `references/state.md` is the authority on its format, mastery evidence, and review intervals. Mastery comes from demonstrated evidence, never self-report. `checkpoint` was renamed `recap` because flow already owns that skill name.

## The flow plugin

Flow defines a 5-phase ADLC workflow (intent → build → validate → govern → ship) driven by slash commands (`/brainstorm`, `/architect`, `/execute`, `/review`, `/checkpoint`, `/validate`, `/verify`, `/iterate`, `/ship`). Per-task state lives in a task folder (`contract.md`, `tasks.md`, `qa.md`, `logs.tsv`) under `~/.tenx/flow/<repo>/<slug>/`.

Design rules to preserve when editing flow:

- **Single-writer ownership**: each doc section is written by exactly one command (e.g. `Problem`/`Done when` by `brainstorm`, phases by `architect`, ticks by `checkpoint`, `qa.md` by `verify`). `references/schema.md` is the authority — keep it and SKILL.md consistent.
- **`logs.tsv` is append-only** and written only through `bin/flow-log` (closed kind vocabulary, TSV-safe cleaning, 120-char summary cap). Never let skill prose suggest hand-writing rows. `CLAUDE_PLUGIN_ROOT` is not exported to Bash, so skills must never invoke helpers by path — that is why the script lives in `bin/`.
- **Agent effort is per definition, not per call**: the Agent tool overrides only `model`, so a pass needing different `effort:` needs its own agent file (`flow-reviewer` medium vs `flow-validator` high).
- Resume precedence when sources disagree: `logs.tsv` → `tasks.md` → `contract.md` → git (documented in `references/logging.md`).

## The ADLC plugin

For new feature work, use `adlc` as the primary development lifecycle. Treat `.adlc/` artifacts as the persistent source of truth. Follow the discovery, architecture, specification, task planning, implementation, and verification gates. Wait for approval of the feature brief, consequential design decisions, and task plan before implementation. Use risk-based testing. Flow remains available for existing `~/.tenx/flow/` task histories and when a task explicitly uses its commands.
