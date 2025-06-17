# Setup fzf
# ---------
# find fzf from brew prefix
BREW_PREFIX=$(brew --prefix)
if [[ ! "$PATH" == */${BREW_PREFIX}/opt/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}${BREW_PREFIX}/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${BREW_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${BREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"

# respect gitignore by feeding fzf with ripgrep
export FZF_DEFAULT_COMMAND="rg --files --hidden"

# apply the command to CTRL+T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
