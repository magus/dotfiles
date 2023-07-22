#!/bin/bash

echo 'symmlink tmux.conf to ~/.tmux.conf'
ln -sf "$HOME/.dotfiles/tmux/tmux.conf" "$HOME/.tmux.conf"

echo 'installing tmux plugin manager'
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
