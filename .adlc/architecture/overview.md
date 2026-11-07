# Architecture overview

Tenx is a repository of agent workflow plugins. Each plugin lives in a top-level directory and is discovered through `.claude-plugin/plugin.json`. Skills live under `skills/<name>/SKILL.md`; optional agents live under `agents/<name>.md`. Larger references and helper programs stay with the plugin that uses them.

`link.sh` scans those plugin directories and creates user-level symlinks for Claude Code and Codex. It exposes plugin directories to Claude Code and individual skill directories to Codex; it does not currently register agent definitions with Codex.

Workflow state has plugin-specific ownership:

- ADLC writes project-local briefs, designs, plans, specifications, decisions, and verification records under `.adlc/`.
- Flow stores task folders under `~/.tenx/flow/<repo>/<slug>/`.
- Retro stores workflow notes and reports under `~/.tenx/retro/`.
- Tutor stores topic learning state under `~/.tenx/tutor/`.
- Craft and dispatch do not define a shared persistent state directory.

Dispatch calls GitHub CLI and Linear MCP tools for external work. Other plugins primarily provide instructions and local helper scripts.
