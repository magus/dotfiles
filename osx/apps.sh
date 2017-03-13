#!/bin/bash

RESTORE_DIR=$(pwd)
# Move into /tmp
cd /tmp

# Chrome
curl -L -O "https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg"
hdiutil mount -nobrowse googlechrome.dmg
cp -R "/Volumes/Google Chrome/Google Chrome.app" /Applications
hdiutil unmount "/Volumes/Google Chrome"
rm googlechrome.dmg

# Open Google Chrome to set default browser
open "/Applications/Google Chrome.app"

# mpv
brew install --with-bundle --with-little-cms2 --with-lua mpv && brew linkapps mpv

# Slack
curl -L -o slack.zip "https://slack.com/ssb/download-osx-beta"
unzip slack.zip
mv Slack.app /Applications
rm slack.zip
open /Applications/Slack.app

# Atom
curl -L -o atom-mac.zip "https://atom.io/download/mac"
unzip atom-mac.zip
mv Atom.app /Applications
rm atom-mac.zip

# iTerm2
curl -L -o iTerm2.zip "https://iterm2.com/downloads/stable/iTerm2-3_0_4.zip"
unzip iTerm2.zip
mv iTerm.app /Applications
rm iTerm2.zip

# hyper
curl -L -o hyper.dmg "https://hyper-updates.now.sh/download/mac"
hdiutil mount -nobrowse hyper.dmg
HYPER_MOUNT=$(find /Volumes -iname Hyper* -type d -maxdepth 1)
cp -R "$HYPER_MOUNT/Hyper.app" /Applications
hdiutil unmount "$HYPER_MOUNT"
rm hyper.dmg

# Transmission
curl -L -o Transmission.dmg "https://transmission.cachefly.net/Transmission-2.84.dmg"
hdiutil mount -nobrowse Transmission.dmg
cp -R "/Volumes/Transmission/Transmission.app" /Applications
hdiutil unmount "/Volumes/Transmission"
rm Transmission.dmg

# Dropbox
curl -L -o Dropbox.dmg "https://www.dropbox.com/download?plat=mac"
hdiutil mount -nobrowse Dropbox.dmg
open "/Volumes/Dropbox Installer/Dropbox.app"
hdiutil unmount "/Volumes/Dropbox Installer"
rm Dropbox.dmg

# The Unarchiver
curl -L -o TheUnarchiver.zip http://unarchiver.c3.cx/downloads/TheUnarchiver3.11.1.zip
unzip TheUnarchiver.zip
mv The\ Unarchiver.app /Applications
rm TheUnarchiver.zip

# SourceCodePro font
open $HOME/.dotfiles/fonts/SourceCodePro/*.otf


# Open pages for Chrome extensions
open "https://chrome.google.com/webstore/detail/ublock-origin/cjpalhdlnbpafiamejdnhcphjbkeiagm"
open "https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi"
open "http://redditenhancementsuite.com/"
open "https://chrome.google.com/webstore/detail/hacker-news-enhancement-s/bappiabcodbpphnojdiaddhnilfnjmpm"
open "https://chrome.google.com/webstore/detail/save-to-pocket/niloccemoadcdkdjlinkgdfekeahmflj"
open "https://chrome.google.com/webstore/detail/go-back-with-backspace/eekailopagacbcdloonjhbiecobagjci/related?hl=en"

# Great Suspender
open "https://chrome.google.com/webstore/detail/the-great-suspender/klbibkeccnjlkjkiokjodocebajanakg?hl=en"

# Github SSH keys
open "https://help.github.com/articles/testing-your-ssh-connection/"
open "https://github.com/settings/ssh"
open "https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/"

# Navigate back
cd "$RESTORE_DIR"
