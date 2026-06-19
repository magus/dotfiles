# This file is sourced at the end of a first-time dotfiles install.
source ~/.zshrc

cat <<EOF
Settings

  Trackpad
    Point & Click
    - Tracking speed: 6
    - Click: Medium
    - Tap to click: Enabled

    More Gestures
    - Swipe between pages: Swipe with Two or Three fingers
    - Swipe between full-screen applications: Swipe Left or Right with Four fingers

Install Chrome

  https://www.google.com/chrome/

Create SSH key for this machine

  https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
  https://github.com/settings/ssh
  https://help.github.com/articles/testing-your-ssh-connection/

SSH Keys (if this is a server)

  1. (main) scp ~/.ssh/id_rsa.pub $USER@$(ip):~/.ssh/
  2. (here) cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

Visual Studio Code

  Open Visual Studio Code > '⌘+Shift+P' > 'shell command' to install 'code' to 'PATH'

  $ code .

  Then followup with '⌘+Shift+P' > 'install extensions'
  Install 'shan.code-settings-sync' and sync settings from gist below

  https://gist.github.com/magus/96a4c2ed765de2ba98826cfed27e7b14
EOF
