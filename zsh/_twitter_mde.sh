#! /bin/bash
set -m
setopt monitor

# File sourced by MDE users' .bash_profile and .zlogin files

__MDESHELL="sh";
[[ -n "$BASH_VERSION" ]] && __MDESHELL="bash"
[[ -n "$ZSH_VERSION" ]] && __MDESHELL="zsh"

__source_if_exists() {
  # sources a file if it exists
  # $1 = file to source
  [[ -f "$1" ]] && . "$1"
}

# OSX has a default FD soft limit of 256 which is often unhelpfully low.
ulimit -Sn 10000

# On Mac OS X, MDE is installed in /opt/twitter_mde,
# while on Linux, MDE is installed in ~/.twitter_mde
if [[ -d "$HOME/.twitter_mde/bin" ]] || [[ "$(uname)" != 'Darwin' ]]; then
  MDE_BASE_DIR="$HOME/.twitter_mde"
  IS_USER_MDE=1
else
  MDE_BASE_DIR='/opt/twitter_mde'
  IS_USER_MDE=0
fi

# Add MDE full Homebrew packages to PATH
if [[ -d "$MDE_BASE_DIR/homebrew/mde_bin" ]]; then
  export PATH="$MDE_BASE_DIR/homebrew/mde_bin:$PATH"
fi

# Add MDE minimal Homebrew packages to PATH (preferred)
if [[ -d "$MDE_BASE_DIR/homebrew_minimal/mde_bin" ]]; then
  export PATH="$MDE_BASE_DIR/homebrew_minimal/mde_bin:$PATH"
fi

# Set JAVA_HOME to point to the Twitter JDK
if [[ -d /Library/Java/JavaVirtualMachines/TwitterJDK/Contents/Home ]]; then
  export JAVA_HOME=/Library/Java/JavaVirtualMachines/TwitterJDK/Contents/Home
fi

# Add MDE packages to PATH
export PATH="$MDE_BASE_DIR/bin:$PATH"

# Append Node module global dirs to PATH
#
# MDE installed global packages will have precedence over
# user installed global packages.
#if [[ -L "$MDE_BASE_DIR/bin/node" ]]; then
#  export PATH="$PATH:/opt/twitter_mde/data/node/bin:/Users/$LOGNAME/.npm-global/bin"
#fi

# zsh: load bash completion compatibility
if [[ $__MDESHELL = "zsh" ]]; then
  autoload -Uz bashcompinit && bashcompinit
fi

# "arc" command completions
# __source_if_exists /opt/twitter_mde/package/arc/current/arcanist/resources/shell/bash-completion

# "pants" command completions
# __source_if_exists /opt/twitter_mde/etc/pants.complete.bash

# CI Team bash helpers from eng.team.ci
__source_if_exists /opt/twitter_mde/etc/ci_bash_tools.bash

GIT_COMPLETION_DIR=/opt/twitter_mde/package/source_git/current/share/git-core/contrib/completion
# "git" command completion
# not for zsh - DX-1880
if [[ $__MDESHELL = "bash" ]]; then
  __source_if_exists "$GIT_COMPLETION_DIR"/git-completion.bash
fi

# # git prompt
# # Only set if PS1 is still default (i.e., user hasn't customized it).
# get_default_ps1() (
#   TEMP="$(/usr/bin/mktemp -d -t TEMP.XXXXXXX)" || die "failed to make tmpdir"
#   function cleanup() { [[ -n "${TEMP:-}" ]] && /bin/rm -rf "${TEMP}"; }
#   # `\\` to ensure this doesn't invoke an alias the user might have defined
#   # (in bash, aliases trump functions)
#   trap \\cleanup EXIT
#   # os x changes the default PS1 in /etc/profile, so we can't use --no-profile
#   # the user might have changed their PS1 in ~/.bash_profile, so omitting --noprofile is problematic
#   # if we change HOME, then we ignore their ~/ configs and still pick up /etc/profile
#   # /usr/bin/env -i HOME="$TEMP" /bin/bash --login -ic 'echo "$PS1"'
#   /usr/bin/env -i HOME="$TEMP" /bin/bash --login -im
# )



# if [[ "$PS1" == "$(get_default_ps1)" || "$PS1" == '[\h \[\033[0;36m\]\W\[\033[0m\]]\$ ' ]]; then
#   echo "inside ps1 default"
#   __source_if_exists "$GIT_COMPLETION_DIR"/git-prompt.sh
#   export PS1='[\h \[\033[0;36m\]\W\[\033[0m\]$(__git_ps1 " \[\033[1;32m\](%s)\[\033[0m\]")]\$ '
# fi
