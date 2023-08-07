#!/bin/bash

# install disabled fasd formula
# https://stackoverflow.com/questions/73586208/can-you-install-disabled-homebrew-packages

echo " "
echo "  🚨 fasd brew formula is disabled, requires manual edit"
echo "     you will need to delete the following line from the formula"
echo " "
echo '       disable! date: "2023-06-19", because: :repo_archived'
echo " "
echo " "
echo "     Running \`brew edit fasd\` in 3 seconds..."
echo " "
echo " "
sleep 3
brew edit fasd
echo " "
echo " "
read -n 1 -s -r -p "  ⏳ press any key to proceed after editing..."
echo " "
echo " "
echo "  ✅ done, running \`brew install fasd\`..."
echo " "
# shellcheck disable=SC2034
HOMEBREW_NO_INSTALL_FROM_API=1 HOMEBREW_NO_AUTO_UPDATE=1 brew install fasd
