# Verification: ADLC role agents

| Acceptance criterion | Evidence / check | Result | Notes |
|---|---|---|---|
| Three role agents exist with distinct tool permissions and scoped instructions. | Manually inspected `adlc/agents/adlc-builder.md`, `adlc-reviewer.md`, and `adlc-verifier.md`. Builder has implementation tools and is restricted to its assigned files; reviewer and verifier have no write/edit tools and return findings/evidence only. | Pass | Agent runtime loading was not exercised. |
| Execution, review, and verification skills delegate to the corresponding role and retain coordinator ownership of ADLC artifacts. | Manually inspected `adlc-executing-plans`, `adlc-code-review`, `adlc-verification`, and the main `adlc` skill. Each defines role use or fallback; coordinator retains `.adlc/` records and checks agent output. | Pass | Direct-work fallback is documented. |
| ADLC documentation states that parallel implementation is only for independent approved tasks. | Manually inspected `adlc-executing-plans`, `adlc-writing-plans`, and the main `adlc` skill. | Pass | Boundaries must be disjoint and dependencies complete. |
| Host compatibility and current Codex registration behavior are clear. | Inspected `link.sh`; documented in `adlc/README.md` and `.adlc/architecture/overview.md`. | Pass | Codex receives individual skills through the current linker, not agent definitions; README explains role-brief and direct-work fallbacks. |

## Checks performed

- `git diff --check` — exit status 0.
- Manually inspected all three agent definitions, the affected ADLC skills, the README, architecture overview, and change artifacts.
- Confirmed each relative role-brief path resolves to its corresponding agent definition.

## Checks omitted

- No tests or plugin validator were run; this change adds agent instructions and workflow documentation.
- A live Claude Code or Codex agent invocation was not performed, so host runtime loading remains unverified.

## Remaining limitations

- The current `link.sh` does not register agent definitions with Codex. Hosts that do not load Tenx agent definitions can use the corresponding file as a subagent role brief, but its frontmatter tool permissions are not enforced there.
