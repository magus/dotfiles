#!/bin/bash

# bootstrap.sh
# set up the initial zsh and some dependencies
# make dem dotfiles

function e_header()   { echo -e "\n\n\033[1;35m(STAR UNICODE CHARACTER)\033[0m  $@"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }


#git?
#if [[ "$(which git | grep -w 'not found')" ]]; then
if [[ "$(which git | echo $?)" -ne 0 ]]; then
	e_arrow 'git not installed'
else
	e_success 'git installed'
fi

