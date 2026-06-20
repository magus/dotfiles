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
source_packages=(
  coreutils
  fpp
  iftop
  magus/git-stack/git-stack
  parallel
  tmux
)

brew install "${source_packages[@]}"

# Packages where falling back to a source build is especially slow.
force_bottle_packages=(
  direnv
  ffmpeg
  fnm
  fzf
  git-absorb
  git-delta
  imagemagick
  nmap
  ripgrep
  vim
)

brew install --force-bottle "${force_bottle_packages[@]}"
