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
			echo "on %{$fg_bold[green]%}$(git_prompt_info)%{$reset_color%}"
    else
			echo "on %{$fg_bold[red]%}$(git_prompt_info)*%{$reset_color%}"
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
		echo " with %{$fg[magenta]%}%Bunpushed%b%{$reset_color%} "
	fi
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo_num(){
	if $(which todo &> /dev/null)
	then
		num=$(echo $(todo ls +next | wc -l))
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

export PROMPT=$'\n$(user_name)@$(host_name) in $(path_abbv) $(git_dirty)$(need_push)\n› '
set_prompt () {
	export RPROMPT="%{$fg_bold[cyan]%}$(todo_num)%{$reset_color%}"
}

precmd() {
	title "zsh" "%m" "%55<...<%~"
	set_prompt
}
