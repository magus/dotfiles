#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if [[ -e $(which brew) ]]; then
  # Update homebrew
  brew update
  # Install homebrew packages
  brew install grc coreutils grc nmap parallel iftop
  brew install fpp
  brew install git-delta
  brew install direnv

  # node
  brew install fnm

  # yarn
  brew install yarn --ignore-dependencies

  # vim
  brew install vim

  # kitty terminal
  brew install --cask kitty

else
  echo ' '
  echo '  🚨 You should probably install Homebrew first:'
  echo ' '
  echo '     eval "$(curl https://raw.githubusercontent.com/magus/dotfiles/master/homebrew/install.sh)"'
  echo ' '
  exit 1
fi
