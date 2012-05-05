
export CLICOLOR=true
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS=$LSCOLORS

fpath=($ZSH/zsh/functions $fpath)

autoload -U $ZSH/zsh/functions/*(:t)

setopt correct
setopt completeinword
setopt extendedglob		#complex globbing ftw
setopt promptsubst		#expansion/substitution in prompts

#emacs line editing
bindkey -e

