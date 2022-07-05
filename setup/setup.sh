#!/bin/bash

cat << EOF >> /etc/profile.d/colors.sh
export LESSOPEN="| /usr/bin/src-hilite-lesspipe.sh %s"
export LESS=' -R '
alias ls="ls --color=auto"
alias dir="dir --color=auto"
alias grep="grep --color=auto"
PS1='\[\e[0;38;5;007m\]\u@\[\e[0;38;5;223m\]\h \w \$\[\e[0;38;5;177m\] '
EOF

chmod +x /etc/profile.d/colors.sh
