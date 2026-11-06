# aoe in flow

Work sessions are aoe sessions. Helper scripts live in the plugin's `bin/` and are
on `PATH` — call them by bare name.

## Spawn — `flow-spawn`

Run from the repo's main checkout (HQ's directory).

```bash
flow-spawn build  <slug> [--model sonnet]
flow-spawn review <slug>
flow-spawn proto  <slug> route|file "<the question the prototype answers>"
```

It creates the aoe session (worktree, group, parent = HQ when HQ runs inside aoe),
starts Claude in auto mode, waits until the prompt is ready, sends the first
command, writes `worktree:` into `plan.md` for build, and prints the title and the
attach command.

| Kind | Title | Directory |
|---|---|---|
| build | `build-<slug>` | new worktree `<repo>-worktrees/build-<slug>`, branch `<slug>` |
| review | `review-<slug>` | the build session's worktree |
| proto route | `proto-<slug>` | new worktree `<repo>-worktrees/proto-<slug>`, branch `<slug>-proto` |
| proto file | `proto-<slug>` | main checkout, with `DIR` added as a writable dir |

Exit code 3 means the session hit a trust dialog or never became ready — tell the
user to attach and check.

## Wait — `flow-wait`

```bash
flow-wait <title>
```

Blocks until the session stops running, then prints its status (`idle`,
`waiting`, `stopped`, `error`) and the last lines of its pane. HQ always runs it
with `run_in_background: true` right after a spawn or relay, one per session, so
HQ is woken when the work stops. Never poll by hand.

## Relay — `aoe send`

```bash
aoe send build-<slug> "fix 1, 3 from ## Review"
aoe send build-<slug> "/flow:ship"
```

Then start a new background `flow-wait` for that session.

## Look — `flow-board`, attach

```bash
flow-board                      # every live flow session: status, stage, phases, Resume
aoe session attach <title>      # the user drives the session directly
```

## Signal — colour

Work sessions set their own colour so the aoe dashboard shows state at a glance:

```bash
aoe session color "$(aoe session current -q)" amber   # working
aoe session color "$(aoe session current -q)" red     # needs the user (⏸, blocker, question)
aoe session color "$(aoe session current -q)" green   # done
```

## Clean up

After the PR merges: `aoe remove build-<slug> --delete-worktree`, and the same for
`review-<slug>` and `proto-<slug>`. The local proto branch is kept (aoe does not
delete branches) so `/flow:build` can port from it.
