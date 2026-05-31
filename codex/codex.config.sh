#!/bin/bash



stderr() {
  echo "$@" >&2
}

run() {
  stderr "$(color -f bright_green '❯')" "$@"
  "$@"
}

link_path() {
  src="$1"
  tgt="$2"

  stderr "linking [$src] → [$tgt]"
  ln -sfn "$src" "$tgt"
}

cleanup_broken_skill_links() {
  skills_dir="$1"

  [ -d "$skills_dir" ] || return

  find "$skills_dir" -maxdepth 1 -type l | while read -r link; do
    target="$(readlink "$link")"
    case "$target" in
      "$src_dir"/skills/*)
        if [ ! -e "$link" ]; then
          stderr "removing broken skill link [$link] → [$target]"
          rm "$link"
        fi
        ;;
    esac
  done
}

stderr "symlink codex config"

src_dir="$HOME/.dotfiles/codex"
codex_dir="$HOME/.codex"
agents_dir="$HOME/.agents"

mkdir -p "$codex_dir"
mkdir -p "$agents_dir"
mkdir -p "$codex_dir/skills"
mkdir -p "$agents_dir/skills"

link_path "$src_dir/config.toml" "$codex_dir/config.toml"
link_path "$src_dir/skills/skill-lock.json" "$agents_dir/.skill-lock.json"

cleanup_broken_skill_links "$codex_dir/skills"
cleanup_broken_skill_links "$agents_dir/skills"

for skill_dir in "$src_dir"/skills/*; do
  [ -d "$skill_dir" ] || continue

  skill_name="$(basename "$skill_dir")"

  target="$codex_dir/skills/$skill_name"
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    stderr "⚠️ SKIP $skill_name (exists at $target)"
  else
    link_path "$skill_dir" "$target"
  fi

  target="$agents_dir/skills/$skill_name"
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    stderr "⚠️ SKIP $skill_name (exists at $target)"
  else
    link_path "$skill_dir" "$target"
  fi
done

jq -r '.skills | to_entries[] | @base64' ~/.agents/.skill-lock.json | while read -r row; do
  name="$(echo "$row" | base64 -d | jq -r '.key')"
  source="$(echo "$row" | base64 -d | jq -r '.value.source')"
  ref="$(echo "$row" | base64 -d | jq -r '.value.ref // empty')"

  if [ -n "$ref" ]; then
    source="$source#$ref"
  fi

  run npx skills@latest add "$source" \
    --skill "$name" \
    --agent codex \
    --global \
    --yes
done
