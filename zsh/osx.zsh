function prepend_path () {
  export PATH=$1:$PATH
}

#prepend_path /usr/local/share/npm/bin

#apple put /usr/bin before /usr/local/bin -_-
prepend_path /usr/local/bin
prepend_path /usr/local/sbin
