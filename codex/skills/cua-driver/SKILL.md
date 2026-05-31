---
name: cua-driver
description: Use when Codex needs to control local desktop apps through the installed Cua Driver MCP, inspect app/window accessibility state, launch apps, click/type/press keys, record trajectories, or debug CUA driver behavior. Prefer this for explicit CUA desktop automation requests, especially when Noah mentions cua-driver, CUA MCP, app control, Accessibility, Screen Recording, or background window interaction.
---

# Cua Driver

Use the installed Cua Driver MCP for local desktop automation. The configured MCP server is:

```toml
[mcp_servers.cua-driver]
command = "/Users/noah/.local/bin/cua-driver"
args = ["mcp"]
```

The binary is symlinked to:

```text
/Applications/CuaDriver.app/Contents/MacOS/cua-driver
```

## Core Workflow

Prefer MCP tools over shelling out to the CLI:

1. `launch_app` with `bundle_id` when starting an app.
2. `list_windows` only if `launch_app` did not return a usable window.
3. `get_window_state(pid, window_id)` before every element-indexed action.
4. Act with `click`, `type_text`, `press_key`, `hotkey`, `scroll`, `drag`, or `set_value`.
5. Call `get_window_state` again to verify the result.

Prefer `element_index` from `get_window_state` over pixel coordinates. Element-indexed actions use Accessibility, usually work on backgrounded or hidden windows, and avoid stealing focus. Use pixels only for canvas/video/WebGL/custom drawn surfaces that are not represented in AX.

## Sandbox Rule

GUI app launch checks can fail inside Codex's filesystem/process sandbox even when the app is healthy. In this environment, sandboxed CLI launches have produced false errors such as:

```text
Calculator.app could not be launched because it is corrupt
No installed macOS app found for bundle_id 'com.apple.calculator'
```

Treat those as sandbox artifacts unless reproduced outside the sandbox.

When using the CLI for GUI app launch or launch diagnostics, run it escalated:

```sh
/Users/noah/.local/bin/cua-driver call launch_app '{"bundle_id":"com.apple.calculator"}'
```

Use this escalation justification:

```text
Allow running cua-driver's GUI app launch path outside the sandbox to distinguish a sandbox artifact from a real LaunchServices/CUA issue.
```

For routine automation inside Codex, prefer the MCP `launch_app` tool instead of the CLI.

## Useful CLI Reference

Use the CLI for discovery, debugging, and schemas:

```sh
cua-driver list-tools
cua-driver describe launch_app
cua-driver describe get_window_state
cua-driver describe click
cua-driver describe type_text
cua-driver call get_config '{}'
```

`cua-driver status --json` may report that the daemon is not running even when MCP tools work through the session. Prefer MCP behavior as the operational check.

## Permissions

Cua Driver needs macOS Accessibility and Screen Recording grants under the `com.trycua.driver` identity.

Read-only check:

```sh
cua-driver permissions status --json
```

Grant or verify permissions through LaunchServices:

```sh
cua-driver permissions grant
```

Do not toggle permission checkboxes through System Settings unless Noah explicitly authorizes it. Reading the System Settings AX tree is okay; clicking in privacy/security panes is risky because it can change persistent permissions.

## Low-Risk Smoke Test

Use Calculator when available:

1. `launch_app({ "bundle_id": "com.apple.calculator" })`
2. Pick the visible `Calculator` window from the returned windows.
3. `get_window_state` and identify buttons by label.
4. Click a harmless sequence, such as `All Clear`, `1`, `Add`, `2`, `Equals`.
5. Verify the display text is `3`.

If Calculator is already open, `launch_app` should return its current pid/window. If CLI launch fails only without escalation, do not call the app corrupt.

For text input testing, use a disposable browser new-tab omnibox or an explicitly approved scratch document. Clear the field afterward with `set_value` where possible.

## Safety Notes

- Never interact with password managers, secrets folders, auth prompts, payment flows, or system privacy/security toggles unless Noah explicitly asks.
- After any action, verify with a fresh `get_window_state`; element indices are snapshot-scoped and can change.
- Prefer `hotkey`/`press_key` over synthesized typing for special keys.
- Use `start_recording` only when a trajectory artifact is useful; video recording can capture sensitive screen contents.
