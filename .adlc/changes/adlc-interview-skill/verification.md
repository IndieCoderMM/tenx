# Verification: Cross-phase ADLC interview skill

| Acceptance criterion | Evidence / check | Result | Notes |
|---|---|---|---|
| An `adlc-interview` skill describes all five modes and distinguishes meaningful decisions from routine details. | Read `adlc/skills/adlc-interview/SKILL.md`; it names discovery, architecture, specification, planning, and implementation modes and defines when to ask or use judgment. | Pass | The skill says not to create a separate interview record. |
| The main lifecycle and relevant phase skills can invoke it without adding a phase, gate, or interview log. | Read `adlc/skills/adlc/SKILL.md`, `adlc/skills/adlc/references/lifecycle.md`, and the brainstorm, architecture, writing-plans, and executing-plans skills. | Pass | Specification mode is routed through the lifecycle reference because there is no separate specification skill. |
| The phase owner remains responsible for recording decisions in existing artifacts. | Read the interview skill handoff and lifecycle guidance. | Pass | The interview returns the decision; the existing phase owner updates the relevant artifact. |

## Checks performed

- `python /home/l0xbster/.codex/skills/.system/skill-creator/scripts/quick_validate.py adlc/skills/adlc-interview` — exit status 0 (`Skill is valid!`).
- `git diff --check` — exit status 0.
- Manually inspected the new skill and its routing in the phase guidance.

## Checks omitted

- No tests were run. This change adds skill instructions and lifecycle documentation.
- A live interactive interview was not simulated; the skill's behavior is specified in the instructions but was not exercised in a host runtime.

## Remaining limitations

- None identified in the written workflow. Runtime skill discovery depends on the host's normal plugin or skill reload process.
