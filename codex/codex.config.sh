#!/bin/bash

echo "symmlink codex config"

link_file() {
  src="$1"
  tgt="$2"

  echo "linking [$src] -> [$tgt]"
  ln -sf "$src" "$tgt"
}

# https://opencode.ai/docs/config/#locations

src_dir="$HOME/.dotfiles/codex"
dst_dir="$HOME/.codex"
mkdir -p "$dst_dir"

link_file "$src_dir/config.toml" "$dst_dir"

