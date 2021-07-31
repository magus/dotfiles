#!/bin/bash

set -x

echo 'setup ~/.secrets directory for secret files'

# ensure /root dir exists
mkdir -p $HOME/.secrets
