#!/bin/bash

echo 'symmlink vscode pref file to user library application dir'

src="$HOME/.dotfiles/osx/vscode/settings.json"
tgt="$HOME/Library/Application Support/Code/User"

echo "linking [$src] -> [$tgt]"
ln -sf "$src" "$tgt"
