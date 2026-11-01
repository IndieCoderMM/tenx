# Installation

This bundle is packaged in Tenx as the `adlc` plugin. Its manifest is in `.claude-plugin/plugin.json`. From the Tenx repository root, `./link.sh` links its skills into the user-level Claude Code and Codex directories. The steps below describe installing the raw skills into another project without Tenx's loader.

## 1. Copy the skills

Copy the directories inside `skills/` into the skill directory supported by your coding agent.
For example, if your agent supports project-local Agent Skills:

```text
your-project/
└── .agents/
    └── skills/
        ├── adlc/
        ├── adlc-brainstorm/
        ├── adlc-architecture/
        ├── adlc-writing-plans/
        ├── adlc-executing-plans/
        ├── adlc-pragmatic-testing/
        ├── adlc-code-review/
        ├── adlc-receiving-review/
        └── adlc-verification/
```

Some agents use a different project-local or global skills directory. Use the location documented
by your agent; the skill contents are plain Markdown and are intentionally tool-agnostic.

## 2. Add the project instruction

Add this short instruction to your project's `AGENTS.md` (or equivalent agent instruction file):

```markdown
## Development workflow

For feature work, use the `adlc` skill as the primary development lifecycle.
Treat `.adlc/` artifacts as the persistent source of truth. Follow the phase gates:
discovery, architecture, specification, task planning, implementation, and verification.
Do not begin implementation before the user approves the feature brief, design decisions
that materially affect the system, and the task plan. Use risk-based testing; do not
create tests solely to increase test count.
```

## 3. Bootstrap project memory

Create `.adlc/PROJECT.md` using `templates/project-context.md`. Keep it concise and factual.
Only document stable project context; do not duplicate the whole codebase.

## 4. Start a feature

Ask the agent to use `adlc` and provide the feature idea. The agent should inspect the project,
create `.adlc/changes/<feature-slug>/brief.md`, and discuss it with you before proceeding.

## 5. Existing projects

Before the first feature, ask the agent to inspect the repository and draft:
- `.adlc/PROJECT.md`
- `.adlc/architecture/overview.md`
- initial capability specs only for important, understood behavior

Do not ask it to document every file or infer undocumented behavior without evidence.
