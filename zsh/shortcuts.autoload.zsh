#!/bin/bash

function copy-command-line {
    echo -n $BUFFER | pbcopy
}

zle -N copy-command-line

# discover key codes by using `cat -v` and pressing the keys

# previously used `⌘+shift+c` but that did not work in tmux
bindkey 'Ç' copy-command-line # option+shift+c
