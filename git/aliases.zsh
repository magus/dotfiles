#use `hub` as git wrapper
#hub breaks git autocomplete...fail
#eval "$(hub alias -s)"

alias grm='git rm $(git ls-files --deleted)'

# gall -- execute command on all git repos in current directory
# e.g. gall status -s
gall() { find . -type d -follow -exec sh -c "(cd '{}' && [[ -d .git ]] && echo {} && git $* && echo)" ';'; }
