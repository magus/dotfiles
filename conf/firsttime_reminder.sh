# This file is sourced at the end of a first-time dotfiles install.
source ~/.zshrc

cat <<EOF
SSH Keys (if this is a server)
 1. (main) scp ~/.ssh/id_rsa.pub $USER@$(ip):~/.ssh/
 2. (here) cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

Git / GitHub
 1. Get GitHub API token from https://github.com/account/admin
 2. (here) git config --global github.token "omgsupersecretgithubapitoken"
 3. (here) git config --global user.name "First Last"
 4. (here) git config --global user.email "email@domain.com"

 * zsh will start as your default shell on subsequent logins

Open Visual Studio Code > '⌘+Shift+P' > 'shell command' to install 'code' to 'PATH'

   $ code .

Then followup with '⌘+Shift+P' > 'install extensions'
Install 'shan.code-settings-sync' and sync settings from gist below

   https://gist.github.com/magus/96a4c2ed765de2ba98826cfed27e7b14
EOF
