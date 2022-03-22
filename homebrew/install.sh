#!/bin/sh

# Check for Homebrew
if [[ -e $(which brew) ]]; then
  echo '✅ Homebrew already installed.'
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  /usr/local/bin/brew doctor
fi
