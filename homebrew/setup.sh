#!/bin/bash
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew
if [ ! -e "$(which brew)" ]; then
  echo ' '
  echo '  🚨 You should probably install Homebrew first:'
  echo ' '
  # shellcheck disable=SC2016
  echo '     eval "$(curl https://raw.githubusercontent.com/magus/dotfiles/master/homebrew/install.sh)"'
  echo ' '
  exit 1
fi

# Homebrew 6 defaults to prompting before installs. Keep dotfiles setup moving.
export HOMEBREW_NO_ASK=1

# Update homebrew
brew update

# Install homebrew packages
brew install coreutils nmap parallel iftop
brew install --force-bottle ffmpeg
brew install fpp
brew install git-delta
brew install git-absorb
brew install direnv
brew install vim
brew install tmux
brew install fzf
brew install ripgrep
brew install magus/git-stack/git-stack

# javascript
brew install fnm
