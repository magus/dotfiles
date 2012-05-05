#use `hub` as git wrapper
#hub breaks git autocomplete...fail
#eval "$(hub alias -s)"

#git aliases
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
