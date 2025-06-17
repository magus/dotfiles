#!/bin/bash

# install disabled fasd formula
# https://stackoverflow.com/questions/73586208/can-you-install-disabled-homebrew-packages

echo " "
echo "  🚨 fasd brew formula is disabled, requires manual installation but it's easy!"
echo " "
echo '       https://github.com/clvv/fasd'
echo " "
echo " "
echo "       git clone git@github.com:clvv/fasd.git"
echo "       cd fasd"
echo "       make install"
echo " "
read -n 1 -s -r -p "  ⏳ press any key to proceed…"
echo " "
echo " "
echo "  ✅ done, run \`fasd\` to confirm installation"
echo " "
# shellcheck disable=SC2034
HOMEBREW_NO_INSTALL_FROM_API=1 HOMEBREW_NO_AUTO_UPDATE=1 brew install fasd
