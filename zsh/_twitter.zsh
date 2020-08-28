############################
# Don't edit this file
# Instead, put any customisations or personal bash preferences into the file ~/.local.bash
############################

export RAILS_ENV='development'
export RUBY_HEAP_MIN_SLOTS=500000
export RUBY_HEAP_SLOTS_INCREMENT=250000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=50000000
export RUBY_HEAP_FREE_MIN=4096

export LC_CTYPE=en_US.UTF-8

export PATH="/opt/twitter/bin:/opt/twitter/sbin:/usr/local/mysql/bin:${HOME}/bin":$PATH

## rvm
[[ -s "/opt/twitter/rvm/scripts/rvm" ]] && source "/opt/twitter/rvm/scripts/rvm"

## Java: set JAVA_HOME for Maven and other Java tools
# /usr/libexec/java_home should print the path to the most recently JDK
JAVA_HOME_VALUE=`/usr/libexec/java_home`
if [[ -e "${JAVA_HOME_VALUE}" && "${JAVA_HOME_VALUE}" != "(null)" ]]; then
  export JAVA_HOME="${JAVA_HOME_VALUE}"
fi

# User configurations are stored in .local.bash
[[ -s "${HOME}/.local.bash" ]] && source "${HOME}/.local.bash"

# dottools: add distribution binary directories to PATH
if [ -r "$HOME/.tools-cache/setup-dottools-path.sh" ]; then
  . "$HOME/.tools-cache/setup-dottools-path.sh"
fi

############################
# Don't edit this file
# Instead, put any customisations or personal bash preferences into the file ~/.local.bash
############################

## Commented out below
# Automatically placed at end of file by MDE. To disable this behavior: touch ~/.no-mde-dotfile. Ideally you do not need to do this. Please contactmde-support@twitter.com to discuss long-term alternatives.
# source /opt/twitter_mde/etc/bash_profile
source "$HOME/.dotfiles/zsh/_twitter_mde"
npm config delete prefix
npm config delete registry
