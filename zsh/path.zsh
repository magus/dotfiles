function prepend_path () {
  export PATH=$1:$PATH
}

function append_path () {
  export PATH=$PATH:$1
}

# apple put /usr/bin before /usr/local/bin -_-
prepend_path /usr/local/bin
prepend_path /usr/local/sbin

# google cloud sdk
append_path $HOME/google-cloud-sdk/bin

# fastlane
append_path "$HOME/.fastlane/bin"

# homebrew
eval "$(cat $HOME/.dotfiles/homebrew/path.sh)"

# go
append_path "/usr/local/go/bin"

# ensure dotfiles bin are preferred
prepend_path $HOME/.dotfiles/bin

# zig
# https://ziglang.org/download/
prepend_path "/opt/zig/0.16.0"

# opencode
prepend_path "$HOME/.opencode/bin"
