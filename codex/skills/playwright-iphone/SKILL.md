---
name: playwright-iphone
description: Use when Codex needs to open, inspect, screenshot, or debug a website in a Playwright-launched iPhone viewport, especially the standard iPhone 17 target. This is a nested workflow skill built on the official OpenAI `playwright` skill and should trigger for requests mentioning iPhone 17, iPhone viewport checks, mobile responsive checks with Playwright, or reproducing what Noah previously did for `dcss.vercel.app`.
---

# Playwright iPhone

## Overview

Use this skill as a thin, user-authored workflow layered on top of the official OpenAI `playwright` skill. Prefer the lockfile-managed install at `~/.agents/skills/playwright`; fall back to `~/.codex/skills/playwright` if that path exists. It records the working iPhone 17 viewport process used for `https://dcss.vercel.app/`.

This is an iPhone 17 viewport check in a Playwright-launched browser. It does not control Noah's existing personal Chrome profile, and the CLI resize workflow is not full iOS Safari emulation of user agent, touch, DPR, browser chrome, or WebKit behavior.

For UI testing and inspection, drive the headed browser like a human in a tight loop: inspect with `snapshot` and `screenshot`, take one visible action with `click`, `fill`, `type`, `press`, resize, or navigation commands, then inspect again. Do not write Playwright scripts or test files for exploratory UI testing unless Noah explicitly asks for scripted regression coverage.

When the browser reaches a state Noah needs for follow-up testing, leave that headed session open and report the current URL/state. Close the session only when Noah asks or when cleanup is clearly part of the task.

## Prerequisites

First follow the official `playwright` skill's prerequisite check:

```bash
command -v npx >/dev/null 2>&1
```

If `npx` is missing, stop and ask the user to install Node.js/npm before continuing.

Set a wrapper path that works for either the `npx skills` managed install or the older direct Codex install:

```bash
if [ -f "$HOME/.agents/skills/playwright/scripts/playwright_cli.sh" ]; then
  PWCLI="$HOME/.agents/skills/playwright/scripts/playwright_cli.sh"
else
  PWCLI="${CODEX_HOME:-$HOME/.codex}/skills/playwright/scripts/playwright_cli.sh"
fi
```

The official Playwright wrapper may not be executable after installation. Prefer invoking it through `bash`:

```bash
bash "$PWCLI" --help
```

## iPhone 17 Target

Use these CSS viewport dimensions for the standard iPhone 17 portrait target:

- Width: `402`
- Height: `874`

This matches the responsive layout check that worked for `dcss.vercel.app`. If the user asks for a different iPhone model, look up or infer that model's CSS viewport and state the dimensions used.

## Workflow

Open the site in a headed Playwright browser:

```bash
bash "$PWCLI" open https://dcss.vercel.app --headed
```

Resize to the iPhone 17 CSS viewport:

```bash
bash "$PWCLI" resize 402 874
```

Reload the page after resizing:

```bash
bash "$PWCLI" reload
```

If the app navigates away during probing, navigate back explicitly:

```bash
bash "$PWCLI" goto https://dcss.vercel.app
```

For other URLs, replace `https://dcss.vercel.app` with the requested site.

## Human-Driven UI Loop

Use this loop for app/UI testing:

```bash
bash "$PWCLI" snapshot
bash "$PWCLI" screenshot
bash "$PWCLI" click e12
bash "$PWCLI" snapshot
```

Use fresh snapshot refs before each action. If a ref goes stale, take a new snapshot and continue from the visible state instead of switching to a script. Use `eval` only for compact inspection such as viewport, URL, title, or device metrics.

## Verification

Verify the active viewport and page details:

```bash
bash "$PWCLI" eval '() => ({ innerWidth: window.innerWidth, innerHeight: window.innerHeight, dpr: window.devicePixelRatio, ua: navigator.userAgent, touch: navigator.maxTouchPoints, title: document.title, url: location.href })'
```

Expected viewport result for the standard iPhone 17 workflow:

- `innerWidth`: `402`
- `innerHeight`: `874`

For the original `dcss.vercel.app` check, the page reported:

- Page URL: `https://dcss.vercel.app/`
- Page title: `DCSS Search`

Use the official `playwright` skill's snapshot and screenshot commands when the user needs element inspection or visual artifacts.
