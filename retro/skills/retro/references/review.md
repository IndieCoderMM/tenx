# Review file

`~/.tenx/retro/weeks/<week>.review.json`, written once per retro by the `retro`
skill. `retro render` reads it next to `<week>.json`; nothing else does.

```json
{
  "week": "2026-W40",
  "date": "2026-10-01",
  "verdicts": [
    {
      "experiment": "execute skips the todo gate when the list matches the phase",
      "metric": "approvals_per_100",
      "before": 11.3,
      "after": 6.2,
      "verdict": "keep",
      "note": "fewer 'go' replies after /execute"
    }
  ],
  "findings": [
    {
      "title": "Interrupts jumped",
      "evidence": "22 interrupted turns (+19); 5 of 8 samples are Claude editing before the plan was agreed",
      "change": "Add 'state the plan in one line before the first edit' to the global CLAUDE.md",
      "file": "~/.claude/CLAUDE.md",
      "picked": true
    }
  ],
  "experiments": [
    {
      "change": "State the plan in one line before the first edit",
      "metric": "interrupts",
      "target": "down"
    }
  ]
}
```

- `verdict` is one of `keep`, `adjust`, `revert`.
- `before` is the metric in the week the experiment started; `after` is this week's.
- `target` is `down` or `up`.
- Every picked finding has exactly one matching experiment.

## Metric keys

| Key | Meaning | Better |
|---|---|---|
| `approvals_per_100` | one-word replies (go, ok, commit, continue…) per 100 typed prompts | down |
| `corrections` | prompts opening with no / don't / stop / wrong / why did… | down |
| `interrupts` | turns the user interrupted | down |
| `denials` | tool calls the user rejected | down |
| `tool_errors` | failed tool calls, denials excluded | down |
| `usage_checks` | `/usage` runs | down |
| `compactions` | auto and manual compactions | down |
| `reversal_rate` | flow `reversed` rows / `done` rows | down |
| `stale_tasks` | flow tasks not shipped, no log for 7–60 days | down |
| `stale_worktrees` | linked worktrees with no commit for 14+ days (current week only) | down |
| `friction` | friction notes captured | — |
| `prompts`, `sessions`, `flow_done` | activity, no direction | — |
