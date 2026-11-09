# Herdr in hq

HQ and its agents run inside one Herdr session. Every command here needs
`HERDR_ENV=1`: Herdr only controls its own session from inside it. Helper scripts
live in the plugin's `bin/` and are on `PATH` — call them by bare name.

New panes get their PATH from `~/.bashrc`. Errors come back as JSON on stderr
with exit 1; `.error.code` names the cause.

## Probe — `hq-probe`

Run from HQ's pane, in the feature worktree. The builder and reviewer refuse to
start in the main checkout.

```bash
hq-probe builder  <slug> [--model sonnet]
hq-probe reviewer <slug>
hq-probe scout    <slug> route|file "<the question the prototype answers>"
```

It opens a pane, starts Claude in auto mode under the agent name, sends the first
command, and waits until the agent settles. HQ always runs it with
`run_in_background: true`, so HQ is woken when the agent is `idle`, `done`, or
`blocked`. It prints the agent name, pane, path, and final status.

| Kind | Agent name | Where |
|---|---|---|
| builder | `builder-<slug>` | pane split right of HQ, HQ's worktree |
| reviewer | `reviewer-<slug>` | pane split right of HQ, HQ's worktree |
| scout route | `scout-<slug>` | new worktree workspace `<repo>-worktrees/scout-<slug>`, branch `<slug>-scout`, after `wt-setup` |
| scout file | `scout-<slug>` | pane split right of HQ, with `DIR` added as a writable dir |

Names are capped at 32 characters; a long slug is cut to fit.

Exit 3: the agent was blocked at startup (e.g. a folder-trust dialog). Tell the
user to answer it in that pane: `herdr agent focus <name>`.

## Relay — `agent prompt --wait`

```bash
herdr agent prompt builder-<slug> "fix 1, 3 from ## Review" --wait
herdr agent prompt builder-<slug> "/hq:launch" --wait
```

Always with `run_in_background: true`: the same call relays and wakes HQ when the
agent settles. Never poll by hand.

## Answer a blocked agent

A blocked agent (a question or approval dialog) rejects prompts with
`agent_blocked`.

1. Show the user the dialog: `herdr agent read <name> --lines 30`.
2. After the user decides, answer with keys: `herdr agent send-keys <name> down enter`.
3. In the background, `herdr agent wait <name> --until working`, then
   `herdr agent wait <name>`. A plain wait right after `send-keys` returns the
   stale `blocked`.

## Look — `hq-radar`, focus

```bash
hq-radar                          # every live hq agent: state, stage, tasks, Resume
herdr agent read <name> --lines 30
herdr agent focus <name>          # bring the agent's pane forward for the user
```

## Clean up

After the PR merges: `herdr pane close <pane>` for the builder and reviewer panes
(pane IDs from `herdr agent get <name>`). The feature worktree is HQ's, removed
the usual way. A route scout's workspace: `herdr worktree remove --workspace <id>`
deletes the worktree and keeps the `<slug>-scout` branch.
