# ADLC — Agent Development Lifecycle

A portable, project-oriented skill bundle for taking a feature from idea to verified delivery.

This bundle is an original, integrated implementation inspired by common agent-workflow patterns:
collaborative discovery, architecture decision records, specification-first planning, incremental
execution, pragmatic testing, code review, and evidence-based verification. It does not reproduce
third-party SKILL.md files verbatim. The source skills' licences and terms should be checked before
redistributing their original text.

## Bundle layout

```text
adlc-skill-bundle/
├── README.md
├── INSTALL.md
├── templates/
│   ├── project-context.md
│   ├── feature-brief.md
│   ├── design.md
│   ├── tasks.md
│   ├── adr.md
│   └── feature-spec.md
└── skills/
    ├── adlc/SKILL.md
    ├── adlc-brainstorm/SKILL.md
    ├── adlc-architecture/SKILL.md
    ├── adlc-writing-plans/SKILL.md
    ├── adlc-executing-plans/SKILL.md
    ├── adlc-pragmatic-testing/SKILL.md
    ├── adlc-code-review/SKILL.md
    ├── adlc-receiving-review/SKILL.md
    └── adlc-verification/SKILL.md
```

## Core principles

1. Discussion before commitment; commitment before implementation.
2. Repository artifacts, not chat history, are the durable source of truth.
3. The user approves product scope and consequential architectural choices.
4. Work is delivered in small, reviewable increments.
5. Testing is risk-based and purposeful—not test-count maximization.
6. A task is complete only when its acceptance criteria have evidence.
7. Keep project-level truth separate from an in-progress feature's proposal.

## Default artifact layout in a target repository

```text
.adlc/
├── PROJECT.md
├── architecture/
│   ├── overview.md
│   └── decisions/
│       └── ADR-001-example.md
├── specs/
│   └── <capability>/
│       └── spec.md
└── changes/
    └── <feature-slug>/
        ├── brief.md
        ├── design.md
        ├── tasks.md
        ├── verification.md
        └── notes.md
```

Completed changes stay under `changes/` as a durable history. Their accepted behavior is merged
into `specs/`; important lasting architecture decisions are recorded under `architecture/decisions/`.
Do not delete the change folder after completion.

## Skill invocation

Use `adlc` as the entry point. It routes to the focused skills when needed. The subskills can also
be invoked directly, but they must follow the same artifact conventions and quality principles.

## Design choices

- No mandatory TDD loop.
- Tests are selected by risk, complexity, and expected regression cost.
- Avoid speculative abstractions and unnecessary documentation ceremony.
- Do not create parallel agents or branches unless the user or task clearly benefits.
- Never silently change an approved requirement or architectural decision.
