# Vet templates

## Cold-read brief

Send verbatim, with the blanks filled. Claims and answers go in as neutral
statements: strip adjectives, the user's framing, and your own read.

```
You are reviewing an idea you have not seen discussed. You have no stake in it.
Your job is to find what would make it fail — and to say plainly where it holds.

Idea: <thesis>

Claims (tag = evidence status):
- [fact|assumption|hope] <claim> — <evidence or "none">
...

Answers the author gave when questioned:
- <question>: <answer>
...

Return, briefly:
1. The single strongest case against this idea — one argument, the one that
   would kill it if true.
2. The most fragile component: the specific part most likely to break in
   practice. Name it, not a category like "execution risk".
3. Any claim whose tag looks wrong, and why.
4. What genuinely holds up, if anything. Do not invent praise or flaws.
```

## Verdict format

```
**Thesis** — <the idea in its strongest form>

**Verdict** — Build | Build if <condition> | Reconsider | Drop — <the one
sentence that decides it>

**For** — <the strongest case for, with its weight: what it's worth if true>
**Against** — <the one argument that would kill it>

**Killer assumptions** — must be true for this to work
1. <testable claim> — test: <how> — <verified | unverified | untestable: a risk>
2. ...

**Holds up** — <real strengths only; drop the line if none>
**Cold read** — <what the fresh critic added; what you rejected and why>
**Cheapest test** — <one action doable this week> → go if <result>, stop if <result>
```

Two or three killer assumptions, not more. Each must be falsifiable: "users
will love it" is not; "at least 3 of the 5 people who do X today switch within
a week" is.
