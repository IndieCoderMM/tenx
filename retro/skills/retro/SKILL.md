---
name: retro
description: Weekly workflow retrospective — measure the last 7 days of Claude Code work, check last week's experiments, turn friction notes and signals into at most five ranked changes, record the picked ones, and render the dashboard.
disable-model-invocation: true
---

# Retro

Review how the week of work went, decide what to change, and make it checkable
next week. The loop: **measure → judge last week's experiments → find → pick →
record → render → apply.**

Load `references/review.md` before step 5 — it holds the review file schema and
the metric keys.

Arguments: `[--days N]` — window length, default 7.

## Steps

1. **Measure.** Run `retro stats` (pass `--days` through). Read the week file it
   prints, `~/.tenx/retro/weeks/<week>.json`, in full.
2. **Judge last week.** Find the newest `~/.tenx/retro/weeks/*.review.json` older than
   this week. For each of its `experiments`, compare the watched metric then
   (that week's file) and now. Verdict: `keep` (moved the wanted way),
   `adjust` (flat or mixed — say what to change), or `revert` (moved the wrong
   way, or the change caused new friction). No prior review → skip.
3. **Find.** Build at most five findings, ranked by cost to the user:
   - Friction notes first — the user's own words outrank any count.
   - Then signals that moved the wrong way, or stay high.
   - Read the `samples` to explain *why* a number is what it is; the count
     says something is wrong, the sample says what.
   Each finding names its evidence (a count with its delta, or a quote) and one
   concrete change at the place the behaviour is defined: a skill under
   `~/Dev/tenx/`, `~/.claude/CLAUDE.md`, `~/.claude/settings.json`, a repo's
   `CLAUDE.md`, a tool's config. Prefer deleting a rule or gate over adding one.
4. **Present.** In chat: last week's verdicts (one line each), then the
   numbered findings — title, evidence, change, file. Ask which to pick by number.
5. **Record.** Write `~/.tenx/retro/weeks/<week>.review.json` per the schema:
   verdicts, every finding with `picked` set, and one experiment per picked
   finding naming the metric it should move.
6. **Render.** Run `retro render` and give the user the `file://` path.
7. **Apply.** Make the picked changes as ordinary edits, then report what
   changed, file by file.

## Rules

- No finding without evidence from this week's file. "Seems like" is not evidence.
- At most five findings; at most three picked is the healthy default — more
  changes at once and next week's verdicts can't tell which one worked.
- An experiment must name a metric key from `references/review.md`. A change
  no metric can see (e.g. a wording fix) uses `friction` and says so.
- Never edit the week file `retro stats` wrote; only the `.review.json`.
- Don't apply anything before the user picks.

## Related skills

- `friction` — the capture side; tell the user about `/friction` when the week
  has no notes.
- `craft:unslop` — on the findings before presenting.
