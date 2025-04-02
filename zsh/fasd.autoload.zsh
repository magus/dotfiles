#!/bin/bash

eval "$(fasd --init auto)"
# command above is equivalent to below
# https://github.com/clvv/fasd#introduction
#
# alias a='fasd -a'        # any
# alias s='fasd -si'       # show / search / select
# alias d='fasd -d'        # directory
# alias f='fasd -f'        # file
# alias sd='fasd -sid'     # interactive directory selection
# alias sf='fasd -sif'     # interactive file selection
# alias z='fasd_cd -d'     # cd, same functionality as j in autojump
# alias zz='fasd_cd -d -i' # cd with interactive selection

# `,` can be used to allow tab completion mid command
# https://github.com/clvv/fasd#tab-completion
#
# $ vim ,rc,lo<Tab>
# $ vim /etc/rc.local
#
# $ mv index.html d,www<Tab>
# $ mv index.html /var/www/
