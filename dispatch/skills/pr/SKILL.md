---
name: pr
description: "Writes a pull request title and body from the actual git diff, then opens or updates the PR after you approve the draft. Given a PR link or number it updates that PR in place; otherwise it opens a new one. Use when the user asks to write, open, create, draft, or update a PR or pull request description, title, or body."
---

# PR Write

IRON LAW: Write for a teammate who has not seen the code. Say what changed and why in their words, and keep it short enough to read in one pass.

## Workflow

```
PR Write Progress:

- [ ] Step 0: Resolve the target — update an existing PR, or open a new one
- [ ] Step 1: Read the change ⚠️ REQUIRED
- [ ] Step 2: Check repo conventions
- [ ] Step 3: Write the title
- [ ] Step 4: Write the body
- [ ] Step 5: Unslop, then present draft in chat ⛔ BLOCKING
- [ ] Step 6: Push and create PR after explicit OK
```

## Step 0: Resolve the target

A PR link or number in the invocation means **update that PR** — never open a
second one. With none given, check for a PR already open on this branch:

```bash
gh pr view --json number,url,title,body 2>/dev/null
```

Found one → update it. Nothing → open a new PR.

When updating, read the current title and body first. They are the starting
draft: every line carries forward unless this session's diff gives you a reason
to change it. Rewriting stable lines for style hides the changes that matter.

## Step 1: Read the change ⚠️ REQUIRED

```bash
git rev-parse --abbrev-ref HEAD
git log --oneline @{u}..HEAD 2>/dev/null || git log --oneline -20
git diff --stat $(git merge-base HEAD origin/HEAD 2>/dev/null || echo origin/main)...HEAD
git diff $(git merge-base HEAD origin/HEAD 2>/dev/null || echo origin/main)...HEAD
```

Answer these before writing:
- What can a user or developer do now that they could not before?
- Which change is the point, and which ones exist to support it?
- Is there a ticket or issue ID in the branch name or commit messages?
- Does anything here break existing callers, stored data, or config?

When the diff holds several unrelated changes, say so in the draft and offer to split the PR first.

## Step 2: Check repo conventions

```bash
ls .github/PULL_REQUEST_TEMPLATE.md .github/pull_request_template.md 2>/dev/null
git log --oneline -15
```

Use the repo's own template headings when one exists, filled with the content below. Otherwise use `assets/pr-template.md`. Take scope words from recent commit subjects.

## Step 3: Write the title

Format: `type(scope): summary`

- Types: `feat` `fix` `refactor` `perf` `docs` `test` `chore` `build` `ci` `revert`
- Scope: the subsystem touched, lowercase, one word.
- Summary: imperative, lowercase, no period, whole title around 50 characters.
- Choose the type of the point of the change: a feature that required a refactor is `feat`.
- Mark a breaking change with `!`: `feat(api)!: drop v1 token endpoint`

```
feat(auth): add rate limit to login route
fix(player): stop seek jump on scene switch
refactor(db): extract query builder from repo layer
```

## Step 4: Write the body

Sections in this order: description, Context, Changes, How to Test, then Notes when there is something to note.

### Description (no heading)

Open with a short paragraph, two or three sentences, saying what this PR does. Written so anyone on the team understands the change without opening the diff.

### `## Context`

Bullets, one sentence each, one per reason this change exists, in present tense. A reason is either a bug (what goes wrong today and who it affects) or a need (what was missing, what it blocked, what someone asked for).

End the section with a separate bullet list of related issues and tickets, when the branch name, commits, or user's message name any:

```markdown
- Closes #482
- Ticket: https://tracker.example.com/BIL-119
```

### `## Changes`

Up to five bullets covering the key approaches and changes. Each bullet is one short sentence naming the behavior or the decision, in product language. Mention a file, symbol, or table only when the reviewer cannot follow the bullet without it.

Keep the bullets at the level of what a user or reviewer sees, not the level of the diff. Do not list the components, props, hooks, or functions touched, do not narrate what replaced what internally, and do not chain several changes into one bullet with "and" or a trailing clause. Give the reason only when the change looks wrong without it, and then in a few words.

Bloated, do not write this:

```markdown
- Removed the collapsible right hand panel (`generation-panel.tsx`, `visual-tab.tsx`) and its gear toggle, replacing them with Brief and Storyboard tabs in the main panel toolbar.
- Replaced the character accordion with a card row plus one shared detail panel, so the selected character's portrait, appearance, render style and generate action sit together.
```

Same changes, written right:

```markdown
- Brief and Storyboard moved into the main toolbar as tabs, replacing the right hand panel.
- Characters show as a card row with one shared detail panel.
```

When the PR carries several unrelated changes, group the bullets under bold labels by scope or feature, so a reviewer can read only the part they own:

```markdown
**Billing statement**

- One line per video release instead of one per internal grant bucket.

**Plan terms**

- Plans accept a term in months, so the end date lands on a billing boundary.
```

Put anything small and incidental to the main change under a final **Minor fixes** group, one bullet each: side bug fixes picked up along the way, typos, dead code removal, comment sweeps, version bumps. A fix belongs here when it is not what the PR is for. If the fix is the point of the PR, it goes in the main bullets.

### `## How to Test`

A checkbox list a reviewer follows in the running app, without reading the diff. Start from a clean state, give the exact route, screen, or button per step, and say the result to expect. Cover only the manual path through the app: never list test commands or automated checks. When the change has no manual surface, say which part of the app to exercise to see it, or state that there is no manual surface.

### `## Notes`

Add this section when the reviewer needs to know something the diff does not show, one sentence per bullet: known gaps left in place, a follow-up PR already planned, steps to run before or after merge (migration, flag flip, config change), or a part of the change that deserves closer review.

### Punctuation

No em dashes or en dashes anywhere in the title or body. Use a comma, a colon, parentheses, or a second sentence instead. Hyphens in compound words are fine.

End the body at the last section. Never append a generated-by, co-authored-by, or tool-attribution footer.

### Line breaks

Write each paragraph and each bullet as one unbroken line, however long it runs. GitHub wraps the body to the reader's window, so hard-wrapped source lines come out ragged there. Break a line only between blocks.

### Full example

```markdown
Credits now read as one line per video release instead of one line per internal grant bucket, and the billing meter matches the numbers in threshold emails. Plans can also be sold with a fixed term.

## Context

- The running balance appears to move backwards, because one charge can split into several statement rows.
- The usage meter and the alert email compute the same percentage from different totals, so the page can contradict the email it triggered.
- Sales cannot offer fixed-term plans, because nothing ends a plan on a set date.

- Closes #482
- Ticket: https://tracker.example.com/BIL-119

## Changes

**Billing statement**

- One statement line per video release instead of one per grant bucket.
- Usage percentage now matches the figure in threshold emails.

**Plan terms**

- Plans can be sold with a fixed term in months.
- Pilot access is a plan tier rather than a global build flag.
- Internal margin prices each plan span at the rate in force then.

**Minor fixes**

- Invoice date no longer shifts a day for workspaces west of UTC.
- Removed the unused pilot card and stale comments.

## How to Test

- [ ] Open `/app/billing` on a workspace that released three videos in one charge, and confirm the statement shows one line per release.
- [ ] Compare the usage percentage on that page against the last threshold email, and confirm they match.
- [ ] Provision a plan with a 12 month term, then confirm the end date shown to the customer falls on a billing boundary.
- [ ] Try to provision a pilot with no term, and confirm the server refuses it.

## Notes

- Flip `billing_terms` on for the pilot workspaces after deploy.
- Statement export still shows one row per grant bucket, with a follow-up PR planned.
```

### Tone

Plain words, direct voice, present tense. Start sentences with the fact. Name breaking changes, migrations, feature flags, and dependency bumps openly, since those are what reviewers most need to catch.

## Step 5: Present draft ⛔ BLOCKING

Load `craft:unslop` and run the draft through it at **flat** register.

Print the title and body in chat as one fenced block, then stop and wait for approval. Re-print the full draft after any edit the user asks for.

## Step 6: Post

```bash
git push -u origin HEAD
gh pr create --title "<title>" --body-file <path> --base <base>   # new
gh pr edit <n> --title "<title>" --body-file <path>               # update
```

- Write the body file into the scratchpad directory.
- Ask first when the working tree has uncommitted changes.
- Report the PR URL.

## Pre-Delivery Checklist

- [ ] Title is `type(scope): summary`, imperative, lowercase, near 50 characters
- [ ] Title type matches the point of the change
- [ ] Opening paragraph makes sense to someone who has not read the diff
- [ ] Context gives the bug or the need behind the change, with related issues and tickets as their own bullets
- [ ] How to Test walks the app only, with no test commands or automated checks
- [ ] No em dashes or en dashes anywhere, and no generated-by or co-authored-by footer
- [ ] Every bullet in every section is a single sentence on a single unbroken line
- [ ] Changes has five bullets or fewer, each one short sentence in product language, with no file, symbol, or component names and no reasoning unless it is needed
- [ ] Incidental work (side bug fixes, tidy-ups, bumps) sits under **Minor fixes**, not among the main bullets
- [ ] Notes carries anything the reviewer must do or watch that the diff does not show
- [ ] Every statement traces to a real hunk in the diff
- [ ] Breaking changes, migrations, and flags are stated
- [ ] Body reads in one pass, with no placeholder text left
- [ ] User approved the draft before the PR was created or updated
- [ ] An existing PR was updated in place rather than duplicated
