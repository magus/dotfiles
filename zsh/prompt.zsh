# prompt definitions

autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
    echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
    st=$(git status 2>/dev/null | tail +4 | head -n 1)
    if [[ $st == "" ]]
    then
        echo "%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
        if [[ "$st" =~ ^nothing ]]
        then
            echo "%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
        else
            echo "%{$fg_bold[red]%}$(git_prompt_info)*%{$reset_color%}"
        fi
    fi
}

git_prompt_info () {
    ref=$(git symbolic-ref HEAD 2>/dev/null) || return
    # echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
    echo "${ref#refs/heads/}"
}

unpushed () {
    git cherry -v @{upstream} 2>/dev/null
}

need_push () {
    if [[ $(unpushed) == "" ]]
    then
        echo ""
    else
        echo "%{$fg[magenta]%}%Bunpushed%b%{$reset_color%}"
    fi
}


git_prompt_color() {
    # detect non-git repo
    notGit=$(git rev-parse --git-dir 2>/dev/null);
    if [[ $notGit == "" ]]
    then
        echo "%{$fg_bold[yellow]%}⇨  %{$reset_color%}"
    else
        st=$(git status 2>/dev/null | tail -n 1)
        if [[ "$st" =~ ^nothing ]]
        then
            if [[ $(unpushed) == "" ]]
            then
                echo "%{$fg_bold[green]%}⇨  %{$reset_color%}"
            else
                echo "%{$fg[magenta]%}⇨  %{$reset_color%}"
            fi
        else
            echo "%{$fg_bold[red]%}⇨  %{$reset_color%}"
        fi
    fi
}

user_name(){
    echo "%{$fg_bold[green]%}%B%n%b%{$reset_color%}"
}

host_name(){
    echo "%{$fg[yellow]%}%m%{$reset_color%}"
}

path_abbv(){
    echo "%{$fg_bold[white]%}${PWD/#$HOME/~}%{$reset_color%}"
}

set_right_prompt () {
    export RPROMPT="$(git_dirty) $(need_push)"
}





#special zsh function
#executed just before each prompt

precmd() {
    title "zsh" "%m" "%55<...<%~"
    set_right_prompt
}

#minimal prompt
export PROMPT=$'$(git_prompt_color)'

#heavy prompt
#export PROMPT=$'\n$(user_name)@$(host_name) in $(path_abbv)\n$(git_prompt_color)'
