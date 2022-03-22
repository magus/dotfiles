#!/bin/bash

RESTORE_DIR=$(pwd)
# Move into /tmp
cd /tmp

# Brave
curl -L -O "https://referrals.brave.com/latest/Brave-Browser.dmg"
hdiutil mount -nobrowse Brave-Browser.dmg
cp -R "/Volumes/Brave Browser/Brave Browser.app" /Applications
hdiutil unmount "/Volumes/Brave Browser"
rm Brave-Browser.dmg

# Open Brave to set default browser
open "/Applications/Brave Browser.app"

# mpv
brew install --cask mpv

# Slack
curl -L -o slack.zip "https://slack.com/ssb/download-osx-beta"
unzip slack.zip
mv Slack.app /Applications
rm slack.zip
open /Applications/Slack.app

# Visual Studio Code
curl -L -o vs-code.zip "https://go.microsoft.com/fwlink/?LinkID=620882"
unzip vs-code.zip
mv "Visual Studio Code.app" /Applications
rm vs-code.zip

# Transmission
curl -L -o Transmission.dmg "https://transmission.cachefly.net/Transmission-2.84.dmg"
hdiutil mount -nobrowse Transmission.dmg
cp -R "/Volumes/Transmission/Transmission.app" /Applications
hdiutil unmount "/Volumes/Transmission"
rm Transmission.dmg

# Spectacle
curl -L -o Spectacle.zip "https://s3.amazonaws.com/spectacle/downloads/Spectacle+1.2.zip"
unzip Spectacle.zip
mv Spectacle.app /Applications
open /Applications/Spectacle.app
rm Spectacle.zip

# The Unarchiver
curl -L -o TheUnarchiver.zip https://dl.devmate.com/cx.c3.theunarchiver/TheUnarchiver.zip
unzip TheUnarchiver.zip
mv The\ Unarchiver.app /Applications
rm TheUnarchiver.zip

# ScrollReverser
curl -L -o ScrollReverser.zip https://pilotmoon.com/downloads/ScrollReverser-1.7.6.zip
unzip ScrollReverser.zip
mv Scroll\ Reverser.app /Applications
rm ScrollReverser.zip
open /Applications/Scroll\ Reverser.app

# Inconsolata font
# https://github.com/googlefonts/Inconsolata
curl -L -o Inconsolata.zip https://github.com/googlefonts/Inconsolata/releases/download/v3.000/fonts_ttf.zip
unzip Inconsolata.zip
open fonts/ttf/*.ttf

# SourceCodePro font
open $HOME/.dotfiles/fonts/SourceCodePro/*.otf


# Open pages for Brave extensions
# Name in middle of url
open "https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm"
open "https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi"
open "https://chrome.google.com/webstore/detail/reddit-enhancement-suite/kbmfpngjjgdllneeigpgjifpgocmfgmb"
open "https://chrome.google.com/webstore/detail/go-back-with-backspace/eekailopagacbcdloonjhbiecobagjci/related?hl=en"

# 1Password
open "https://chrome.google.com/webstore/detail/1password-password-manage/aomjjhallfgjeglblehebfpbcfeobpgk?hl=en"
open "https://1password.com/downloads/"

# Github SSH keys
open "https://help.github.com/articles/testing-your-ssh-connection/"
open "https://github.com/settings/ssh"
open "https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/"

# Navigate back
cd "$RESTORE_DIR"
