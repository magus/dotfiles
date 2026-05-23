#!/bin/bash

echo "symlink codex config"

link_path() {
  src="$1"
  tgt="$2"

  echo "linking [$src] -> [$tgt]"
  ln -sfn "$src" "$tgt"
}

# https://opencode.ai/docs/config/#locations

src_dir="$HOME/.dotfiles/codex"
dst_dir="$HOME/.codex"
mkdir -p "$dst_dir"
mkdir -p "$src_dir/skills"
mkdir -p "$dst_dir/skills"

link_path "$src_dir/config.toml" "$dst_dir/config.toml"

for skill_dir in "$src_dir"/skills/*; do
  [ -d "$skill_dir" ] || continue

  skill_name="$(basename "$skill_dir")"
  target="$dst_dir/skills/$skill_name"

  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "leaving existing [$target]; move it aside before rerunning to dotfile this skill"
    continue
  fi

  link_path "$skill_dir" "$target"
done
