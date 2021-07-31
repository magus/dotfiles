#!/bin/bash

set -x

echo 'install tarsnap and setup ~/.tarsnaprc'

# tarsnap
brew install tarsnap

# ensure tarsnap cache directory
mkdir -p ~/.secrets/tarsnap/cache

cat <<EOF
Run the command below to register this machine with the tarsnap server
generating a unique ~/.secrets/tarsnap.key file

  tarsnap-keygen \\
    --keyfile ~/.secrets/tarsnap/tarsnap.key \\
    --user tarsnap@iamnoah.com \\
    --machine "$(uname -n)"

See https://www.tarsnap.com/gettingstarted.html

EOF
