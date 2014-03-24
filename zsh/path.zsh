function prepend_path () {
  export PATH=$1:$PATH
}

function apppend_path () {
  export PATH=$PATH:$1
}

#prepend_path /usr/local/share/npm/bin

#npm modules
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH
prepend_path /usr/local/share/npm/bin

#apple put /usr/bin before /usr/local/bin -_-
prepend_path /usr/local/bin
prepend_path /usr/local/sbin

### Added by the Heroku Toolbelt
prepend_path /usr/local/heroku/bin

### Added by RVM for scripting
append_path $HOME/.rvm/bin
