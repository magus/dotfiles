#!/bin/sh

# Check for Homebrew
if [[ -e $(which brew) ]]; then
  echo '✅ Homebrew already installed.'
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(curl https://raw.githubusercontent.com/magus/dotfiles/master/homebrew/path.sh)"
fi
