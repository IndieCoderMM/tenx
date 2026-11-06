---
name: proto
description: Work session — build a throwaway prototype that answers one question - a standalone HTML design file, or a local-only dev route inside the real project - then record the verdict.
disable-model-invocation: true
---

# Proto

A prototype is throwaway work that answers **one question**. Spawned by HQ
(`/flow:spawn proto`); the user then attaches and iterates here directly.

Load the `flow` skill first.

Arguments: `<slug> route|file`. The question is in `DIR/proto/question.md`.

## Steps

1. **Pick the shape** from the question:
   - "What should this look like?" → **variants**: 3 variants by default (max 5),
     structurally different — layout, hierarchy, main action — not colour swaps.
   - "Does this logic / state flow hold up?" → **walkthrough**: a pure reducer or
     state machine in one script block, a live state panel, a button per action,
     and one tab per scenario (happy path, awkward edge, something that should be
     refused). Labels in product language, not code.
2. **Build** in the mode HQ chose (below). Write the question at the top of the page.
3. **Screenshot** each variant or scenario with agent-browser into `DIR/proto/`
   (load the `agent-browser` skill; run `agent-browser skills get core` first).
   Look at every shot yourself before handing over — fix anything broken.
4. **Hand over.** Colour red, then report: the URL or file path, the variant keys,
   one line per variant on how it differs. The user flips through and replies,
   often "header from B, list from C". Iterate until they pick.
5. **Verdict.** Write `DIR/proto/verdict.md`, then colour green:

   ```markdown
   question: <the question>
   answer: <winning variant or rule, one or two lines>
   learned: <what surprised us, or —>
   where: <branch `<slug>-proto` + route, or file path>
   ```

## Mode: file

One self-contained HTML file at `DIR/proto/<slug>.html`: inline CSS and JS, no
build, opens by double-click. Copy the project's theme tokens (colours, radius,
font, spacing) from its global CSS so it looks like the product. Variants switch
with `?v=A|B|C`, a floating bottom bar with ←/→ arrows, and the arrow keys. Open
it with `xdg-open`. Publish it as a private Artifact only if the user asks to share.

## Mode: route

You are in worktree `proto-<slug>` on branch `<slug>-proto`.

- **Host:** mount the variants inside the existing page they would live in,
  switched by `?variant=`, when such a page exists — an empty page hides design
  problems. Otherwise add a route under the project's existing dev routes
  (e.g. `routes/dev/<slug>.tsx`), never a new top-level structure.
- **Local only:** the route, the switcher, and any variant mount render only in
  development — guard with the bundler's dev flag (TanStack/Vite:
  `beforeLoad: () => { if (!import.meta.env.DEV) throw notFound() }`; inside a
  page: `import.meta.env.DEV &&`).
- **Data:** in-memory fixtures shaped like the real types. No database writes, no
  migrations, no network calls to paid services.
- **Reuse** the project's real components and styling; do not restyle them.
- **Run:** start the dev server once (in the background) and give the user the URL.
- Commit on the proto branch with `dispatch:commit`. Never push, never merge it.

## Rules

- Skip polish: no tests, no error handling beyond what keeps it running.
- One question. A second question is a second prototype — tell HQ.
- Never touch `plan.md`; HQ reads the verdict.
