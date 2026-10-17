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

Sections in this order: description, Problems, Related Ticket, Changes, How to Test, Notes. Problems, Related Ticket, and Notes are left out unless their rule below says to include them.

### Description (no heading)

One line, starting with "This PR" and an action verb: `This PR adds a login form.` Name the point of the change, not the supporting work. No second sentence.

### `## Problems`

Leave this section out by default. Include it only when the user gives the problems, or when the PR replaces existing behaviour and the description alone does not say what was wrong with it. Then write two or three bullets, one short sentence each, one per problem. Do not restate the description.

### `## Related Ticket`

Only when the branch name, commits, or user's message name a ticket or issue. Linear ticket as `[ID](link)`, GitHub issue as `#id`. Omit the section when there are none.

```markdown
- Closes [BIL-119](https://linear.app/team/issue/BIL-119)
- Closes #482
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

A short checkbox list of the general cases a reviewer tries in the running app, one short sentence each. Name the case and what should happen, not every click on the way there. Give a route only when the reviewer cannot find the screen without it. Cover only the manual path through the app: never list test commands or automated checks. When the change has no manual surface, say which part of the app to exercise to see it, or state that there is no manual surface.

### `## Notes`

Only for steps someone must run before or after merge: a migration, a script, a flag flip, a config or env change. One bullet per step. Leave the section out when there are none. Known gaps, planned follow-ups, and parts worth a closer look do not go here.

### Punctuation

No em dashes or en dashes anywhere in the title or body. Use a comma, a colon, parentheses, or a second sentence instead. Hyphens in compound words are fine.

End the body at the last section. Never append a generated-by, co-authored-by, or tool-attribution footer.

### Line breaks

Write each paragraph and each bullet as one unbroken line, however long it runs. GitHub wraps the body to the reader's window, so hard-wrapped source lines come out ragged there. Break a line only between blocks.

### Full example

```markdown
This PR simplifies the billing statement and adds fixed-term plans.

## Related Ticket

- Closes [BIL-119](https://linear.app/acme/issue/BIL-119)
- Closes #482

## Changes

**Billing statement**

- One statement line per video release.
- Usage percentage matches the threshold emails.

**Plan terms**

- Plans can be sold with a fixed term in months.
- Pilot access is a plan tier, not a build flag.

**Minor fixes**

- Invoice date no longer shifts a day west of UTC.
- Unused pilot card is removed.

## How to Test

- [ ] Release three videos in one charge. The statement shows three lines.
- [ ] The usage percentage matches the last threshold email.
- [ ] A 12 month plan ends on a billing boundary.
- [ ] A pilot with no term is refused.

## Notes

- Flip `billing_terms` on for the pilot workspaces after deploy.
```

### Tone

Plain words, direct voice, present tense. Start sentences with the fact. One idea per sentence: when a sentence runs on, split it or drop the tail that explains how or why. Write less than feels complete; the reviewer has the diff for the rest. Name breaking changes, migrations, feature flags, and dependency bumps openly, since those are what reviewers most need to catch.

## Step 5: Present draft ⛔ BLOCKING

Load `craft:unslop` and run the draft through it at **flat** register.

Print the title and body in chat as one fenced block, then stop and wait for approval. Re-print the full draft after any edit the user asks for.

## Step 6: Post

```bash
git push -u origin HEAD
gh pr create --title "<title>" --body-file <path> --base <base> --assignee @me   # new
gh pr edit <n> --title "<title>" --body-file <path>               # update
```

- Open a ready PR, not a draft, assigned to the user.
- Write the body file into the scratchpad directory.
- Ask first when the working tree has uncommitted changes.
- Report the PR URL.

## Pre-Delivery Checklist

- [ ] Title is `type(scope): summary`, imperative, lowercase, near 50 characters
- [ ] Title type matches the point of the change
- [ ] Description is one line starting with "This PR" and an action verb
- [ ] Problems is left out unless the user gave the problems or the reason for replacing existing behaviour is not obvious
- [ ] Related Ticket links Linear tickets as `[ID](link)` and issues as `#id`, or is omitted when there are none
- [ ] How to Test lists general cases in the app, one short sentence each, with no click-by-click steps, test commands, or automated checks
- [ ] No em dashes or en dashes anywhere, and no generated-by or co-authored-by footer
- [ ] Every bullet in every section is a single sentence on a single unbroken line
- [ ] Changes has five bullets or fewer, each one short sentence in product language, with no file, symbol, or component names and no reasoning unless it is needed
- [ ] Incidental work (side bug fixes, tidy-ups, bumps) sits under **Minor fixes**, not among the main bullets
- [ ] Notes holds only steps to run before or after merge, or is left out
- [ ] Every statement traces to a real hunk in the diff
- [ ] Breaking changes, migrations, and flags are stated
- [ ] Body reads in one pass, with no placeholder text left
- [ ] User approved the draft before the PR was created or updated
- [ ] An existing PR was updated in place rather than duplicated
