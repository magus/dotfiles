#!/bin/bash

echo "symmlink zed setting files"

link_file() {
  src="$1"
  tgt="$2"

  echo "linking [$src] -> [$tgt]"
  ln -sf "$src" "$tgt"
}

zed_dotfiles="$HOME/.dotfiles/osx/zed"
link_file "$zed_dotfiles/settings.json" "$HOME/.config/zed"
link_file "$zed_dotfiles/keymap.json" "$HOME/.config/zed"
