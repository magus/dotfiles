#!/bin/sh

# detect x86 vs arm4 homebrew installations
# arm64 is new apply silicon (e.g. m1, m2, etc.)
# x86 may be present on an m2 for example when brew is installed with x86 architecture
#
#   arch -x86_64 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#
# to handle these backwards compatible installations we check brew path
# x86     /usr/local/bin/brew
# arm64   /opt/homebrew/bin/brew
if [[ "$(which brew)" == "/usr/local/bin/brew" ]]; then
  # x86
  # no op, brew path is fine
else
  # arm64
  # if [[ "arm64" == "$(uname -m)" ]]; then
  echo "arm64"

  # this `brew shellenv` command sets $HOMEBREW_PREFIX to the correct value
  # it also updates the $PATH with the path to the `brew` executable
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

