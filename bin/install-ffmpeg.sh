#!/bin/bash
# install ffmpeg on osx/ubuntu

# osx only, use FFMPEG_INSTALL_PATH=/custom/path to override this install path
FFMPEG_INSTALL_PATH=${FFMPEG_INSTALL_PATH:-"/usr/local/bin"}

install_ffmpeg_bin() {
  name="$1"

  if check_bin "$name"; then
    echo "✅ $name detected"
    return 0
  fi

  # fork based on operating system
  if regex_test "$(cat /etc/issue 2>/dev/null)" "Ubuntu"; then
    # ubuntu
    ubuntu_install "$name"
  elif regex_test "$OSTYPE" "^darwin"; then
    # osx
    osx_install "$name"

    if check_bin "$name"; then
      echo "Check output above and confirm [$FFMPEG_INSTALL_PATH] in your \$PATH"
      echo "Use \`FFMPEG_INSTALL_PATH=/custom/path install-ffmpeg\` to override install path"
      echo
    fi
  else
    echo "❌ system not handled by script"
    echo "report issue to https://github.com/magus/dotfiles/issues/new"
    return 1
  fi

  if ! check_bin "$name"; then
    echo "❌ $name could not be installed"
    return 1
  fi

  echo "✅ $name installed successfully"
}

osx_install() {
  name="$1"
  url="https://evermeet.cx/ffmpeg/getrelease/$name/zip"

  echo
  echo "⏳ $name downloading [$url]..."
  echo

  output_zip="$name.zip"
  curl -L "$url" --output "$output_zip"
  unzip "$output_zip"
  rm "$output_zip"

  echo
  echo "🧰 moving $name to $FFMPEG_INSTALL_PATH"
  mv "$name" "$FFMPEG_INSTALL_PATH"
  echo
}

ubuntu_install() {
  name="$1"

  echo
  sudo apt install "$name"
}

install_ffmpeg_bin "ffmpeg"
install_ffmpeg_bin "ffprobe"
