#!/bin/sh

# we detect apple silicon (e.g. m1)
if [[ "arm64" == "$(uname -m)" ]]; then
  # this `brew shellenv` command sets $HOMEBREW_PREFIX to the correct value
  # it also updates the $PATH with the path to the `brew` executable
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi


