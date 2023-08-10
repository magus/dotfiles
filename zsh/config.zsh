
export CLICOLOR=true
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS=$LSCOLORS

fpath=($ZSH/zsh/functions $fpath)

setopt correct
setopt completeinword
setopt extendedglob		#complex globbing ftw
setopt promptsubst		#expansion/substitution in prompts

#emacs line editing
bindkey -e

# `⌥ + ← →` to move back and forward words
# `esc + f b` also works in this same way
#
# discover codes by using `cat -v` and pressing the keys
#
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;3C" forward-word

