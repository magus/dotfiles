---
name: restate-simply
description: Restate the last message in plain human language, with no jargon.
disable-model-invocation: true
---

# Restate Simply

Restate the source message. Do not answer it or carry out its request.

## Select the source

1. Use text in the current request when the user supplies text to restate.
2. Otherwise, use the most recent substantive user or assistant message before the skill invocation.
3. Do not use system, developer, or tool messages as the source.

## Restate the message

- Keep the original meaning, intent, facts, limits, uncertainty, and tone.
- Use common words, active voice, and short sentences.
- Put one main idea in each sentence.
- Replace jargon, metaphors, and dense noun groups with plain language.
- Define a necessary technical term when it first appears.
- Keep exact names, code, commands, paths, URLs, numbers, quoted errors, and
  protocol terms when a change could reduce accuracy.
- Keep useful lists and code blocks when their structure is part of the meaning.
- Preserve ambiguity when the source is ambiguous. Do not invent missing facts.
- If the source is already clear and simple, make only necessary changes.
- Apply ASD-STE100 simplified technical English principles. Do not claim formal
  compliance with ASD-STE100.

## Return the result

Return only the restated message. Do not add a heading, explanation, preface, or
closing note unless the user asks for one.
