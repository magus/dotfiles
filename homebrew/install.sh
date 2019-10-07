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
  brew install diff-so-fancy
  brew install direnv

  ## nvm & node
  brew install nvm

  ## setup nvm temporarily
  . $HOME/.dotfiles/zsh/nvm.zsh

  ## install node
  nvm install node
  nvm alias default node

  ## yarn
  brew install yarn --ignore-dependencies

  ## vim
  brew install vim


else
  echo '  x You should probably install Homebrew first:'
  echo '    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"'
  exit 1
fi
