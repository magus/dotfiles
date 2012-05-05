
export CLICOLOR=true
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS=$LSCOLORS

fpath=($ZSH/zsh/functions $fpath)

autoload -U $ZSH/zsh/functions/*(:t)

setopt correct
setopt completeinword
setopt extendedglob		#complex globbing ftw

#emacs line editing
bindkey -e

#apple put /usr/bin before /usr/local/bin -_-
PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH
