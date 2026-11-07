# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Tenx is a collection of Claude Code plugins (skills) for the agentic development lifecycle (ADLC), curated from the author's workflow. Each top-level directory containing `.claude-plugin/plugin.json` is one plugin. Currently: `flow` (HQ + aoe work sessions, idea to PR), `adlc` (approval-gated feature lifecycle), `craft` (how code and prose get written and verified), `dispatch` (what gets published for others to read), `retro` (weekly review of the workflow itself), and `tutor` (learning technical topics in depth).

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

Cross-cutting standards, loaded by name rather than auto-triggered. `principles` is the always-on core — `flow-builder` and `flow-reviewer` load it first. `proof` (manual verification cases), `recover` (failure diagnosis), `navigator` (guided implementation), `unslop` (prose cleanup), `prompt` (system prompt review and rewrite), and `size` (sizes a task XS to XL from the files it really touches, never in hours or days) load on trigger. Skills here are curated forks, not vendored copies: rewrite them to match these preferences rather than tracking an upstream.

## The dispatch plugin

Outbound artifacts: `commit`, `pr`, `issue`. Plus `monitor`, which is read-only and runs in two passes: a **scan** — one batch of five list queries across Linear and GitHub, paired issue-to-PR from the payload alone and reported as in-progress/stale/new — then a **drill** into one named item on request, which is the only place per-item calls like `gh pr view` are allowed. Keeping the fan-out out of the scan is the point; it routes to whichever skill acts on the item (tracker rewrites go through `dispatch:issue`). It queries `gh` and the Linear MCP tools directly — there is no helper script. What separates these from `craft` is that they leave the machine — they touch `gh` or Linear and need credentials. `pr` and `issue` draft in chat and post only on approval, and both update in place when given a link rather than creating a duplicate; `commit` skips approval because a commit is local and amendable.

## The retro plugin

A weekly check on the workflow, not on any one task. `/friction <text>` captures a note mid-work; `/retro` measures the last 7 days, judges last week's experiments, proposes at most five changes, records the picked ones, and renders `~/.tenx/retro/dashboard.html`. All data lives in `~/.tenx/retro/` (`friction.tsv`, `weeks/<week>.json` from the script, `weeks/<week>.review.json` from the skill). `bin/retro` is the only reader of Claude Code's own files (`~/.claude/history.jsonl`, session transcripts) and of flow's `~/.tenx/flow/` — it reads, never writes them. Skill names stay unique across tenx because `link.sh` flattens them into `~/.codex/skills/`.

## The tutor plugin

A personal technical tutor for learning topics in depth — general technical knowledge, not the current codebase. The spec it implements lives outside the repo (`personal-technical-tutor-agent-specification.docx`). `tutor` is the core: the teaching method (context → mental model → mechanism → reasoning → application → evaluation → connection, stages picked per concept), the interaction rules, and the start/resume lifecycle for a topic. `/quiz` is hint-free recall on covered concepts, `/challenge` a realistic problem combining them, `/recap` the session record. State is one markdown file per topic in `~/.tenx/tutor/<topic-slug>.md` (roadmap with mastery level and review schedule, misconceptions, gaps, exercises, sessions); `references/state.md` is the authority on its format, mastery evidence, and review intervals. Mastery comes from demonstrated evidence, never self-report. `checkpoint` was renamed `recap` because flow already owns that skill name.

## The flow plugin

Flow (v2) splits work between one **HQ** session per feature, started in the feature's worktree, and **aoe work sessions** spawned into that same worktree. HQ runs `/flow:ideate` (discussion → prototype → ticket), `/flow:shape` (ticket → `plan.md`), `/flow:spawn` and `/flow:board`. Work sessions run `/flow:proto`, `/flow:build`, `/flow:review` and `/flow:ship`. One file per feature, `~/.tenx/flow/<repo>/<slug>/plan.md`, carries the state between them. v1 (contract/tasks/qa/logs, nine commands) is archived in `archive/flow-v1/`; `link.sh` and CI skip it.

Design rules to preserve when editing flow:

- **Single writer per section** of `plan.md`; `skills/flow/references/plan.md` is the authority — keep it and the skills consistent.
- **One code writer per worktree.** Review and HQ never edit code. Parallelism is across features only.
- **HQ stays light**: it reads code only through Explore subagents and learns about work sessions from `plan.md` and `flow-wait`, never by polling.
- **aoe mechanics live in `bin/`** (`flow-spawn`, `flow-wait`, `flow-board`), not in skill prose. `CLAUDE_PLUGIN_ROOT` is not exported to Bash, so skills call them by bare name. aoe names a new worktree's directory after the session title, and `-P <parent>` overrides `-g`; derive the repo from git, never from the aoe group.

## The ADLC plugin

For new feature work, use `adlc` as the primary development lifecycle. Treat `.adlc/` artifacts as the persistent source of truth. Follow the discovery, architecture, specification, task planning, implementation, and verification gates. Wait for approval of the feature brief, consequential design decisions, and task plan before implementation. Use risk-based testing. Flow remains available for existing `~/.tenx/flow/` task histories and when a task explicitly uses its commands.
