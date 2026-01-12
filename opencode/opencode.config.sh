#!/bin/bash

echo "symmlink opencode config"

link_file() {
  src="$1"
  tgt="$2"

  echo "linking [$src] -> [$tgt]"
  ln -sf "$src" "$tgt"
}

# https://opencode.ai/docs/config/#locations

src_dir="$HOME/.dotfiles/opencode"
dst_dir="$HOME/.config/opencode"
mkdir -p "$dst_dir"

link_file "$src_dir/opencode.json" "$dst_dir"

