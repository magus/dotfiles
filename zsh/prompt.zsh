# prompt definitions

autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
	echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
	st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
	if [[ $st == "" ]]
	then
		echo ""
	else
		if [[ $st == "nothing to commit (working directory clean)" ]]
    then
			echo "%{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
			echo "%{$fg_bold[red]%}$(git_prompt_info)*%{$reset_color%}"
    fi
	fi
}

git_prompt_info () {
	ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
	# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
	echo "${ref#refs/heads/}"
}

unpushed () {
	/usr/bin/git cherry -v @{upstream} 2>/dev/null
}

need_push () {
	if [[ $(unpushed) == "" ]]
	then
		echo " "
	else
		echo " %{$fg[magenta]%}%Bunpushed%b%{$reset_color%} "
	fi
}


git_prompt_color() {
	st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
	if [[ $st == "" ]]
	then
		echo "%{$fg_bold[white]%}⇨  %{$reset_color%}"
	else
		if [[ $st == "nothing to commit (working directory clean)" ]]
    then
			if [[ $(unpushed) == "" ]]
			then
				echo "%{$fg_bold[green]%}⇨  %{$reset_color%}"
			else
				echo "%{$fg[magenta]%}⇨  %{$reset_color%} "
			fi
    else
			echo "%{$fg_bold[red]%}⇨  %{$reset_color%}"
    fi
	fi
}

#number of todo items
#props @holman
todo_num(){
	if $(which todo &> /dev/null)
	then
		num=$(echo $(todo ls | wc -l))
		let todos=num-2
		if [ $todos != 0 ]
		then
			echo "$todos"
		else
			echo ""
		fi
	else
		echo ""
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
	export RPROMPT="$(git_dirty)$(need_push)%{$fg_bold[cyan]%}[$(todo_num)]%{$reset_color%}"
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
#export PROMPT=$'\n$(user_name)@$(host_name) in $(path_abbv)\n%{$fg_bold[red]%}⇨  %{$reset_color%}'
