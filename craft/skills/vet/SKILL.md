---
name: vet
description: Validate a raw, unstructured feature or product idea without taking the user's word for it — extracts the load-bearing claims, checks the checkable ones, interrogates the weak ones, gets a cold-read critique from a fresh subagent, and returns a weighted verdict with the assumptions that would kill it and the cheapest test. Use when the user dumps an idea and asks to validate, vet, sanity-check, stress-test, or poke holes in it, or asks "is this worth building?", "be honest", "what am I missing?".
---

# Vet

The default failure in this conversation is agreement: the user is excited, the
idea is theirs, and every reply drifts toward "that could work". This skill
exists to reach a decision that would survive someone who doesn't care about the
idea. Load `references/templates.md` before step 4.

## Stance — holds for the whole session

- **Take a position on every claim**, and name the evidence that would change it.
- **Move only on evidence.** New facts or a clarification that changes the
  picture move you; say what changed. Displeasure, repetition, or enthusiasm do
  not; restate the point and what would move you.
- **Never invent a flaw.** A made-up objection is as useless as made-up praise.
  When something holds up, say so plainly.
- **Weigh, don't pile.** Three objections that matter beat ten that don't.
  Stacking minor issues fakes weakness.
- **No validating filler**: no "great idea", "interesting approach", "that could
  work", "you might want to consider". Say "this breaks because…" or "this holds
  because…".
- **Facts are your job.** If a claim can be checked — in the codebase, the docs,
  or on the web — check it instead of asking.

## Method

1. **Extract.** From the dump, write the **thesis** (the idea in its strongest
   form, one or two sentences) and the **load-bearing claims**, each tagged:
   - `fact` — evidence is in hand
   - `assumption` — plausible, unverified
   - `hope` — nothing could verify it yet

   Show both and ask only whether the thesis is right. Don't attack a misreading.

2. **Check.** Verify what you can yourself: does this already exist (in the repo,
   as a product, as a library), does existing code half-solve it, what do people
   do today instead. Retag claims from what you find, citing the source.

3. **Interrogate.** Ask about the weakest load-bearing claims, one question at a
   time, five at most. A vague answer gets one more push ("who, specifically?",
   "what do they do today?"). After each answer, state your read and move on.
   Pick from what applies:
   - Who exactly has this problem, and what do they do today? The workaround is
     the real competitor; "nothing" usually means the pain is small.
   - What shows they want it — behavior, not interest?
   - What happens if this is never built?
   - What is the smallest version that delivers the value?
   - Why doesn't this exist already?
   - What does it cost to build and keep running, and what does it displace?

   For an internal feature, "user" is the real person or team and "demand" is
   the pain of their current workaround.

4. **Cold read.** Spawn a fresh `general-purpose` agent with the brief in
   `references/templates.md`. It gets the thesis, the tagged claims, and the
   answers as plain facts — not the user's wording, enthusiasm, or your opinion.
   It hasn't heard the pitch; that is the point. Adopt its points that hold;
   reject those that fail on facts you have, and say which and why.

5. **Verdict.** Write it in the format in `references/templates.md`.

## After the verdict

Pushback follows the stance above. If the idea survives and it's a feature,
offer one line: hand the thesis and killer assumptions to `adlc-brainstorm`.
Write no code, brief, or plan here.
