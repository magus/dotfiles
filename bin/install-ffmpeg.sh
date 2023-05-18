#!/bin/bash
# install ffmpeg on osx/ubuntu


# regex matching is undefined in POSIX
# https://www.shellcheck.net/wiki/SC3015
# e.g. if [ "$OSTYPE" =~ ^darwin ]; then
regex_test() {
  search="$1"
  regex="$2"

  expr "$search" : "$regex" > /dev/null

  return $?
}


if [ -e "$(which ffmpeg)" ]; then
  echo "✅ ffmpeg detected"
  exit 0
fi



if [ "$(regex_test "$(cat /etc/issue 2> /dev/null)" "Ubuntu")" ]; then
  # ubuntu
  sudo apt install ffmpeg

  if [ ! -e "$(which ffmpeg)" ]; then
    echo "❌ ffmpeg could not be installed"
    exit 1
  fi
elif [ "$(regex_test "$OSTYPE" "^darwin")" ]; then
  # osx
  # Use FFMPEG_INSTALL_PATH=/custom/path to override this install path
  FFMPEG_INSTALL_PATH=${FFMPEG_INSTALL_PATH:-"/usr/local/bin"}

  echo "⏳ ffmpeg downloading ..."
  echo

  output_zip="ffmpeg.zip"
  curl -L "https://evermeet.cx/ffmpeg/get/zip" --output "$output_zip"
  unzip "$output_zip"
  rm "$output_zip"

  echo
  echo "🧰 moving ffmpeg to $FFMPEG_INSTALL_PATH"
  mv ffmpeg "$FFMPEG_INSTALL_PATH"
  echo

  if [ ! -e "$(which ffmpeg)" ]; then
    echo "❌ ffmpeg could not be installed"
    echo
    echo "Check output above and confirm $FFMPEG_INSTALL_PATH in your path"
    echo "Use FFMPEG_INSTALL_PATH=/custom/path to override install path"

    exit 1
  fi
else
  echo "❌ system not handled by script"
  echo "report issue to https://github.com/magus/dotfiles/issues/new"
fi


echo "✅ ffmpeg installed successfully"
