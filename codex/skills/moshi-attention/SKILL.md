---
name: moshi-attention
description: Send Noah an attention-getting Moshi iOS push from Codex through the local moshi-hook daemon. Use when Codex needs Noah's attention for task completion, acknowledgement, clarification, approval, a blocking question, or any other user-visible interruption where an inbox-only Moshi event is not enough.
---

# Moshi Attention

Use this skill to get Noah's attention through Moshi on iPhone.

The tested reliable visible push path is a synthetic Moshi `approval.request` event. Normal `task_complete` events can appear only in the Moshi inbox without a banner or sound; `approval_required` events produce the audible/visible push and can return Noah's approve/deny response.

## Use Cases

- At the end of a task when Noah asked to be notified.
- When blocked on a clarification or decision.
- Before taking an action that needs explicit approval.
- When a long-running command finishes and Noah should be interrupted.

Do not use this for routine status chatter. Still send the normal final answer or user-facing update after using the push.

## Safety Rules

- Do not include secrets, tokens, transcript paths, transcript contents, command output dumps, or sensitive data in the push message.
- Keep the push message short and human-readable.
- Use the push only after the task is actually complete, or when the next step truly needs Noah.
- If connecting to the Moshi socket requires sandbox escalation, request it with this justification:

```text
Allow connecting to Moshi's local Unix socket to send an attention/approval push notification.
```

## Quick Check

Before relying on this, confirm Moshi is paired:

```sh
moshi-hook status
```

Expected:

```text
status: paired
socket: /Users/noah/Library/Application Support/Moshi/moshi-hook.sock
```

## Send A Push

Prefer the bundled script:

```sh
node /Users/noah/.codex/skills/moshi-attention/scripts/moshi-attention.js \
  --title "Codex needs approval" \
  --subtitle "Tap to respond" \
  --message "Codex finished and needs your acknowledgement."
```

For task completion:

```sh
node /Users/noah/.codex/skills/moshi-attention/scripts/moshi-attention.js \
  --title "Codex task done" \
  --subtitle "Tap to acknowledge" \
  --message "Codex finished the requested task."
```

For clarification:

```sh
node /Users/noah/.codex/skills/moshi-attention/scripts/moshi-attention.js \
  --title "Codex question" \
  --subtitle "Reply in the Codex session" \
  --message "Codex needs a decision before continuing."
```

The script sends the push first, then waits for Noah to approve/deny from Moshi. It waits up to 30 seconds by default; adjust this with `--timeout <seconds>` when a longer or shorter response window is useful.

```sh
node /Users/noah/.codex/skills/moshi-attention/scripts/moshi-attention.js \
  --title "Codex question" \
  --subtitle "Reply in the Codex session" \
  --message "Codex needs a decision before continuing." \
  --timeout 120
```

If the command is interrupted during the wait, the push may already have been delivered successfully.

## Interpret Output

If Noah taps approve:

```json
{"type":"approval.response","accepted":true,"decision":"approve","reason":"remote"}
```

If Noah taps deny:

```json
{"type":"approval.response","accepted":false,"decision":"deny","reason":"remote"}
```

If there is no response before timeout:

```text
sent Moshi attention push; no response before timeout
```

Timeout does not necessarily mean the push failed. It means Codex did not receive an approval response within the wait window.

## Troubleshooting

In Codex workspace sandboxing, connecting to Moshi's local Unix socket can fail with:

```text
connect EPERM /Users/noah/Library/Application Support/Moshi/moshi-hook.sock
```

Treat this as a sandbox permission issue, not a Moshi delivery failure. Rerun the send command with `sandbox_permissions: "require_escalated"` and the socket-access justification from Safety Rules.

If the script cannot connect:

```sh
moshi-hook status
moshi-hook logs -n 30
launchctl print gui/$(id -u)/homebrew.mxcl.moshi-hook
```

If a completion event appears in the Moshi inbox but does not make sound or show a banner, use this skill's approval-style push instead of a plain `task_complete` event.
