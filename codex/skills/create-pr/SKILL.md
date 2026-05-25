---
name: create-pr
description: Use when Noah asks Codex to create, open, publish, or draft a GitHub pull request for him, including requests like "create a PR for me", "open a PR", "ship this branch as a PR", or "turn these changes into a PR". Prefer the gh CLI, write reviewer-first PR summaries using ## Problem, ## Solution, and optional ## Test sections, preserve useful implementation context in code comments, and add GitHub inline comments on changed code when they help reviewers understand key concepts.
---

# Create PR

Use this skill when Noah asks to create a GitHub pull request from local or already-pushed changes.

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

If verification details are substantial, put them in a separate `## Test` section in the PR body. Include commands run, concise output excerpts, and links to output artifacts such as screenshots, recordings, logs, CI runs, or deployed previews.

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

Use `## Problem` and `## Solution` as the default top-level sections. Add `## Test` when test evidence, command output, artifact links, or verification notes are more readable as their own section.

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

Organize the summary around the reviewer's scan path.

- Start with what changed and why the reviewer should care.
- Then show where to focus in the diff.
- Then show how the change was tested.
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

How this was verified.

- `command`
  Result
- [Rendered screenshot artifact](https://github.com/org/repo/actions/runs/123/artifacts/456)
- [Passing CI run](https://github.com/org/repo/actions/runs/123)
- Not run because <reason>
```

Omit `## Test` when verification is trivial and fits cleanly in `## Solution`.

Ground factual claims with links when practical. Prefer durable links such as issue URLs, GitHub Actions run URLs, docs URLs, and commit-SHA code permalinks over branch links that can move.

When linking to code after pushing, prefer a commit permalink:

```sh
OWNER_REPO="$(gh repo view --json nameWithOwner -q .nameWithOwner)"
HEAD_SHA="$(git rev-parse HEAD)"
printf 'https://github.com/%s/blob/%s/%s#L%s\n' "$OWNER_REPO" "$HEAD_SHA" "path/to/file" "123"
```

## Create The PR

Default to a draft PR unless Noah explicitly asks for a ready-for-review PR or the branch is clearly ready by repo convention.

```sh
gh pr create \
  --draft \
  --base <base-branch> \
  --head "$(git branch --show-current)" \
  --title "<clear title>" \
  --body-file /tmp/pr-body.md
```

If creating a non-draft PR:

```sh
gh pr create \
  --base <base-branch> \
  --head "$(git branch --show-current)" \
  --title "<clear title>" \
  --body-file /tmp/pr-body.md
```

After creation, confirm the PR URL and metadata:

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

Report the PR URL with its title and draft/ready status.
