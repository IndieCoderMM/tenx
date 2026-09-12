---
name: verify
description: Generate manual QA test cases for a flow task into qa.md.
disable-model-invocation: true
---

# Verify

Turn the contract into manual QA steps a human can run. Generate, write, hand over.

Load the `flow` and `craft:proof` skills first — `proof` is how the cases get written.

## Steps

1. **Orient.** Resolve the slug. Read the contract's Done when, the
   accepted phases and iteration items in `tasks.md`, and anything `/validate`
   flagged as risky or needing manual QA.
2. **Generate.** Derive test cases in that order: Done when conditions first,
   then accepted work, then the risky spots. Each case is one action and its
   expected result, phrased so failure is unambiguous.
3. **Write.** Append the cases to `qa.md` per the schema (generated date,
   commit SHA). Set `stage: verifying`.
4. **Hand over.** Point the user at `qa.md` to run the cases and tick what
   passes; failures go to `/iterate <slug>`. All cases ticked → suggest
   `/ship <slug>`, whose gate ticks the Done when boxes.

## Rules

- Only verify writes `qa.md`, and only by appending — never edit past runs.
- Boxes in `qa.md` are ticked by the human, never by you.
- No code changes, no automated test writing — manual QA only.
