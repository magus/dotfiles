---
name: moshi-attention
description: Send Noah an attention-getting Moshi iOS push from Codex through the Moshi HTTPS webhook. Use when Codex needs Noah's attention for task completion, acknowledgement, clarification, approval, a blocking question, or any other user-visible interruption where an inbox-only Moshi event is not enough.
---

# Moshi Attention

Use this skill to get Noah's attention through Moshi on iPhone.

The preferred visible push path is the Moshi HTTPS webhook. It does not require
the local `moshi-hook` socket.

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
- The webhook token is a secret. Do not commit it, paste it into command
  examples, print it in final responses, include it in logs, or put it in
  screenshots. Configure it as `MOSHI_WEBHOOK_TOKEN` in `~/.private`, which is
  sourced by `zsh/zshrc.symlink`.
- In Codex workspace sandboxing, outbound HTTPS may require sandbox escalation.
  If a webhook send is blocked by network permissions, rerun it with this
  justification:

```text
Allow sending an HTTPS request to Moshi's webhook to deliver an attention push notification.
```

## Send A Push

Prefer the bundled webhook helper:

```sh
node /Users/noah/.dotfiles/codex/skills/moshi-attention/scripts/moshi-webhook.js \
  --title "Codex task done" \
  --message "The requested work is ready to review."
```

The helper accepts `--title`, `--message`, and `--no-unified`. It prints
`Moshi webhook delivered` on success. It first reads the token from the
`MOSHI_WEBHOOK_TOKEN` environment variable, then falls back to sourcing
`~/.private` for noninteractive Codex shells that do not load `.zshrc`.

Do not use inline curl examples with the token in the command. If curl is
needed for debugging, load the token from a local secret source and keep the
command out of shell history.

The webhook returns immediately. Treat it as notification delivery only; Noah's
reply still comes through the Codex session.

If debugging requires curl, add `-sS --fail-with-body` so curl stays quiet on
success, prints useful errors, and exits nonzero on HTTP failures.

## Interpret Output

Observed success response shape:

```json
{"success":true,"pushSent":1,"result":{"data":{"status":"ok","id":"..."}}}
```

Treat the push as delivered when `curl` exits with status 0 and the JSON body
has `success: true`, `pushSent` greater than 0, and `result.data.status: "ok"`.
The `id` is useful for rough correlation only; do not rely on its format.

With `-D -`, the server also returned `HTTP/2 200` and
`content-type: application/json`.

If outbound HTTPS is blocked by the sandbox, `curl` may fail with a network,
DNS, or connection error. Rerun with `sandbox_permissions: "require_escalated"`
and the webhook justification from Safety Rules.

## Local Hook Fallback

Use this only if the HTTPS webhook is unavailable or Noah explicitly asks for
the local hook path.

Before relying on the local hook, confirm Moshi is paired:

```sh
moshi-hook status
```

Expected:

```text
status: paired
socket: /Users/noah/Library/Application Support/Moshi/moshi-hook.sock
```

Then use the bundled script:

```sh
node /Users/noah/.codex/skills/moshi-attention/scripts/moshi-attention.js \
  --title "Codex task done" \
  --subtitle "Tap to acknowledge" \
  --message "Codex finished the requested task." \
  --timeout 2
```

## Troubleshooting

If the webhook fails, check whether the environment has outbound network
access, then retry with sandbox escalation if needed.

If the local hook fallback was accidentally run without escalation, connecting
to Moshi's local Unix socket can fail with:

```text
connect EPERM /Users/noah/Library/Application Support/Moshi/moshi-hook.sock
```

Treat this as a sandbox permission issue, not a Moshi delivery failure. Rerun
the local hook command with `sandbox_permissions: "require_escalated"` and this
justification:

```text
Allow connecting to Moshi's local Unix socket to send an attention/approval push notification.
```

If the script cannot connect:

```sh
moshi-hook status
moshi-hook logs -n 30
launchctl print gui/$(id -u)/homebrew.mxcl.moshi-hook
```

If a completion event appears in the Moshi inbox but does not make sound or show
a banner, use the HTTPS webhook path instead of a plain `task_complete` event.
