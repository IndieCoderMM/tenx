# Logging

`logs.tsv` is the append-only history of a task and the signal a new session
resumes from. Read before writing a row or reconstructing where a task left off.

## Contents

- Write a row — the exact command
- Kinds — the closed vocabulary
- Read the resume signal — tail, reversals, precedence
- Out of scope — what does not belong in the log

## Write a row

Run the script. Never hand-write a row, not even into an empty file.

```bash
flow-log <folder> <kind> "<summary>" [--phase N] [--ref X]
```

`flow-log` is on PATH — call it by name, never by path.

**Example**
```bash
flow-log ~/.tenx/flow/chat/123-chat-backend \
    decision "route pattern selection through the cap check, not around it" \
    --phase 2 --ref 8f2a11c
```

Columns are `ts`, `kind`, `phase`, `summary`, `ref`.

- **summary** — one clause, present tense, stating what is now true. Under 120
  characters, so write it short rather than letting the script cut it.
- **--phase** — the item id from `tasks.md`: `2` for a planned phase, `I.1.3` for
  an item in iteration block 1. Omit when the row belongs to no item.
- **--ref** — one anchor: a commit SHA, issue URL, or file path. Not a list.

Log on transitions, not on actions: a decision made, an approach abandoned, a
phase accepted, work blocked or unblocked, the PR opened.

## Kinds

Closed set; the script rejects anything else.

| Kind        | Use when                                                    |
| ----------- | ----------------------------------------------------------- |
| `decision`  | a choice was made and is now in force                       |
| `reversed`  | a previous decision or approach was abandoned               |
| `blocked`   | work stopped pending something external                     |
| `unblocked` | that something arrived                                      |
| `done`      | a phase or iteration item was accepted by the human         |
| `note`      | anything else a future session needs and git will not show  |


## Read the resume signal

Read the tail rather than the file:

```bash
tail -5 ~/.tenx/flow/<repo>/<slug>/logs.tsv
awk -F'\t' '$2=="reversed"' ~/.tenx/flow/<repo>/<slug>/logs.tsv
```

When sources disagree, precedence runs:

1. `logs.tsv` — what was decided and reversed
2. `tasks.md` — what was built
3. `contract.md` — what the target is
4. git — what the code does

Log and checkboxes disagreeing is drift. Report it and ask; do not silently pick
one.

## Out of scope

- Session narration. "Started phase 2, read some files."
- Anything visible in the diff. The code is the record of the code.
- Restating a `tasks.md` note, or the reverse. One home per fact.
- A proposal that was not adopted. That is not a decision. Adopted then dropped
  is two rows: `decision`, then `reversed`.
