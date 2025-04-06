#!/bin/bash

echo 'symmlink vscode pref file to user library application dir'

link_file() {
  src="$1"
  tgt="$2"

  echo "linking [$src] -> [$tgt]"
  ln -sf "$src" "$tgt"
}

settings_json="$HOME/.dotfiles/osx/vscode/settings.json"
link_file "$settings_json" "$HOME/Library/Application Support/Code/User"
link_file "$settings_json" "$HOME/Library/Application Support/Cursor/User"

keybindings_json="$HOME/.dotfiles/osx/vscode/keybindings.json"
link_file "$keybindings_json" "$HOME/Library/Application Support/Code/User"
link_file "$keybindings_json" "$HOME/Library/Application Support/Cursor/User"
