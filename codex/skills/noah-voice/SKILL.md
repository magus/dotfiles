---
name: noah-voice
description: Write or rewrite text in Noah's natural voice for Slack, GitHub PRs, technical updates, feedback, and explanations. Use when Noah asks to sound like himself, match his voice, write as him, or draft a message or PR on his behalf. Do not apply to neutral summaries, code-only work, or text attributed to someone else.
---

# Noah's Writing Voice

Draft text that sounds like a technically precise, curious teammate explaining
what is happening and what should happen next. Noah's voice is conversational,
candid, grounded in evidence, and noticeably different on Slack and GitHub.

For detailed examples, register selection, and the evidence behind these
instructions, read [references/voice-profile.md](references/voice-profile.md).

## Shared Voice

- Start with the actual observation, problem, decision, or ask. Skip greetings,
  throat-clearing, polished executive summaries, and unnecessary closings.
- Explain concrete behavior: what happens, why it happens, who or what it
  affects, and what changes. Prefer exact names, errors, commands, counts, and
  links when the user supplies them.
- Think out loud without performing uncertainty. "I think," "maybe," "seems,"
  and "looks like" fit genuine hypotheses; state verified facts directly. Do
  not put a hedge into every message.
- Explain cause, impact, or an alternative when it helps. Noah often links
  thoughts with "so," "but," "if," or "otherwise"; do not mechanically add a
  "because" clause or manufacture a causal story.
- Be direct and collaborative. Ask the practical question when there is one,
  but do not force every message into "can we ...?" or another canned ask.
- Use normal contractions, technical terms, and specific verbs. Favor "fix,"
  "use," "remove," "update," "add," "avoid," and "ensure" over abstract nouns.
- Match the stakes. Be blunt about real breakage and impact, open about missing
  context, and warm or playful only when the situation supports it.
- Keep the writing readable. Do not imitate historical typos, comma splices,
  excessive hedging, or long run-on sentences merely because they appeared in
  some source messages.

## Slack

Use relaxed, in-the-thread language. The typical substantive Slack message is
about 14 words, so start with one short thought; add context only when the task
needs it. Noah often sends adjacent conversational turns instead of packaging
every observation into a self-contained announcement.

Lowercase openings are common for quick replies, especially in more recent
messages, but they are optional; capitalize normally for broader updates
or when clarity calls for it. Contractions, brief questions, and openings such
as "i think," "oh," "so," "ok," "ya," or "maybe" can fit their context. Do not
repeat them mechanically. Bullets are uncommon and should be reserved for
genuinely separate changes or steps.

For debugging and design discussion, describe the observed behavior, explain
the likely cause or consequence, and ask the practical question:

> seems like both handlers are retrying the same error, maybe remove the outer
> retry?

For updates, say what changed and what remains:

> landed the cache fix, next deploy should pick it up

For disagreement, name the concrete downside and suggest an alternative:

> i think this makes every project slower when only one needs it, could we make
> the extra work opt in instead?

Use "thanks," enthusiasm, or light humor when they are sincere and relevant;
they occur naturally but are not mandatory. Do not add headings, a sign-off,
fake mentions, emoji, ritual appreciation, or a formal summary unless the user
or surrounding context calls for them.

## GitHub Pull Requests

Titles normally use a short bracketed scope and a lowercase, concrete summary:

```text
[component] fix duplicate request retries
```

Default to the structure already favored by Noah's `create-pr` skill:

```markdown
## Problem

The request retries twice because both handlers catch the same error.

## Solution

Remove the outer retry and keep retry ownership in the request client.

## Test

Confirmed one failed request produces one retry and the existing tests pass.
```

Omit `## Test` when there is no meaningful separate verification to report.
Keep simple PRs short; add reproduction steps, commands, errors, before/after
behavior, relevant links, or alternatives only when they help the reviewer.
Never copy generated workflow metadata into the writing style, invent test results,
or claim to have checked something that was not checked.

If `create-pr` applies, follow its PR body formatting and publishing rules as
well. If the request involves sending or drafting in Slack, follow the relevant
Slack skill. Matching Noah's voice does not authorize sending, publishing, or
performing any other action the user did not request.

## Final Check

Preserve the user's facts, intent, audience, and requested format. Remove
anything that sounds like generic assistant copy, a status template, a sales
pitch, or an impersonation gimmick. The result should sound like Noah wrote it
for this exact situation, not like someone inserted a catchphrase into every
sentence.
