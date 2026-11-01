# Project Context

## Product
- **Name:** Tenx
- **Purpose:** A collection of Claude Code plugins and skills for agentic development workflows.
- **Primary users:** The repository maintainer and developers using its plugins through supported coding agents.
- **Core user value:** Reusable workflow skills packaged with the project conventions and state they need.

## Current scope
- **In scope:** Plugin manifests, skill instructions, supporting scripts and references, and workflow state conventions.
- **Explicitly out of scope:** The coding agent hosts themselves and the remote services used by some skills.

## Technical landscape
- **Languages/frameworks:** Markdown, JSON, and Bash.
- **Application shape:** Top-level plugin directories contain `.claude-plugin/plugin.json` and skills under `skills/<name>/SKILL.md`.
- **Persistence/data stores:** ADLC uses project-local `.adlc/` artifacts. Flow, retro, and tutor use `~/.tenx/` directories.
- **External services:** Dispatch uses GitHub CLI and Linear MCP tools. Claude Code and Codex load linked skills.
- **Build/test commands:** `./link.sh` links plugins and skills into user-level agent directories. `claude plugin validate <plugin-dir> --strict` validates a plugin. CI validates `flow`.

## Architectural map
See [architecture/overview.md](architecture/overview.md).

## Engineering conventions
- Style and naming: Keep skills focused. Use unique skill names because `link.sh` exposes them in a flat Codex skills directory.
- Error handling: Follow the behavior documented by each plugin; no repository-wide error-handling standard is defined.
- Logging/observability: Plugin-specific; add logging only when a workflow requires it.
- Accessibility/security/privacy expectations: Follow the coding agent and external service boundaries used by each skill.
- Test strategy: Run strict plugin validation for changed plugin manifests and use workflow-specific verification where relevant.

## Constraints
- Each plugin is a top-level directory with `.claude-plugin/plugin.json`.
- `link.sh` discovers plugins and skills from their directory layout.
- Keep project and task state in the locations documented by each plugin.

## Current priorities
No active repository priority is recorded.

## Important links
- Architecture: [architecture/overview.md](architecture/overview.md)
- Current specifications: None recorded yet.
- Active changes: None recorded yet.
