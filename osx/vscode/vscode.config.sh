#!/bin/bash

echo 'symmlink vscode pref file to user library application dir'

link_file() {
  src="$1"
  tgt="$2"

  echo "linking [$src] -> [$tgt]"
  ln -sf "$src" "$tgt"
}

src_dir="$HOME/.dotfiles/osx/vscode"
dst_dir=(
  "$HOME/Library/Application Support/Code/User"
  "$HOME/Library/Application Support/Cursor/User"
)

for dir in "${dst_dir[@]}"; do
  mkdir -p "$dir"
done

for dir in "${dst_dir[@]}"; do
  link_file "$src_dir/settings.json" "$dir"
  link_file "$src_dir/keybindings.json" "$dir"
done
