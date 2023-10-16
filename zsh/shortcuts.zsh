#!/bin/bash

# discover key codes by using `cat -v` and pressing the keys

function copy-command-line {
    echo -n $BUFFER | pbcopy
}

zle -N copy-command-line
bindkey '^[[99;10u' copy-command-line # ⌘+shift+c
