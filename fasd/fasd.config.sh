#!/bin/bash

# Homebrew's fasd formula is disabled, so install from source instead.

set -e

prefix="$HOME/.local"

if command -v fasd >/dev/null 2>&1 || [ -x "$prefix/bin/fasd" ]; then
  echo 'fasd already installed'
  exit 0
fi

repo='https://github.com/clvv/fasd.git'
tmpdir="$(mktemp -d)"

cleanup() {
  rm -rf "$tmpdir"
}

trap cleanup EXIT

echo 'installing fasd from source'
mkdir -p "$prefix/bin"
git clone --depth 1 "$repo" "$tmpdir/fasd"
make -C "$tmpdir/fasd" install PREFIX="$prefix"

echo "fasd installed to $prefix/bin/fasd"
