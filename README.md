# dotfiles

## todo
* use star unicode character for header, or another cool icon
* syntax highlighting (py, js, html, etc.)


## dotfiles.sh
* backup existing dotfiles before beginning import
* e.g. .dotfiles/backup/%Y-%M-%D.... (cowboy dotfiles)
* file install initial stuff (e.g. xcode command line tools, brew, etc.)
* brew install (zsh, git, tree, etc.)
* check brew list for anything that we should add to initial brew installs
* copy the .files in ~ to .dotfiles in appropriate folders
* e.g.  .vimrc, todo, etc.
* symlink dotfiles to appropriate places (holman/cowboy dotfiles)
* 'link' folders should be linked to ~/.command/ (e.g. todo/link > ~/.todo/)

## todo.sh
* sudo easy_install --dry-run python-gflags httplib2 google-api-python-client
* installs dependencies add to dotfiles setup

* in ~/.private/ set google api and secret for `todo google`
* first use will prompt for auth and save credentials to ~/.oauth/google/.tasks.dat


