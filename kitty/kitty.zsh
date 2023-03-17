
# any custom commands to further setup kitty in zsh

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# display image in kitty
# https://sw.kovidgoyal.net/kitty/kittens/icat.html
alias icat="kitty +kitten icat"

# kitten for side-by-side diff
alias diff="kitty +kitten diff"

# ssh override for kitty
# https://sw.kovidgoyal.net/kitty/faq.html#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-when-sshing-into-a-different-computer
alias kssh="kitty +kitten ssh"
