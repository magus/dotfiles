# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

# respect gitignore by feeding fzf with ripgrep
export FZF_DEFAULT_COMMAND="rg --files --hidden"

# apply the command to CTRL+T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
