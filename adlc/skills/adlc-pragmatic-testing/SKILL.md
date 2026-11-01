---
name: adlc-pragmatic-testing
description: Select and perform the smallest useful set of tests and checks based on risk, edge cases, correctness, and regression cost; avoid test-count-driven TDD.
---

# ADLC Pragmatic Testing

## Philosophy

Testing exists to reduce meaningful risk, not to maximize test count or enforce a ritual.
Do not write a test for every function, trivial mapping, static constant, or implementation detail.
Prefer a small number of high-value tests that protect important behavior and likely failure modes.

Test-first development is optional. Use it when it clarifies behavior or prevents costly mistakes,
not as a universal requirement.

## Risk-based selection

Consider:
- impact if the behavior is wrong;
- likelihood of failure or regression;
- complexity and number of branches/states;
- boundary conditions and unusual inputs;
- data integrity and persistence;
- concurrency, async behavior, retries, and external dependencies;
- security/privacy implications;
- whether existing tests already cover the behavior.

Choose the lightest verification that gives adequate confidence.

## When a unit test is valuable

Write focused unit tests for:
- non-trivial business rules or calculations;
- edge cases and boundary conditions;
- parsing, validation, normalization, and transformation logic;
- state transitions with meaningful branches;
- error handling and recovery behavior;
- previously fixed bugs that could regress;
- code with high impact and low observability.

Avoid tests that:
- simply mirror each line or method;
- assert private implementation details;
- duplicate coverage already provided by a stronger test;
- require brittle mocks for simple behavior;
- test framework behavior rather than application behavior;
- add substantial maintenance cost for negligible risk.

## Choose the right level

- **Unit:** isolated rules, transformations, validators, state transitions.
- **Integration:** persistence, API boundaries, module interactions, serialization, framework wiring.
- **End-to-end:** a small number of critical user journeys where integration failures are plausible.
- **Manual/visual check:** layout, interaction feel, accessibility inspection, and behavior difficult
  to assert reliably in automated tests.
- **Static/build checks:** types, lint, formatting, compilation, migrations, schema validation.

Do not add an end-to-end suite for every feature. Prefer a few critical journeys.

## Practical workflow

1. Identify changed behavior and plausible failure modes.
2. Inspect existing coverage and test conventions.
3. Select only checks that address uncovered risk.
4. Add or update tests where the expected value exceeds maintenance cost.
5. Run focused checks first, then broader checks when scope/risk warrants it.
6. Inspect failures; do not weaken assertions merely to get a green run.
7. Record commands and observed results.

## TDD guidance

Use a red-green-refactor loop when:
- behavior is well-defined and testable;
- logic is non-trivial;
- edge cases are easy to enumerate;
- the test gives a clear design feedback loop.

Do not force TDD for:
- exploratory spikes;
- visual styling and layout tuning;
- generated boilerplate;
- simple wiring/configuration changes;
- behavior whose value is better assessed through a manual or integration check.

## Completion standard

The goal is adequate confidence, not proof of absence of defects. State what was tested, what was
not tested, and why. Never claim comprehensive coverage without evidence.
