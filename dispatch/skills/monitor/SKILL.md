---
name: monitor
description: Overview of active work — flow tasks, open PRs, assigned issues, and what to do next, printed in chat. Use when asked what is active, what to work on, to plan the day, for status or progress, where things were left off, or for the PRs and issues related to the current work.
---

# Monitor

Read the state of active work and print it. Then route to the skill that acts on it.

Read-only by itself. Every change goes through another skill, named at the end.

## Scope

**Wide** — no argument, or asked to plan the day, or the session has no work in
it yet. Every flow task across every repo, plus your open PRs and assigned
issues.

**Focused** — a slug, repo, issue, or PR given, or this session already has work
in flight. That task only: its tracker, its PR, its next item.

When in doubt, run wide. A wide overview answers a focused question too.

## Gather

```bash
dispatch-monitor              # everything, 30-day window on PRs and issues
dispatch-monitor --repo <r>   # one repo's tasks
dispatch-monitor --no-remote  # tasks only, no gh
dispatch-monitor --days 0     # include everything, however old
dispatch-monitor --all        # keep repos that have no active task
```

It reads the task folders, then `gh search prs --author=@me` and
`gh search issues --assignee=@me`. Those work outside a git repo, so a wide
overview runs from anywhere. `gh unavailable` under a heading means the query
failed, not that nothing is open.

PRs and issues in repos with no active task are counted, not listed. When the
question is about one of those, rerun with `--all`.

Print the `TASKS`, `PRS`, and `ISSUES` blocks in a fenced block, rows exactly as
the script emitted them. Do not reformat, re-sort, or re-align — fixed columns
are the point, and retyping invites invented rows.

Drop the trailing `N older than the window, hidden` and `N in repos with no
active task, hidden` lines. Those are addressed to you, not the user: they say a
rerun with `--days 0` or `--all` would show more. Rerun when the question needs
it; keep the counts out of the report.

The script is the baseline, not the ceiling. It answers what is open; anything
the question needs beyond that, go fetch — `gh pr view` for review and merge
state, `gh pr checks` for CI, `git log`/`git status` for the branch, the Linear
tools for one issue. Run what the question needs and no more.

Then add what the script did not cover — at most four bullets, one line each,
each naming where it came from:

- In the current repo, `git status --short` and whether the branch has commits
  the remote does not.
- For a task in focus, the tracker's own state via `gh issue view` or the Linear
  tools for that one issue. Never list, search, or browse a tracker for a
  plausible match. A close-looking title is not identification.
- Anything this session did that the folders do not show yet.

A row missing from TASKS means there is no task folder for it. Say that, and
stop — do not go hunting other directories for a plausible substitute.

## Assigned

Wide scope only. The script answers what is open. It does not answer what landed
on you and has not been picked up — it has no Linear access, so a Linear-only
issue never reaches `ISSUES` at all. Build that section yourself.

`mcp__plugin_linear_linear__list_issues` with `assignee: "me"` and `state` for
Linear's own unstarted types — `unstarted` (Todo) and `backlog`. Request
`fields: ["title", "status", "priority", "createdAt", "updatedAt", "url", "description"]`;
`id` always comes back.

Then cut anything already in flight. Keep an issue only when it has no `TASKS`
row pointing at it and no `PRS` row for it. A GitHub row from `ISSUES` that
clears the same bar and has no Linear counterpart belongs here too.

One issue is one row. A Linear issue tracking a GitHub issue prints joined —
`CC-187 / crewclip#267` — never as two rows. The pairing comes from the Linear
issue's `url`, `description`, or attachments. A close-looking title is not
identification; leave them separate when nothing links them.

A markdown table, columns: issue, status, priority, created, last touched.
Highest priority first, then most recently touched. Collapse `backlog` rows into
one trailing row naming them, dashes for the dates — they are not next.

Omit the section when nothing survives the cut. If the Linear tools fail, say
`Linear unavailable` under the heading rather than dropping it silently.

## Next

Two or three suggestions, most useful first, each traceable to something printed
above. No suggestion without a reason.

Every entry is an action to take. Never spend one ruling a route out, and never
append an extra observation after the list.

| State | Route to |
|---|---|
| Open items in the current phase | `/flow:execute <slug>` |
| Phase items all done, uncommitted work | `/flow:checkpoint <slug>` |
| Commits since the last checkpoint, no review yet | `/flow:review <slug>` |
| All phases accepted | `/flow:validate <slug>` |
| Done-when ticked, no PR | `/flow:ship <slug>` |
| Branch moved on since the PR body was written | `dispatch:pr <url>` |
| Tracker stale against real progress | `dispatch:issue <url>` |
| Staged work sitting uncommitted | `dispatch:commit` |
| Task blocked in the log | `craft:recover` |
| Newest log row is days old and the branch has moved | `/flow:reconcile <slug>` |
| Work in flight with no task folder | `/flow:brainstorm` |
| Assigned, not started, worth starting now | `/flow:brainstorm <issue>` |

Run one when asked. Invoking it hands over completely — that skill's own rules
apply, including its approval gate.

## Rules

- Never write a doc, a commit, a PR body, or an issue. Routing is the only action.
- Report what the sources say. A task the log calls blocked is blocked, even when
  the branch looks busy.
- Every fact traces to a command that ran. Extra queries are welcome; invented
  rows are not.
- State disagreements rather than resolving them: log says blocked, branch has
  new commits, say both.
