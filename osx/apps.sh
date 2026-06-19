#!/bin/bash

RESTORE_DIR=$(pwd)
# Move into /tmp
cd /tmp

# mpv
brew install --cask mpv

# The Unarchiver
open "https://theunarchiver.com/"

# Extensions
# Name in middle of url
open "https://chromewebstore.google.com/detail/the-great-suspender-reloa/hlofigcdgjlnalbkeeinfcjceabpamci"
open "https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh"
open "https://chrome.google.com/webstore/detail/go-back-with-backspace/eekailopagacbcdloonjhbiecobagjci/related?hl=en"

# Visual Studio Code
open "https://code.visualstudio.com/"

# Github SSH keys
open "https://help.github.com/articles/testing-your-ssh-connection/"
open "https://github.com/settings/ssh"
open "https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/"

# 1Password
open "https://chrome.google.com/webstore/detail/1password-password-manage/aomjjhallfgjeglblehebfpbcfeobpgk?hl=en"
open "https://1password.com/downloads/"

# iTerm2
open "https://iterm2.com/"

# Inconsolata font
# https://github.com/googlefonts/Inconsolata
curl -L -o Inconsolata.zip https://github.com/googlefonts/Inconsolata/releases/download/v3.000/fonts_ttf.zip
unzip Inconsolata.zip
open fonts/ttf/*.ttf

# SourceCodePro font
open $HOME/.dotfiles/fonts/SourceCodePro/*.otf

# Meslo font
# used by zsh/p10k.zsh.symlink (powerline)
open $HOME/.dotfiles/fonts/MesloLGS-NerdFont/*.ttf

# Navigate back
cd "$RESTORE_DIR"
