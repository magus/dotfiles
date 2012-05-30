function prepend_path () {
  export PATH=$1:$PATH
}

#prepend_path /usr/local/share/npm/bin

#npm modules
export NODE_PATH=/usr/local/lib/node_modules:$NODE_PATH

#apple put /usr/bin before /usr/local/bin -_-
prepend_path /usr/local/bin
prepend_path /usr/local/sbin


