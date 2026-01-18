#!/bin/bash

function copy-command-line {
    echo -n $BUFFER | pbcopy
}

zle -N copy-command-line

# discover key codes by using `cat -v` and pressing the keys

# previously used `⌘+shift+c` but that did not work in tmux
bindkey 'Ç' copy-command-line # option+shift+c

clear_scrollback_and_redraw() {
    if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
        print -n $'\e]1337;ClearScrollback\a'
    else
        print -n $'\e[3J'
    fi

    print -n $'\e[H\e[2J'
    zle reset-prompt
}

zle -N clear_scrollback_and_redraw
bindkey '^K' clear_scrollback_and_redraw
