---
name: size
description: Size a task for an agent build, XS to XL, from the files it really touches - never hours or days. Use when asked how big, how much effort, how long, or how hard a feature, fix, or ticket is, or to compare tasks by effort.
---

# Size

Size a task by how much code it touches and how much of the user's attention it
needs. An agent's typing time is near zero, so calendar time is the wrong unit.
Never answer in hours, days, or story points.

Argument: a task in words, a ticket id or URL, or "this" (the conversation).

## Steps

1. **Pin the change.** One sentence: what changes, seen from the user. If two
   readings would size differently, size both and say which you assumed.
2. **Count.** One Explore subagent finds where the change lands: files to edit
   or create, call sites of every symbol whose shape changes, layers crossed
   (UI, route, server, DB schema, infra), and how the result can be checked.
   Use its counts; don't read files yourself. Follow shared types and
   signatures to their callers: that is where a "small fix" turns wide.
3. **Size** from the table, then apply the bumps.
4. **Report** in the format below.

## Scale

| Size | Touches |
|---|---|
| XS | 1 file, one place |
| S | 2-5 files, one layer |
| M | 5-15 files, or crosses layers |
| L | 15+ files, or a migration or public contract change; more than one phase |
| XL | New subsystem, or open product unknowns. Settle them first (`/flow:ideate`, a prototype) |

Bump one size for each, at most two:

- A shared type, API, or contract whose callers must change.
- A schema migration or data backfill.
- A library or service this repo hasn't used yet.
- A result only a person can judge (how a UI looks or feels).

## Report

A markdown table, not a code block, and nothing after it. The size is the
header row; then exactly three rows. No lists or line breaks inside a cell.

```
| size   | M ■■■□□ · 9 files · 3 layers                            |
|--------|---------------------------------------------------------|
| where  | routes/clips (4), server/clips (3), packages/db (2)     |
| driver | wider than it looks: ClipMeta type changes, 14 callers  |
| checks | 2 · new column shows in clip list · migration runs clean |
```

- Bar: XS `■□□□□`, S `■■□□□`, M `■■■□□`, L `■■■■□`, XL `■■■■■`.
- `where`: file paths when 3 or fewer, else folders with counts.
- `driver`: the single biggest reason for the size, with the fact behind it.
  Start with `wider than it looks:` when the footprint beats the task's
  wording.
- `checks`: how many things the user must look at by hand, then each in a few
  words.

A fourth row only when two readings of the task would size differently:
`| assumed | <reading>; <other reading> would be <size> |`.
