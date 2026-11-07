---
name: adlc-verification
description: Verify a completed feature against approved acceptance criteria using fresh evidence, proportionate automated checks, and explicit reporting of limitations.
---

# ADLC Verification Before Completion

## Goal

Establish whether the delivered behavior meets the agreed acceptance criteria. Code completion and
green tests alone are insufficient.

## Verification process

For features where an independent pass improves confidence, delegate an acceptance-criteria review
to `adlc-verifier`, providing the change folder and implementation scope. If the host does not load
Tenx agent definitions but supports subagents, use `../../agents/adlc-verifier.md` as the role brief;
do not assume its frontmatter tool permissions are enforced. Verify directly when delegation adds
no value or is unavailable. The coordinator checks the reported evidence and owns `verification.md`.

1. Read the approved brief and acceptance criteria.
2. Read the final design and task plan, including recorded deviations.
3. Inspect the final diff and Git status.
4. Map each acceptance criterion to evidence:
   - automated test;
   - build/type/lint/static check;
   - manual interaction or visual check;
   - inspection of persisted data, API contract, or generated output.
5. Run the relevant checks now; use fresh output, not remembered results.
6. Check important edge cases and failure states proportionate to risk.
7. Confirm no accidental files, secrets, debug code, or unrelated changes remain.
8. Record results in `.adlc/changes/<slug>/verification.md`.

## Verification record

Use a table:

| Acceptance criterion | Evidence / check | Result | Notes |
|---|---|---|---|

Also record:
- commands run and exit status;
- manual checks performed;
- known limitations;
- checks intentionally omitted and why;
- unresolved risks.

## Completion rules

- Never fabricate a successful command or test.
- Never equate test-suite success with complete feature verification.
- Never mark an acceptance criterion complete without evidence.
- If a check cannot be run, state why and what remains uncertain.
- If a criterion fails, return to implementation and verify again.
- If the requirement itself is ambiguous or no longer appropriate, ask the user before changing it.

## Final report

Summarize:
- delivered behavior;
- acceptance criteria status;
- checks actually run;
- review findings resolved or deferred;
- remaining limitations and risks;
- documentation/specification updates;
- next steps, if any.

Only after verification should the orchestrator reconcile current specs and mark the change
`Verified` or `Completed`.
