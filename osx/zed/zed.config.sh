#!/bin/bash

echo "symmlink zed setting files"

link_file() {
  src="$1"
  tgt="$2"

  echo "linking [$src] -> [$tgt]"
  ln -sf "$src" "$tgt"
}

src_dir="$HOME/.dotfiles/osx/zed"
dst_dir="$HOME/.config/zed"
mkdir -p "$dst_dir"

link_file "$src_dir/settings.json" "$dst_dir"
link_file "$src_dir/keymap.json" "$dst_dir"
