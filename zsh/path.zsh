function prepend_path () {
  export PATH=$1:$PATH
}

function append_path () {
  export PATH=$PATH:$1
}

# prepend_path /usr/local/share/npm/bin

# npm modules
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
prepend_path /usr/local/share/npm/bin

# apple put /usr/bin before /usr/local/bin -_-
prepend_path /usr/local/bin
prepend_path /usr/local/sbin

# Added by the Heroku Toolbelt
prepend_path /usr/local/heroku/bin

# Added by RVM for scripting
append_path $HOME/.rvm/bin

# google cloud sdk
append_path $HOME/google-cloud-sdk/bin

# yarn
append_path "$HOME/.yarn/bin"

# fastlane
append_path "$HOME/.fastlane/bin"

# homebrew
eval "$(cat $HOME/.dotfiles/homebrew/path.sh)"

## periscope platform-binaries
append_path $HOME/periscope/platform-binaries/bin

# gem bin path
append_path $HOME/.gem/ruby/2.6.0/bin

# go
export GOPATH=$HOME/periscope/gocode;
append_path $GOPATH/bin
