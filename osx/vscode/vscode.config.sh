#!/bin/bash

echo 'symmlink vscode pref file to user library application dir'

link_file() {
  src="$1"
  tgt="$2"

  echo "linking [$src] -> [$tgt]"
  ln -sf "$src" "$tgt"
}

link_file "$HOME/.dotfiles/osx/vscode/settings.json" "$HOME/Library/Application Support/Code/User"
link_file "$HOME/.dotfiles/osx/vscode/keybindings.json" "$HOME/Library/Application Support/Code/User"
