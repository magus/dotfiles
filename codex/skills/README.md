# `codex/skills`

## setup

```bash
~/.dotfiles/codex/codex.config.sh
```

Skills local to this folder are symlinked into `~/.agents/skills` and `~/.codex/skills`.
`skill-lock.json` is symlinked to `~/.agents/.skill-lock.json`.
Missing third-party skills listed in `skill-lock.json` are installed automatically.
Local skill directories are for skills we maintain ourselves, like `moshi-attention`.

## install third-party skill

Global installs update `skill-lock.json` through `~/.agents/.skill-lock.json` symlink.
Global installs tracked in `~/.agents/.skill-lock.json`.
Commit `skill-lock.json` after adding or updating skills.

```sh
npx skills@latest add jakubkrehel/make-interfaces-feel-better \
  --skill make-interfaces-feel-better \
  --agent codex \
  --global \
  --yes
```
