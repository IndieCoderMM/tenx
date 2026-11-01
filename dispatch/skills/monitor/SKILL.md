---
name: monitor
description: Triage everything assigned to you — open Linear and GitHub issues, their PRs, what is newly assigned, and what has gone stale. One batched scan, reported in seconds; details on any one item only when you ask. Use when asked what to work on, what is assigned, for status or progress, to plan the day, or to check open PRs and issues.
---

# Monitor

Two passes. The **scan** is one batch of list queries and a report — it is what
runs by default. The **drill** looks one item up close, and runs only when the
user asks for that item.

Read-only. Every change goes through another skill, named at the end.

## 1. Scan

Five list queries, all in a single batch. They do not depend on each other, so
they go out together and nothing waits on anything.

```bash
gh search issues --assignee=@me --state=open --limit 50 \
  --json number,title,repository,url,labels,createdAt,updatedAt
gh search prs --author=@me --state=open --limit 50 \
  --json number,title,repository,url,isDraft,body,createdAt,updatedAt
```

Linear, in the same batch — `mcp__plugin_linear_linear__list_issues` with
`assignee: "me"`, `limit: 50`,
`fields: ["title", "status", "priority", "url", "gitBranchName", "createdAt", "updatedAt", "team"]`,
and `state` set to `started`, `unstarted`, and `backlog` in turn.

`state` takes one status type, so scope the calls rather than filtering after the
fact. An unfiltered `list_issues` sorts by `updatedAt` and caps at 50, which on a
live workspace is mostly `Done` rows with open work truncated past the cursor —
the three scoped calls together return less and miss nothing. Each one also feeds
exactly one report table below.

**This batch is the whole scan.** No `gh pr view`, no `gh pr checks`, no
`gh issue view`, no `get_issue`, no `git` — those are the drill, and a scan that
fans out into them takes minutes instead of seconds. Report what these five
queries returned and stop.

The `gh search` queries run outside a git repo, so this works from anywhere. A
source that fails is named in the report — `Linear unavailable`,
`GitHub unavailable` — never dropped silently, never backfilled with guesses.

## 2. Pair issues with PRs

From the payload already in hand — no lookups.

- PR → GitHub issue: closing keywords in the PR `body` (`closes #12`, `fixes org/repo#12`).
- PR → Linear issue: a `linear.app/…/issue/…` url or a bare identifier (`CC-187`) in the PR body, or the PR's head branch matched against `gitBranchName`.

An issue and its PR are one row. A Linear issue that tracks a GitHub issue prints
joined — `CC-187 / crewclip#267` — never as two rows. The pairing must come from
a url, a body reference, or a branch name. A close-looking title is not
identification; leave them separate when nothing links them.

An unpaired PR still prints, in its own row under **In progress**.

## 3. Report

Three tables, each issue in exactly one, most recently touched first. The issue
cell is the tracker identifier (`CC-187`, `tenx#14`) linked to its url. Skip a
table with no rows.

**In progress** — started, and something moved within 7 days. Columns: issue,
title, pr, touched.

**Stale** — started but untouched for 7 days or more. Same columns plus a `why`
cell naming what went quiet and for how long.

**New** — not started, no PR. Columns: issue, title, priority, created, source.
Highest priority first, then newest — Linear `priority` is an object, so read
`.name` and order `Urgent`, `High`, `Medium`, `Low`, `No priority`; the raw
`value` sorts wrong because `0` means none, not top. Collapse Linear `backlog`
rows into one trailing row that names them — they are not next.

The `pr` cell holds what the list query knows and nothing more: the number,
`draft` when `isDraft`, and its age. **Review and CI state are not in this
pass** — leave the cell at that rather than guessing, and never write `ci green`,
`approved`, or `conflicts` here.

## 4. Hand back

Close with at most three candidates worth a closer look, one line each, ranked by
what the scan can actually see: a PR that has sat longest, the oldest stale
issue, the highest-priority unstarted one. Say which drill each would trigger.

Then stop and let the user pick. Do not drill on your own initiative, and do not
pre-fetch one item's details because it looks like the obvious pick.

## 5. Drill

On request, for the named item only.

| Asked about | Run |
|---|---|
| A PR's review and CI state | `gh pr view <n> -R <repo> --json isDraft,reviewDecision,mergeStateStatus,statusCheckRollup` |
| Why CI is red | `gh pr checks <n> -R <repo>` |
| A GitHub issue's PRs, when the body gave nothing | `gh issue view <n> -R <repo> --json closedByPullRequestsReferences` |
| A Linear issue in full | `mcp__plugin_linear_linear__get_issue` — attachments carry the PR links |
| Whether local work is pushed | `git status --short`, `git log @{u}..` |

Collapse a PR's state to one label, worst first: `ci red`, `conflicts`,
`changes requested`, `ci pending`, `draft`, `ready`.

Then route:

| State | Route to |
|---|---|
| PR `ready` | merge it — `gh pr merge`, confirm first |
| PR `ci red`, `conflicts`, or `changes requested` | fix the branch, then `dispatch:commit` |
| PR `draft` with the work done | `dispatch:pr <url>` to finish the body and mark ready |
| Branch pushed, no PR | `dispatch:pr` |
| Tracker behind the code | `dispatch:issue <url>` |
| Newly assigned, worth starting now | `/flow:brainstorm <issue>` |
| Stale 14 days or more | close it or re-plan — ask which |

Run one when asked. Invoking it hands over completely — that skill's own rules
apply, including its approval gate.

## Rules

- Never write a commit, PR body, or issue here. Routing is the only action.
- One question, one batch. Never chain a query to answer something the user has not asked yet.
- Every fact traces to a command that ran. Extra queries are welcome once asked for; invented rows are not.
- State disagreements rather than resolving them: tracker says Todo, a PR is open for it, print both.
- Assignment dates are not exposed by either tracker. `created` is a proxy — label it as created, never as assigned.
