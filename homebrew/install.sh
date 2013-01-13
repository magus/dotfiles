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
else
  echo '  x You should probably install Homebrew first:'
  echo '    $ ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"'
fi
