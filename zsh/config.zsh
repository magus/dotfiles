#!/bin/bash

# your project folder that we can `c [tab]` to
export PROJECTS=~/Development

export EDITOR="/usr/local/bin/code --wait"

export CLICOLOR=true
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS=$LSCOLORS

fpath=($ZSH/zsh/functions $fpath)

# remove characters from WORDCHARS
# allows option + left and right arrow to break words by excluded characters
# if we leave the characters in the WORDCHARS they will be included as part of the word
# which means we will jump over them entirely and not stop between each one
#   \/  removes path separator for folders in a path
#   \.  removes period for file extensions, subdomains in urls, etc.
WORDCHARS=${WORDCHARS//[\.\/]}


# set the titles to show the command name typed by the user while
# the command is being executed and then the current directory
# name after the command ended (i.e. before each prompt)
# https://github.com/zimfw/termtitle
zstyle ':zim:termtitle' hooks 'preexec' 'precmd'
zstyle ':zim:termtitle:preexec' format '${1}'
zstyle ':zim:termtitle:precmd'  format '%~'

# prompt for spelling correction of commands.
setopt correct
# customize spelling correction prompt.
SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

setopt completeinword
setopt extendedglob		#complex globbing ftw
setopt promptsubst		#expansion/substitution in prompts

# set editor default keymap to emacs (`-e`) or vi (`-v`)
# emacs line editing
bindkey -e

# `⌥ + ← →` to move back and forward words
# `esc + f b` also works in this same way
#
# discover codes by using `cat -v` and pressing the keys
#
bindkey "^[^[[C" forward-word
bindkey "^[^[[D" backward-word

# zsh-users/zsh-history-substring-search
zmodload -F zsh/terminfo +p:terminfo
# bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
# previously was only doing below, before pulling in default config from zim
#   bindkey '^[[A' history-substring-search-up
#   bindkey '^[[B' history-substring-search-down
#
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key


# used by zsh-history-substring-search
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1


# zsh-users/zsh-autosuggestions
# set the text color for the suggested text
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#configuration
# https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
# https://stackoverflow.com/questions/47310537/how-to-change-zsh-autosuggestions-color/53070834#53070834
# https://github.com/zsh-users/zsh-autosuggestions/issues/12
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1


# zsh-users/zsh-syntax-highlighting
# set what highlighters will be used.
# see https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# customize the main highlighter styles.
# see https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
# typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[comment]='fg=242'
