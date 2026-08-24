---
name: create-pr
description: Must use when working with a GitHub pull request, including creating or updating it, pushing related changes, or writing its title, summary, etc.
---

# Create PR

Use this skill when Noah asks to create a GitHub pull request from local or
already-pushed changes, or asks for PR-facing text such as a title, summary,
body, description, or reviewer note for those changes.

When drafting PR titles, descriptions, reviewer notes, or other text for Noah,
also use `$noah-voice`. Read [its instructions](../noah-voice/SKILL.md) and
apply its GitHub pull request guidance. Preserve the existing PR structure,
verification requirements, formatting, and publishing rules; `$noah-voice`
controls tone and wording.

Prefer `gh` for GitHub operations. Use the GitHub app or web only when `gh` is unavailable, unauthenticated, or missing a capability needed for the task.

## Preflight

Gather the minimum facts before changing anything:

```sh
git status --short
git branch --show-current
git remote -v
git log --oneline --decorate -5
gh auth status
gh repo view --json nameWithOwner,url,defaultBranchRef
```

Inspect the diff and commit history against the likely base branch:

```sh
git diff
git diff --staged
git merge-base HEAD origin/master
git log --oneline --decorate origin/master..HEAD
```

Replace `origin/master` with the repo's default branch from `gh repo view` when different.

Do not include unrelated work. If the worktree mixes unrelated changes and the PR cannot be scoped cleanly, ask Noah how to split it. Never revert user changes to make the PR easier.

## Implementation Context

Before committing or opening the PR, look for non-obvious implementation choices, invariants, tradeoffs, migrations, compatibility behavior, or external constraints that would otherwise need explanation in the PR body.

When that context matters for future maintenance, add a concise code comment at the relevant code site. Prefer comments that explain "why this is shaped this way" over comments that restate the code. If a detail feels important enough to mention in the PR summary, first consider whether it belongs as a persistent code comment too.

Do not turn logs, screenshots, issue context, or test output into code comments unless they explain a lasting invariant in the code.

## Verification

Run focused tests or checks that match the changed surface area. Capture exact commands and important output. For failures, include the failing command, the relevant excerpt, and whether the failure is pre-existing, environmental, or caused by the branch.

Include a `## Test` section only for meaningful validation performed separately from automated CI. Explain the one-off commands, manual workflow, created resource, deployment, or direct interaction that verified the change, along with the relevant result or artifact. Do not list unit tests, routine checks, Buildkite runs, or other checks already shown on the PR.

Use fenced code blocks for logs in the PR body:

````markdown
```text
<exact log excerpt>
```
````

## Commit And Push

If changes are uncommitted and the user asked Codex to create the PR end to end, create intentional commits. Keep the commit scope narrow and avoid staging unrelated files.

```sh
git status --short
git add <paths>
git commit -m "<concise imperative summary>"
git push -u origin "$(git branch --show-current)"
```

If the branch already has suitable commits, do not rewrite them just to make the PR prettier unless Noah asks.

## PR Body

When Noah asks for a PR summary, body, description, or other PR-facing copy to
paste into GitHub, always return the complete PR body inside a fenced `markdown`
code block. Do not render the PR body directly as normal chat Markdown. If the
body contains its own code fences, use an outer fence longer than every inner
fence. Put an optional PR title outside the fenced body.

Use `## Problem` and `## Solution` as the default top-level sections. Add `## Test` only when meaningful validation beyond automated CI needs its own section.

Write for skim-read reviewers.

- Avoid long paragraphs.
- Prefer clear, direct sentences.
- Keep each paragraph to one idea.
- Use bullets when presenting multiple facts, changes, constraints, links, screenshots, logs, or follow-up notes.
- Put dense command output or logs in fenced code blocks instead of prose.
- Use links to ground factual claims when practical.
- Write links as descriptive Markdown links, such as `[Fixes dropped webhook retries](https://github.com/org/repo/issues/123)`.
- Avoid raw label-plus-URL bullets, such as `Issue https://github.com/org/repo/issues/123`.
- Do not use label-colon bullets like `Implementation: ...` or `CI: <url>`.
- Use short bold subheads when a section needs grouping.

### Technical precision

Use exact names from the current diff, configuration, or verified output. Inline
code makes technical details easy to scan and prevents ambiguous prose.

- Wrap literal identifiers, commands, flags, package names, target triples,
  executable names, environment variables, CI queues and step keys, filenames,
  artifact names, paths, and exact errors in backticks.
- Name the actual executable or dependency instead of a broad tool family or
  marketing name. Write `cargo`, not Cargo, when referring to the command. Use
  `gcc-mingw-w64-x86-64` or the exact `llvm-mingw` archive name instead of
  MinGW when those are the dependencies the change actually uses.
- When platforms or architectures use different implementations, state the
  concrete mapping. For example, connect `x86_64-pc-windows-gnu` to
  `gcc-mingw-w64-x86-64` and `aarch64-pc-windows-gnullvm` to its exact pinned
  `llvm-mingw` archive rather than describing both as a MinGW build.
- Preserve review-relevant versions, artifact compatibility, runtime flags, and
  additional behavior from the diff. Do not hide meaningful changes behind
  umbrella terms or shorten a summary until it becomes inaccurate.
- Verify technical names against the diff or source before using them. Do not
  invent package names, versions, commands, or verification. Keep ordinary
  platform and product names such as Linux, Windows, Rust, and Buildkite in
  prose when they do not refer to literal code values.

Organize the summary around the reviewer's scan path.

- Start with what changed and why the reviewer should care.
- Then show where to focus in the diff.
- Then show independent validation when it adds information beyond CI.
- Prefer "what changed" over a chronological story of the work.
- Separate user-facing behavior, implementation details, migrations, and risks when more than one applies.
- Keep links close to the claim they support.
- Include only the evidence a reviewer needs to understand, verify, or trust the change.
- Move deep background to linked issues, docs, logs, screenshots, or inline code comments.

Reviewer-first template

```markdown
## Problem

What the reviewer should understand before reading the diff.

- The issue, missing capability, review context, or maintenance risk
- Why it matters now
- Source context links when useful

**Evidence**

- [Issue describing dropped webhook retries](https://github.com/org/repo/issues/123)
- [Design note for retry backoff behavior](https://github.com/org/repo/blob/main/docs/retries.md)
- [Before screenshot showing the failed retry state](https://github.com/org/repo/assets/before.png)

## Solution

What changed and why this shape fits.

**User behavior**

- ...

**Implementation**

- ...

**Compatibility**

- ...

**Risk**

- ...

**Review focus**

- ...

## Test

How the change was verified beyond automated CI.

- Ran `<one-off command>` and confirmed `<specific result>`.
- Created `<resource>`, exercised `<interaction>`, and confirmed `<observed behavior>`.
- [Screenshot or recording of the verified behavior](https://github.com/org/repo/assets/verified-behavior.png)
```

Omit `## Test` unless it documents meaningful validation performed separately from automated CI. Do not include a section just to repeat unit tests, routine checks, or CI results already visible on the PR.

Ground factual claims with links when practical. Prefer durable links such as issue URLs, GitHub Actions run URLs, docs URLs, and commit-SHA code permalinks over branch links that can move.

When linking to code after pushing, prefer a commit permalink:

```sh
OWNER_REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
HEAD_SHA="$(git rev-parse HEAD)"
printf 'https://github.com/%s/blob/%s/%s#L%s\n' "$OWNER_REPO" "$HEAD_SHA" "path/to/file" "123"
```

## Create The PR

Always create pull requests ready for review. Never create draft pull requests or pass `--draft`.

```sh
gh pr create \
  --base <base-branch> \
  --head "$(git branch --show-current)" \
  --title "<clear title>" \
  --body-file /tmp/pr-body.md
```

After creation, confirm the PR URL, metadata, and `isDraft: false`:

```sh
gh pr view --json number,url,title,isDraft,baseRefName,headRefName
```

`gh pr create` reference: https://cli.github.com/manual/gh_pr_create

## GitHub Inline Comments

Use GitHub inline comments on changed code to call out or explain key concepts for reviewers. These comments complement persistent code comments; they should not replace code comments that future maintainers need after the PR is merged.

Add inline comments sparingly:

- Comment on changed lines only.
- Explain review-relevant context, invariants, subtle tradeoffs, compatibility constraints, or why a surprising implementation is intentional.
- Link to source material when a claim depends on an issue, external doc, design note, CI run, or code permalink.

Create inline comments with `gh api` after the PR exists:

```sh
OWNER_REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
PR_NUMBER="$(gh pr view --json number -q .number)"
HEAD_SHA="$(git rev-parse HEAD)"

gh api "repos/$OWNER_REPO/pulls/$PR_NUMBER/comments" \
  -f body="This comment explains the review-relevant concept and links to the evidence: <url>" \
  -f commit_id="$HEAD_SHA" \
  -f path="path/to/changed-file.ext" \
  -f side="RIGHT" \
  -F line=123
```

The `line` must be on the PR diff. If GitHub rejects the anchor, inspect the diff and choose a changed line rather than forcing a broad PR comment.

Pull request review comment API reference: https://docs.github.com/en/rest/pulls/comments#create-a-review-comment-for-a-pull-request

## Final Response

For PR-summary, PR-body, or other copy-only requests, return the complete
GitHub-ready body inside a fenced `markdown` code block.

Report the PR URL with its title and confirm it is ready for review.
